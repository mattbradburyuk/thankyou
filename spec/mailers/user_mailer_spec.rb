require "spec_helper"

describe UserMailer do
  describe "password_reset" do
    let(:user) { FactoryGirl.create(:user, :password_reset_token => "anything")  }
    let(:mail) { UserMailer.password_reset(user) }
    
    describe "email format"  do
      it "sends user password reset url" do
        mail.subject.should eq("Password Reset")
        mail.to.should eq([user.email])
        mail.from.should eq(["from@example.com"])
      end

      it "renders the body" do
        mail.body.encoded.should match("To reset your password click the URL below.")
      end

      it "has the reset link" do
        mail.body.encoded.should match(edit_password_reset_path(user.password_reset_token))
      end
    end
  end
end




