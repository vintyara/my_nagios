class CreateMyNagiosGroups < ActiveRecord::Migration
  def change
    create_table :my_nagios_groups do |t|
      t.string  :name
      t.timestamps null: false
    end
  end
end
