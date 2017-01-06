require 'rails_helper'

RSpec.describe "Users", type: :request do

  it 'can register' do
    post user_registration_path, user: {
      email: "mega_hard_email@tmail.com",
      password: "mega_hard_password",
      password_confirmation: "mega_hard_password",
      first_name: "Петр",
      last_name: "Иванов",
    }

    expect(response).to redirect_to(root_path)
    follow_redirect!
    expect(response.code).to eq("200")

    user = User.first
    expect(user.first_name).to eq("Петр")
    expect(user.last_name).to eq("Иванов")
  end

  it 'can update profile' do
    user = FactoryGirl.create(:user,
      email: "mega_hard_email2@tmail.com",
      password: "mega_hard_password",
      password_confirmation: "mega_hard_password",
      first_name: "Петр",
      last_name: "Иванов"
    )
    sign_in user

    patch user_registration_path, user: {
      current_password: "mega_hard_password",
      email: "second_mega_hard_email@tmail.com",
      first_name: "Алексей",
      last_name: "Петров"
    }

    expect(response).to redirect_to(root_path)
    follow_redirect!
    expect(response.code).to eq("200")

    updated_user = User.find(user.id)
    expect(updated_user.email).to eq("second_mega_hard_email@tmail.com")
    expect(updated_user.first_name).to eq("Алексей")
    expect(updated_user.last_name).to eq("Петров")
  end

end
