require 'rails_helper'

RSpec.describe "ItemLists for auth user", type: :request do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  after(:each) do
    sign_out @user
    @user.destroy
  end

  it 'can listing item_lists' do
    get item_lists_path
    expect(response.code).to eq("200")
  end

  it 'can request for new item_list' do
    get new_item_list_path
    expect(response.code).to eq("200")
  end

  it 'can show item_list' do
    item_list = FactoryGirl.create(
      :item_list,
      title: "Название списка",
      user_id: @user.id
    )

    get item_list_path(item_list)
    expect(response.code).to eq("200")
    expect(response.body).to include("Название списка")
  end

  it 'can create new item_list' do
    post item_lists_path, item_list: {
      title: "Create by post-request",
      color: "green",
      public: true,
      description: "Some description"
    }

    expect(response).to redirect_to(item_lists_path)
    follow_redirect!

    expect(response.code).to eq("200")
    expect(response.body).to include("Список удачно создан")

    expect(ItemList.first.title).to eq("Create by post-request")
  end

  describe 'owner.' do
    it 'can update existing item_list' do
      item_list = FactoryGirl.create(
        :item_list,
        title: "Some item_list",
        color: "yellow",
        public: false,
        description: "Some description",
        user_id: @user.id
      )

      patch item_list_path(item_list), item_list: {
        title: "Create by patch-request",
        color: "green",
        public: true,
        description: "Updated description"
      }

      expect(response).to redirect_to(item_lists_path)
      follow_redirect!

      expect(response.code).to eq("200")
      expect(response.body).to include("Список удачно обновлен")

      expect(ItemList.first.title).to eq("Create by patch-request")
      expect(ItemList.first.color).to eq("green")
      expect(ItemList.first.public).to eq(true)
      expect(ItemList.first.description).to eq("Updated description")
    end

    it 'can delete existing item_list' do
      item_list = FactoryGirl.create(
        :item_list,
        user_id: @user.id
      )

      delete item_list_path(item_list)

      expect(response).to redirect_to(item_lists_path)
      follow_redirect!

      expect(response.code).to eq("200")
      expect(response.body).to include("Список удачно удален")

      expect(ItemList.where(id: item_list.id)).to eq([])
    end
  end

  describe 'not owner.' do
    it 'can not update existing item_list' do
      item_list = FactoryGirl.create(
        :item_list,
        title: "Some item_list",
        color: "yellow",
        public: false,
        description: "Some description"
      )

      patch item_list_path(item_list), item_list: {
        title: "Create by patch-request",
        color: "green",
        public: true,
        description: "Updated description"
      }

      expect(response).to redirect_to(item_lists_path)
      follow_redirect!

      expect(response.code).to eq("200")
      expect(response.body).to include("Манипуляции доступны только над своими элементами")

      not_updated_item_list = ItemList.find(item_list.id)
      expect(not_updated_item_list.title).to eq("Some item_list")
      expect(not_updated_item_list.color).to eq("yellow")
      expect(not_updated_item_list.public).to eq(false)
      expect(not_updated_item_list.description).to eq("Some description")
    end

    it 'can not delete existing item_list' do
      item_list = FactoryGirl.create :item_list

      delete item_list_path(item_list)

      expect(response).to redirect_to(item_lists_path)
      follow_redirect!

      expect(response.code).to eq("200")
      expect(response.body).to include("Манипуляции доступны только над своими элементами")

      expect(ItemList.find(item_list.id).id).to eq(item_list.id)
    end

    it 'can see foreigner public item_list' do
      first_user  = FactoryGirl.create(:user)
      item_list   = FactoryGirl.create(
        :public_list,
        title: "it's public item_list",
        user_id: first_user.id
      )

      get item_list_path(item_list)
      expect(response.code).to eq("200")
      expect(response.body).to include("it&#39;s public item_list")
    end

    it 'can not see foreigner not public item_list' do
      first_user  = FactoryGirl.create(:user)
      item_list   = FactoryGirl.create(
        :item_list,
        user_id: first_user.id
      )
      get item_list_path(item_list)

      expect(response.code).to eq("302")
      expect(response).to redirect_to(item_lists_path)

      follow_redirect!
      expect(response.code).to eq("200")
    end
  end
end
