require 'rails_helper'

RSpec.describe 'Operation controller', type: :request do
  before(:each) do
    @user = User.new(name: 'Dino', email: 'dino@mail.com', password: '123456')
    @user.skip_confirmation!
    @user.save
    @category = Category.create(name: 'utilities', icon: 'utilities', user: @user)
    @operation = @category.operations.create(name: 'internet', amount: 20, user: @user)
    sign_in(@user)
  end

  it 'Returns http sucess' do
    get category_operations_path(@category)
    expect(response).to have_http_status(200)
  end

  it 'renders index template' do
    get category_operations_path(@category)
    expect(response).to render_template(:index)
  end

  it 'includes the correct text on its body' do
    get category_operations_path(@category)
    expect(response.body).to include('internet')
  end
end
