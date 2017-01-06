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

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
