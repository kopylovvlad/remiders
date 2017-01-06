# == Schema Information
#
# Table name: item_lists
#
#  id          :integer          not null, primary key
#  title       :string
#  color       :string
#  public      :boolean          default("false")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  description :text
#

require 'rails_helper'

RSpec.describe ItemList, type: :model do

  before :all do
    @first_user = FactoryGirl.create(:user)
    @second_user = FactoryGirl.create(:user)

    @first_item_list = FactoryGirl.create(:item_list,
      title: "just test",
      color: 'green',
      description: 'some description',
      public: true,
      user_id: @first_user.id)
  end

  let(:item_list) { ItemList.new }

  describe 'validation' do

    it { should validate_presence_of(:title) }
    it { should validate_inclusion_of(:color).
        in_array ['grey', 'deep blue', 'green', 'blue', 'yellow', 'red'] }

  end

  describe 'attributes' do
    it 'has a title' do
      expect(@first_item_list.title).to eq("just test")
    end

    it 'has a color' do
      expect(@first_item_list.color).to eq("green")
    end

    it 'has a description' do
      expect(@first_item_list.description).to eq("some description")
    end

    it 'has a public' do
      expect(@first_item_list.public).to eq(true)
    end

    describe 'every color can convert to html', :aggregate_failures do
      def self.it_parse_color(color, as: '')
        it 'it_parse_color #{string} as #{as}' do
          item_list = FactoryGirl.create(:item_list, color: color)
          expect(item_list.color_class).to eq(as)
        end
      end

      it_parse_color 'grey',      as: 'panel-default'
      it_parse_color 'deep blue', as: 'panel-primary'
      it_parse_color 'green',     as: 'panel-success'
      it_parse_color 'blue',      as: 'panel-info'
      it_parse_color 'yellow',    as: 'panel-warning'
      it_parse_color 'red',       as: 'panel-danger'
    end
  end

  describe 'relations' do

    it { should have_many(:items) }
    it { should belong_to(:user) }

  end

  describe 'methods' do
    it 'has color list for form' do
      expect(ItemList.colors_for_form).to eq([
        ["Серый", "grey"], ["Синий", "deep blue"], ["Зеленый", "green"],
        ["Голубой", "blue"], ["Желтый", "yellow"], ["Красный", "red"]
      ])
    end
  end

end
