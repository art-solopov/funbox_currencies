require 'rails_helper'

RSpec.describe CurrencyRate, type: :model do
  include FactoriesHelper

  describe 'validations' do
    subject { create }
    it { expect(subject).to be_valid }

    describe 'value presence' do
      before { subject.value = nil }
      it { expect(subject).to be_invalid }
    end

    describe 'value numericality' do
      before { subject.value = -10 }
      it { expect(subject).to be_invalid }
    end

    describe 'forced until should be future' do
      before { subject.forced_until = 1.day.ago }
      it { expect(subject).to be_invalid }
    end
  end

  describe '.current' do
    subject { described_class.current }

    before do
      10.downto(7) { |i| create_hours_ago(i) }
    end

    it { expect(subject).to eq described_class.last }

    context 'should return a current forced value' do
      let(:first_forced) do
        build(forced_until: 14.hours.from_now)
      end

      before do
        Timecop.freeze(5.hours.ago) { first_forced.save }

        create_hours_ago(4)
      end

      it { expect(subject).to eq first_forced }

      context 'the latest one' do
        let(:second_forced) do
          build(forced_until: 12.hours.from_now)
        end

        before do
          Timecop.freeze(3.5.hours.ago) { second_forced.save }
          create_hours_ago(3)
        end

        it { expect(subject).to eq second_forced }
      end

      context 'only if not expired' do
        before { Timecop.travel(1.day.from_now) }
        after { Timecop.return }

        it { expect(subject).to eq described_class.last }
      end
    end
  end

  describe '.fetch_data', vcr: { record: :new_episodes } do
    before { described_class.fetch_data! }

    it { expect(described_class.last.value).to eq(59) }
  end

  describe '#create_notification' do
    let(:build_options) { {} }

    subject(:record) { build(**build_options) }
    subject(:queue) { CurrencyRatePublishingWorker.jobs }

    before do
      queue.clear
      Timecop.freeze
    end

    after do
      Timecop.return
    end

    it { expect { record.save }.to change(queue, :size).by(1) }

    context 'forced' do
      let(:forced_time) { 3.days.from_now }
      let(:build_options) { { forced_until: forced_time } }
      before { record.save }

      it { expect(queue.size).to eq(2) }
      it { expect(queue.last['at']).to eq(forced_time.to_f) }
    end
  end
end
