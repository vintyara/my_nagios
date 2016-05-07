require_dependency "my_nagios/application_controller"

module MyNagios
  class ChecksController < ApplicationController
    before_filter :find_check, only: [:run_now, :toggle]

    def new
      @check = Check.new
    end

    def create
      @check = Check.create(params_check)
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

    private

    def find_check
      @check = Check.find(params[:id])
    end

    def params_check
      params.require(:check).permit(:host, :user, :pem_key, :description, :interval, :command)
    end
  end
end
