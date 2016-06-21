class AdditionalCommand < ActiveRecord::Migration
  def change
    add_column :my_nagios_checks, :additional_command, :text, default: nil
  end
end
