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

require 'test_helper'

class ItemListTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
