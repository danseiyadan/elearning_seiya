class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.references :user, null: false, foreign_key: true
      t.references :action, polymorphic: true, null: false

      t.timestamps
    end
  end
end
