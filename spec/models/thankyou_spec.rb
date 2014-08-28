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

  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }

  # before { @thankyou = user.thankyous.build(message: "This is a test message") }


  before { @thankyou = Thankyou.new(recipient_id: user1.id ,
                                    sender_id: user2.id,
                                    message: "This is a test message",
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

  describe "when sender_id is not present" do
    before { @thankyou.sender_id = nil }
    it { should_not be_valid }
  end

  describe "when recipient_id is not present" do
    before { @thankyou.recipient_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @thankyou.message = " " }
    it { should_not be_valid }
  end





end