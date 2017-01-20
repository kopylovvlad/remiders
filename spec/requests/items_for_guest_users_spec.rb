require 'rails_helper'

RSpec.describe "Items for guest user", type: :request do
  before :all do
    @user = FactoryGirl.create(:user)
    @item_list = FactoryGirl.create(
      :item_list,
      user_id: @user.id
    )
    @item = FactoryGirl.create(
      :item,
      item_list_id: @item_list.id
    )
  end

  describe 'not auth user can not' do
    it ' create item' do
      post item_list_items_path(@item_list), item: {
        title: "It's new item"
      }

      expect(response.code).to eq("302")
      expect(response).to redirect_to(new_user_session_path)

      follow_redirect!
      expect(response.code).to eq("200")
      expect(response.body).to include("Вам необходимо войти в систему или зарегистрироваться")
    end
    it ' update item' do
      patch item_list_item_path(@item_list, @item), item: {
        title: "It's new title for item"
      }

      expect(response.code).to eq("302")
      expect(response).to redirect_to(new_user_session_path)

      follow_redirect!
      expect(response.code).to eq("200")
      expect(response.body).to include("Вам необходимо войти в систему или зарегистрироваться")
    end
    it ' destroy item' do
      delete item_list_item_path(@item_list, @item)

      expect(response.code).to eq("302")
      expect(response).to redirect_to(new_user_session_path)

      follow_redirect!
      expect(response.code).to eq("200")
      expect(response.body).to include("Вам необходимо войти в систему или зарегистрироваться")
    end
  end
end
