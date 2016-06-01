class AddRegexpToCheck < ActiveRecord::Migration
  def change
    add_column :my_nagios_checks, :regexp, :string, default: nil
  end
end
