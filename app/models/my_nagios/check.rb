module MyNagios
  class Check < ActiveRecord::Base
    belongs_to :group

    enum status:  [ :info, :success, :critical ]
    enum state:   [ :completed, :running ]

    scope :enabled, -> { where(enabled: true) }

    def run!
      begin
        self.update(state: :running)

        Net::SSH.start( self.host, self.user, config: true, keys: [self.pem_key], non_interactive: true ) do| ssh |
          result = ssh.exec! self.command
          self.update(state: :completed, status: self.determinate_status_by_response(result), latest_state: result, latest_updated_at: Time.now)
        end
      rescue => e
        self.update(state: :completed, status: :info, latest_state: e, latest_updated_at: Time.now)
      end
    end

    def self.multiple_run!(check_ids, config)
      check_list = MyNagios::Check.where(id: check_ids)

      begin
        check_list.update_all(state: :running)

        Net::SSH.start( config['host'], config['user'], config: true, keys: [config['pem_key']], non_interactive: true ) do |ssh|
          check_list.each do |check|
            result = ssh.exec! check.command
            check.update(state: :completed, status: check.determinate_status_by_response(result), latest_state: result, latest_updated_at: Time.now)
          end
        end

      rescue => e
        check_list.update_all(state: :completed, status: :info, latest_state: e, latest_updated_at: Time.now)
      end
    end

    def determinate_status_by_response(response)
      return :critical if not regexp.blank? and response =~ /#{regexp}/
      return :critical if not response.scan('CRITICAL').blank?
      return :info     if response.nil? or not response.scan('No such file or directory').blank?
      :success
    end
  end
end
