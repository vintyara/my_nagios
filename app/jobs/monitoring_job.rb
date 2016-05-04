class MonitoringJob
  include Sidekiq::Worker

  sidekiq_options queue: 'my_nagios_monitoring'
  sidekiq_options retry: false

  def perform(checks, config)
    MyNagios::Check.multiple_run!(checks, config)
  end
end