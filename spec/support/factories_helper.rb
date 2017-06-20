module FactoriesHelper
  extend ActiveSupport::Concern

  def default_factory
    described_class.name.underscore.to_sym
  end

  %i[build create].each do |method|
    define_method(method) do |factory = default_factory, **options|
      FactoryGirl.send(method, factory, **options)
    end
  end

  def create_when(time, factory = default_factory, **options)
    Timecop.freeze(time) { create(factory, **options) }
  end

  def create_hours_ago(hrs, factory = default_factory, **options)
    create_when(hrs.hours.ago, factory, **options)
  end
end
