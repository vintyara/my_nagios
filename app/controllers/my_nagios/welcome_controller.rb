require_dependency "my_nagios/application_controller"

module MyNagios
  class WelcomeController < ApplicationController

    before_filter :find_criticals, only: [:index, :autorefresh]

    def index
      @group = Group.all.includes(:checks)
    end

    def autorefresh
      respond_to do |format|
        format.js { render layout: false }
      end
    end

    private

    def find_criticals
      @criticals = Check.enabled.where(status: Check.statuses[:critical])
    end

  end
end
