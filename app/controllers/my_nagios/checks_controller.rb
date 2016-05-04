require_dependency "my_nagios/application_controller"

module MyNagios
  class ChecksController < ApplicationController
    def new
      @check = Check.new
    end

    def create
      @check = Check.create(params_check)
      redirect_to root_path
    end

    def run_now
      @check = Check.find(params[:id])
      return unless @check

      @check.run!
    end

    private

    def params_check
      params.require(:check).permit(:host, :user, :pem_key, :description, :interval, :command)
    end
  end
end
