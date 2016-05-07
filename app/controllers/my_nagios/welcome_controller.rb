require_dependency "my_nagios/application_controller"

module MyNagios
  class WelcomeController < ApplicationController

    def index
      @group      = Group.all.includes(:checks)
      @criticals  = Check.enabled.where(status: Check.statuses[:critical])
    end

  end
end
