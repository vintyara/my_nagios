class MonitoringJob
  include Sidekiq::Worker

  sidekiq_options queue: 'my_nagios_monitoring'
  sidekiq_options retry: false

  def perform(checks, config = nil)
    if config
      MyNagios::Check.multiple_run!(checks, config)
    else
      MyNagios::Check.run!(checks)
    end
  end
end