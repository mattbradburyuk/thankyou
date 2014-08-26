class Thankyou < ActiveRecord::Base


  belongs_to :sender, class_name: "User" # note, implied FK "sender_id"
  belongs_to :recipient, class_name: "User"

end
