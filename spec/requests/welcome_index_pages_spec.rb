#encoding : utf-8
require 'spec_helper'
describe 'test' do
  before { visit root_path }

  describe 'Welcome index pages' do
  subject { page }

    it { should have_selector('title', text: '韶关铁通业务运营支撑系统') }
    it { should have_content('韶关铁通业务运营支撑系统') }
    it { should have_selector('input', :type => 'text') }
    it { should have_selector('input', :type => 'password') }
    it { should have_selector('input', :type => 'checkbox') }
    it { should have_content('登录系统') }
    it { should have_content('记住我') }
    it { should have_button('登录系统') }
  end


  it 'with valid infomation' do
    #subject { page }

    visit root_path
    fill_in 'name', :with => 'yiqf'
    fill_in 'pass', :with => '123456'
    click_on '登录系统'
    current_path.should eql(root_path)
    #current_path.should eql(welcome_main_path)
    #session[:user_id].equal 2
    #response.should redirect_to('/welcome/main')
    #page.should have_selector('h1', text: '欢迎您登录韶关铁通业务运营支撑系统')

  end

  it 'with invalid infomation' do
    #subject { page }
    #visit root_path
    fill_in 'name', with: ''
    fill_in 'pass', with: ''

    click_button '登录系统'
    page.should have_selector('input', type: 'text')
    page.should have_selector('input', type: 'password')
    page.should have_selector('input', type: 'checkbox')
  end
end



