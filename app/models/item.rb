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

class Item < ActiveRecord::Base
  default_scope { order(is_done: :asc) }

  scope :done,   -> { where(is_done: true) }
  scope :undone, -> { where(is_done: false) }

  PRIORITY = {
    '0' => 'нет',
    '1' => 'низкий',
    '2' => 'средний',
    '3' => 'высокий',
    '4' => 'очень высокий'
  }.freeze

  belongs_to :item_list

  validates :title, presence: true
  validates :priority, presence: true, inclusion: { in: PRIORITY.keys.map(&:to_i) }
  validates :item_list, presence: true

  def priority_to_text
    PRIORITY[priority.to_s]
  end

  def self.priority_for_form
    PRIORITY.map { |key, value| [value, key] }
  end
end
