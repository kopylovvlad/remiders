# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  middle_name            :string
#  last_name              :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  before :all do
    @user = FactoryGirl.create(
      :user,
      first_name: "Петр",
      middle_name: "Олегович",
      last_name: "Сидоров"
    )
  end

  let(:user) { User.new }

  describe 'validation' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email)  }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'attributes' do
    it 'has a first name' do
      expect(@user.first_name).to eq("Петр")
    end

    it 'has a middle name' do
      expect(@user.middle_name).to eq("Олегович")
    end

    it 'has a last name' do
      expect(@user.last_name).to eq("Сидоров")
    end
  end

  describe 'methods test' do
    it 'has a full name' do
      user = FactoryGirl.create(
        :user,
        last_name: 'Сидоров',
        first_name: 'Петр',
        middle_name: 'Михайлович'
      )

      expect(user.full_name).to eq("Сидоров Петр Михайлович")
    end

    it 'has a full name without middle name' do
      user = FactoryGirl.create(
        :user,
        last_name: 'Сидоров',
        first_name: 'Петр'
      )

      expect(user.full_name).to eq("Сидоров Петр")
    end
  end

  describe 'relations' do
    it { should have_many(:item_lists) }
  end
end
