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

class ItemList < ActiveRecord::Base
  COLORS = {
    'grey' => 'default',
    'deep blue' => 'primary',
    'green' => 'success',
    'blue' => 'info',
    'yellow' => 'warning',
    'red' => 'danger'
  }.freeze

  belongs_to :user

  has_many :items, dependent: :destroy

  validates :title, presence: true
  validates :color, presence: true, inclusion: { in: COLORS.keys }
  validates :user, presence: true

  def color_class
    "panel-#{COLORS[color]}"
  end

  def public?
    public
  end

  def self.colors_for_form
    COLORS.map { |key, _value| [I18n.t("item_list_color.#{key}"), key] }
  end
end
