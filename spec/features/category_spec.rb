require 'rails_helper'

RSpec.describe 'IndexCategories', type: :system do
  before do
    driven_by(:rack_test)
  end

  before(:each) do
    @user = User.new(name: 'Dino', email: 'dino@mail.com', password: '123456')
    @user.skip_confirmation!
    @user.save
    @category = Category.create(name: 'utilities', icon: 'utilities', user: @user)
    @operation = @category.operations.create(name: 'internet', amount: 20, user: @user)
    sign_in(@user)
    visit '/categories'
  end

  it 'Redirected to /categories/new after clicking on Food button' do
    click_on('New category')
    expect(page.body).to include('New category')
    expect(current_path).to eq('/categories/new')
  end

  it 'Should show food information' do
    click_on('New category')
    expect(page.body).to include('Name')
    expect(page.body).to include('Select an icon from the list')
  end
end
