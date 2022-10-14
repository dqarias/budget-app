require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:each) do
    @user = User.new(name: 'Dino', email: 'dino@mail.com', password: '123456')
    @user.skip_confirmation!
    @user.save
    @category = Category.create(name: 'utilities', icon: 'icon1.png', user: @user)
    @operation = @category.operations.create(name: 'grape', amount: 20, user: @user)
  end

  it 'Should has a valid value' do
    expect(@operation).to be_valid
  end

  it 'Name is required' do
    @operation.name = nil
    expect(@operation).to_not be_valid
  end
end