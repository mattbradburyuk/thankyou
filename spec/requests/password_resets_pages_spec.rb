require 'spec_helper'

describe 'Password reset' do
	describe "shows forgotten password page" do

	  before do
			visit signin_path
			click_link('forgotten password?')
		end

			it {page.should have_title "Ruby on Rails Template | Password Reset"}
			it { page.should have_content("Reset Password")}
	end

	describe "sends password reset" do

	  let(:user) { FactoryGirl.create(:user)  }
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

	describe "does not send password reset to invalid user" do

	  let(:user) { FactoryGirl.create(:user)  }
		before do
			visit signin_path
			click_link('forgotten password?')
			fill_in 'Email', :with => "madeupuser@example.com"
			click_button "Reset Password"
		end

			it {page.should have_title "Ruby on Rails Template"}
	    it {page.should have_content("reset failed")}
	    it {last_email.should be_nil}
	end

	describe "shows password reset page" do
	  let(:user) { FactoryGirl.create(:user)}

	  before do
	  	user.send_password_reset
	  	visit edit_password_reset_path(user.password_reset_token)
	  end

	  it {page.should have_content("Password confirmation")}
	end

	describe "resets password" do
	  let(:user) { FactoryGirl.create(:user)}
	
	  before do
	  	user.send_password_reset
	  	visit edit_password_reset_path(user.password_reset_token)
	  	fill_in 'Password', :with => "newpassword"
	  	fill_in 'Password confirmation', :with => "newpassword"
	  	click_button 'Update Password'
	  end

	  it "should sign in with new password" do 
	  	visit signin_path
	  	fill_in 'Email', :with => user.email
	  	fill_in 'Password', :with => "newpassword"
	  	click_button 'Sign in'
	  	visit root_path

	  	page.should have_content(user.name)
	  end
	
	  it "should not sign in with old password" do 
	  	visit signin_path
	  	fill_in 'Email', :with => user.email
	  	fill_in 'Password', :with => "foobar"
	  	click_button 'Sign in'
	  	visit root_path
	  	
	  	page.should have_content("Rails Template")
	  end
	end


end


