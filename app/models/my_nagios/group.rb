module MyNagios
  class Group < ActiveRecord::Base
    has_many :checks
  end
end