#encoding : utf-8
require 'spec_helper'
describe 'test' do
  subject { page }

  describe 'Welcome index pages' do
    before { visit root_path }

    it { should have_selector('title', text: '韶关铁通业务运营支撑系统') }
    it { should have_content('韶关铁通业务运营支撑系统') }
    it { should have_selector('input', :type => 'text') }
    it { should have_selector('input', :type => 'password') }
    it { should have_selector('input', :type => 'checkbox') }
    it { should have_content('登录系统') }
    it { should have_content('记住我') }
    it { should have_button('登录系统') }
  end


  describe 'with valid infomation' do
    #subject { page }
    let(:user) { FactoryGirl.create(:user) }

    before do
      visit root_path
      fill_in 'name', with: user.name
      fill_in 'pass', with: user.password
      click_button '登录系统'
    end

    it { should have_content('程控业务相关') }
    #current_path.should eql(root_path)
    #current_path.should eql(welcome_main_path)
    #session[:user_id].equal 2
    #response.should redirect_to('/welcome/main')
    #page.should have_selector('h1', text: '欢迎您登录韶关铁通业务运营支撑系统')

  end

  describe 'with invalid infomation' do
    #subject { page }
    before do
      visit root_path
      click_button '登录系统'
    end

    it { should have_selector('input', type: 'text') }
    it { should have_selector('input', type: 'password') }
    it { should have_selector('input', type: 'checkbox') }
  end
end



