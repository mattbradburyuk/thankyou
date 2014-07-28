require 'spec_helper'

describe 'Password reset' do
	describe "shows password reset page" do

	  before do
			visit signin_path
			click_link('forgotten password?')
		end

			it {page.should have_title "Ruby on Rails Template | Password Reset"}
			it { page.should have_content("Reset Password")}
	end

	describe "sends password reset" do

	  let(:user) { FactoryGirl.create(:user, :password_reset_token => "anything")  }
		before do
			visit signin_path
			click_link('forgotten password?')
			fill_in 'Email', :with => user.email
			click_button "Reset Password"
		end

			it {page.should have_title "Ruby on Rails Template"}
	    it {page.should have_content("Email sent")}
	    it {last_email.to.should include(user.email)}

	end

end
