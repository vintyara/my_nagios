Rails.application.routes.draw do

  mount MyNagios::Engine => "/my_nagios"
end
