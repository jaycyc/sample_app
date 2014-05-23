require 'spec_helper'

describe "StaticPages" do

    subject { page }

	let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "Home page" do

    it "should have the content 'Sample App'" do
	    visit root_path
	    expect(page).to have_content('Sample App')
    end
	it "should have the base title" do
		visit '/static_pages/home'
		expect(page).to have_title ("Ruby on Rails Tutorial Sample App")
	end

    it "should not have a custom page title" do
        visit'/static_pages/home'
        expect(page).not_to have_title('| Home')
    end
  end

  describe "Help page" do
	it "should have the content 'Help'" do
		visit help_path
		expect(page).to have_content('Help')
	end
	it "should have the right title" do
		visit '/static_pages/help'
		expect(page).to have_title ("Ruby on Rails Tutorial Sample App | Help")
	end

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
		
  end

  describe "About page" do
	  it "should have the content 'About us'" do
		  visit about_path
		  expect(page).to have_content('About Us')
	  end
	it "should have the right title" do
		visit '/static_pages/about'
		expect(page).to have_title ("Ruby on Rails Tutorial Sample App | About Us")
	end

  end

  describe "Contact page" do
	  it "should have the content 'Contact'" do
		  visit contact_path 
		  expect(page).to have_content('Contact')
	  end

	  it "should have the title 'Contact'" do
		  visit '/static_pages/contact'
		  expect(page).to have_title("#{base_title} | Contact")
	  end
  end


end
