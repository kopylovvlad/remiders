require 'rails_helper'

RSpec.describe "ItemLists for guest-user", type: :request do
  describe 'guest user can not' do

    it ' listing item_lists' do
      get item_lists_path

      expect(response.code).to eq("302")
      expect(response).to redirect_to(new_user_session_path)

      follow_redirect!
      expect(response.code).to eq("200")

      expect(response.body).to include("Вам необходимо войти в систему или зарегистрироваться")
    end

    it ' request for new item_list' do
      get new_item_list_path

      expect(response.code).to eq("302")
      expect(response).to redirect_to(new_user_session_path)

      follow_redirect!
      expect(response.code).to eq("200")
      expect(response.body).to include("Вам необходимо войти в систему или зарегистрироваться")
    end

    it ' show item_list' do
      item_list = FactoryGirl.create(:item_list)
      get item_list_path(item_list)

      expect(response.code).to eq("302")
      expect(response).to redirect_to(new_user_session_path)

      follow_redirect!
      expect(response.code).to eq("200")
      expect(response.body).to include("Вам необходимо войти в систему или зарегистрироваться")
    end

    it ' create new item_list' do
      post item_lists_path, item_list: {
        title: "Create by post-request",
        color: "green",
        public: true,
        description: "Some description"
      }

      expect(response.code).to eq("302")
      expect(response).to redirect_to(new_user_session_path)

      follow_redirect!
      expect(response.code).to eq("200")
      expect(response.body).to include("Вам необходимо войти в систему или зарегистрироваться")
    end

    it ' update existing item_list' do
      item_list = FactoryGirl.create(:item_list,
        title: "Some item_list",
        color: "yellow",
        public: false,
        description: "Some description",
      )

      patch item_list_path(item_list), item_list: {
        title: "Create by patch-request",
        color: "green",
        public: true,
        description: "Updated description"
      }

      expect(response.code).to eq("302")
      expect(response).to redirect_to(new_user_session_path)

      follow_redirect!
      expect(response.code).to eq("200")
      expect(response.body).to include("Вам необходимо войти в систему или зарегистрироваться")
    end

    it ' delete existing item_list' do
      item_list = FactoryGirl.create(:item_list)

      delete item_list_path(item_list)

      expect(response.code).to eq("302")
      expect(response).to redirect_to(new_user_session_path)

      follow_redirect!
      expect(response.code).to eq("200")
      expect(response.body).to include("Вам необходимо войти в систему или зарегистрироваться")
    end

  end

  describe 'guest user can' do
    it ' see public item_list' do
      item_list = FactoryGirl.create(:public_list,
        title: "Публичный список"
      )

      get item_list_path(item_list)

      expect(response.code).to eq("200")
      expect(response.body).to include( item_list.title )
    end
  end
end
