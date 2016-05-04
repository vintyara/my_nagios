module MyNagios
  module ChecksHelper

    def human_time(time)
      return '-' unless time
      "#{((Time.now - time) / 60).to_i} minutes ago"
    end

    def status_to_label(status)
      return 'danger' if status.eql?('critical')

      status
    end

  end
end
