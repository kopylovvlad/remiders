# == Schema Information
#
# Table name: items
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  deadline     :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  priority     :integer          default("0")
#  item_list_id :integer
#  is_done      :boolean          default("f")
#

require 'rails_helper'

RSpec.describe Item, type: :model do
  before :all do
    user = FactoryGirl.create(:user)

    FactoryGirl.create(:item_list, user_id: user.id)
    @last_item_list = FactoryGirl.create(
      :item_list,
      title: 'Last Item List',
      color: 'green',
      user_id: user.id
    )
  end

  let(:item) { Item.new }

  describe 'validation' do
    it { should validate_presence_of(:title) }
  end

  describe 'attributes' do
    it 'has a title' do
      item = FactoryGirl.create(:item, title: 'New Item')
      expect(item.title).to eq('New Item')
    end

    it 'has a description' do
      item = FactoryGirl.create(:item, description: 'New Item Description')
      expect(item.description).to eq('New Item Description')
    end

    it 'has a priority' do
      item = FactoryGirl.create(:item, priority: 2)
      expect(item.priority).to eq(2)
    end

    it 'has a deadline' do
      deadline = DateTime.current + 10.days
      item = FactoryGirl.create(:item, deadline: deadline)

      expect(item.deadline).to eq(deadline)
    end

    describe 'has text value for priority', :aggregate_failures do
      def self.parses_priority(priority, as: '')
        it 'parses #{priority} as #{as}' do
          item = FactoryGirl.create(:item, priority: priority)
          expect(item.priority_to_text).to eq(as)
        end
      end

      parses_priority 0, as: 'нет'
      parses_priority 1, as: 'низкий'
      parses_priority 2, as: 'средний'
      parses_priority 3, as: 'высокий'
      parses_priority 4, as: 'очень высокий'
    end
  end

  describe 'methods' do
    it 'has priority list for form' do
      expect(Item.priority_for_form).to(
        eq(
          [
            %w(нет 0),
            %w(низкий 1),
            %w(средний 2),
            %w(высокий 3),
            ["очень высокий", "4"]
          ]
        )
      )
    end
  end

  describe 'relations' do
    it { should belong_to(:item_list) }
  end
end
