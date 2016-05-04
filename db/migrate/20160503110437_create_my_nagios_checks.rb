class CreateMyNagiosChecks < ActiveRecord::Migration
  def change
    create_table :my_nagios_checks do |t|
      t.integer :group_id
      t.string  :host
      t.string  :user
      t.string  :pem_key

      t.string  :description
      t.integer :interval
      t.text    :command

      t.text    :latest_state

      t.integer :status, default: 0
      t.integer :state, default: 0

      t.datetime :latest_updated_at

      t.boolean :enabled, default: true

      t.timestamps null: false
    end
  end
end
