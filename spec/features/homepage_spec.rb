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

  scenario 'Visitor can log in with right login/password' do
    fill_in 'Имя пользователя', with: @user.username
    fill_in 'Пароль', with: @user.password
    click_button 'Войти'
    expect(page).to have_content 'Вход в систему выполнен'
  end

  scenario 'Visitor can not log in with incorrect login' do
    fill_in 'Имя пользователя', with: "#{@user.username}-incorrect"
    fill_in 'Пароль', with: @user.password
    click_button 'Войти'
    expect(page).to have_content 'Неверное имя пользователя или пароль'
  end

  scenario 'Visitor can not log in with incorrect password' do
    fill_in 'Имя пользователя', with: @user.username
    fill_in 'Пароль', with: "#{@user.password}-incorrect"
    click_button 'Войти'
    expect(page).to have_content 'Неверное имя пользователя или пароль'
  end
end
