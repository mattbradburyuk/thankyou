require 'spec_helper'


# t.string   "message"
# t.integer  "sender_id"
# t.integer  "recipient_id"
# t.boolean  "email_sent"
# t.boolean  "seen"
# t.boolean  "acknowledged"
# t.datetime "created_at"
# t.datetime "updated_at"

describe Thankyou do

  before { @thankyou = Thankyou.new(recipient_id: 1,
                                    sender_id: 1,
                                    message:"This is a test message",
                                    email_sent: TRUE,
                                    seen: TRUE,
                                    acknowledged: TRUE)}
  subject { @thankyou }

  it { should respond_to(:recipient) }
  it { should respond_to(:sender)}
  it { should respond_to(:message)}
  it { should respond_to(:email_sent)}
  it { should respond_to(:seen)}
  it { should respond_to(:acknowledged)}

  it { should be_valid }


end