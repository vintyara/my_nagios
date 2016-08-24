require_dependency "my_nagios/application_controller"

module MyNagios
  class ChecksController < ApplicationController
    before_filter :find_check,  only: [:run_now, :toggle, :edit, :update]
    before_filter :find_groups, only: [:new, :create, :edit]

    def new
      @check = Check.new
    end

    def create
      @check = Check.create(params_check)
      redirect_to root_path
    end

    def edit
    end

    def update
      @check.update(params_check)
      redirect_to root_path
    end

    def run_now
      @check.run!

      respond_to do |format|
        format.js { render layout: false }
      end
    end

    def toggle
      @check.toggle! :enabled

      respond_to do |format|
        format.js { render layout: false }
      end
    end

    def group_action
      check_ids = params["group_action_check_ids"].split(',')
      redirect_to root_path and return if check_ids.blank?

      case params['check_group_action'].downcase
      when 'disable'
        Check.where(id: check_ids).update_all(enabled: false)
      when 'enable'
        Check.where(id: check_ids).update_all(enabled: true)
      when 'snooze for'
        Check.where(id: check_ids).update_all(snooze_for: (Time.now + params['snooze_time_select'].to_i.minutes))
      end

      redirect_to root_path
    end

    private

    def find_check
      @check = Check.find(params[:id])
    end

    def find_groups
      @groups = MyNagios::Group.all
    end

    def params_check
      params.require(:check).permit(:host, :user, :pem_key, :description, :interval, :command, :additional_command, :regexp, :group_id)
    end
  end
end
