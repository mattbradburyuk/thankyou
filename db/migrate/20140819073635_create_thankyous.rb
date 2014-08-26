class CreateThankyous < ActiveRecord::Migration
  def change
    create_table :thankyous do |t|

      t.string :message
      t.integer :sender_id #works
      t.integer :recipient_id
      t.boolean :email_sent
      t.boolean :seen
      t.boolean :acknowledged

      t.timestamps
    end
  end
end
