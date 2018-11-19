require 'rails_helper'

feature 'View homepage and access to the consumers informations', type: :feature do
  before do 
    @user = create(:user_admin)
    visit root_path
  end

  scenario 'Visitor is viewing log in form' do
    expect(page).to have_content 'Имя пользователя'
    expect(page).to have_content 'Пароль'
  end

  scenario 'Visitor can log in' do
    fill_in 'Имя пользователя', with: @user.username
    fill_in 'Пароль', with: @user.password
    click_button 'Войти'
    expect(page).to have_content 'Вход в систему выполнен'
  end
end
