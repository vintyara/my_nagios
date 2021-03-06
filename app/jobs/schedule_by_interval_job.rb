class ScheduleByIntervalJob
  include Sidekiq::Worker

  sidekiq_options queue: 'my_nagios_monitoring'

  def perform(options, one_by_one = false)

    # Run each Check separately (new ssh connection for each check even common host)
    if one_by_one
      MyNagios::Check.enabled.not_snoozed.where(interval: options['interval']).each do |check|
        MonitoringJob.perform_async(check)
      end

      return
    end

    # Optimized variant, group checks, run all necessary checks with one ssh connection
    MyNagios::Check.enabled.not_snoozed.where(interval: options['interval']).group_by{|check| { host: check.host, user: check.user, pem_key: check.pem_key } }.each do |config, checks|
      MonitoringJob.perform_async(checks.map(&:id), config)
    end
  end
end