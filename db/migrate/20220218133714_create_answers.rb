class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.references :lesson, null: false, foreign_key: true
      t.references :word, null: false, foreign_key: true
      t.references :choice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
