module MyNagios
  module ChecksHelper

    def human_time(time)
      return '-' unless time

      distance_of_time_in_words(time, Time.now) + ' ago'
    end

    def status_to_label(status)
      return 'danger' if status.eql?('critical')

      status
    end

  end
end
