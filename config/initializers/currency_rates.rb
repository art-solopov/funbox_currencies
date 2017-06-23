currency_rates_config = Rails.application.config_for(:currency_rates)

Rails.application.config.currency_rates = currency_rates_config

if Sidekiq.server?
  hrs = currency_rates_config['every_hours']
  cron = if hrs < 1
           "*/#{(hrs * 60).to_i} * * * *"
         else
           "0 */#{hrs} * * *"
         end

  cr_cron_job = {
    'currency_rates_publish' => {
      'class' => 'CurrencyRatePublishingWorker',
      'cron' => cron
    }
  }

  errors = Sidekiq::Cron::Job.load_from_hash cr_cron_job
  Rails.logger.error(errors) unless errors.empty?
end
