class AddSnoozeForCheck < ActiveRecord::Migration
  def change
    add_column :my_nagios_checks, :snooze_for, :datetime, default: nil
  end
end
