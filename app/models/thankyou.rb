class Thankyou < ActiveRecord::Base


  belongs_to :sender, class_name: "User" # note, implied FK "sender_id"
  belongs_to :recipient, class_name: "User"

  validates :message,  presence: true
  validates :recipient_id,  presence: true
  validates :sender_id,  presence: true

end
