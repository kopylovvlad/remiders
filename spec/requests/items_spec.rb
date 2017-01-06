require 'rails_helper'

RSpec.describe "Items. Auth user ", type: :request do

  before :all do
    @user = FactoryGirl.create(:user)
    @item_list = FactoryGirl.create(:item_list,
      user_id: @user.id
    )
  end

  before(:each) do
    sign_in @user
  end

  after(:each) do
    sign_out @user
  end

  it 'can create item'  do
    date = Time.parse "2017-02-12"

    post item_list_items_path(@item_list), item: {
      title: "It's new item",
      description: "It's new desription",
      deadline: date.strftime("%Y-%m-%d"),
      priority: 3,
    }

    expect(response).to redirect_to(item_list_path(@item_list))
    follow_redirect!

    expect(response.code).to eq("200")

    expect(@item_list.items.first.title).to eq("It's new item")

    expect(@item_list.items.first.description).to eq("It's new desription")
    expect(@item_list.items.first.deadline).to eq(date)
    expect(@item_list.items.first.priority).to eq(3)
    expect(@item_list.items.first.is_done).to eq(false)
  end


  describe 'owner' do
    it 'can update item' do
      date = Time.parse "2017-02-19"
      item = @item_list.items.first
      patch item_list_item_path(@item_list, item), item: {
        title: "It's new title for item",
        description: "It's new desription for item",
        deadline: date.strftime("%Y-%m-%d"),
        priority: 2,
        is_done: true,
      }

      expect(response).to redirect_to(item_list_path(@item_list))
      follow_redirect!

      expect(response.code).to eq("200")
      expect(@item_list.items.first.title).to eq("It's new title for item")

      expect(@item_list.items.first.description).to eq("It's new desription for item")
      expect(@item_list.items.first.deadline).to eq(date)
      expect(@item_list.items.first.priority).to eq(2)
      expect(@item_list.items.first.is_done).to eq(true)
    end

    it 'can destroy item' do
      item = @item_list.items.first
      delete item_list_item_path(@item_list, item)

      expect(response).to redirect_to(item_list_path(@item_list))
      follow_redirect!

      expect(response.code).to eq("200")
      expect(@item_list.items).to eq([])
    end
  end

  describe 'not owner' do
    it 'can not update item' do
      item = FactoryGirl.create(:item)

      expect do
        patch item_list_item_path(@item_list, item), item: {
          title: "It's new title for item",
          description: "It's new desription for item"
        }
      end.to raise_error(
        ActiveRecord::RecordNotFound
      )

      expect(Item.find(item.id).id).to eq(item.id)
    end
    it 'can not destroy item' do
      item = FactoryGirl.create(:item)

      expect do
        delete item_list_item_path(@item_list, item)
      end.to raise_error(
        ActiveRecord::RecordNotFound
      )

      expect(Item.find(item.id).id).to eq(item.id)
    end
  end

end
