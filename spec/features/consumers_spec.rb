require 'rails_helper'

feature 'Access to consumers', type: :feature do
	before do 
	end

	context 'When Visitor is logged in as Superadmin' do
		before do
			login_as FactoryBot.create(:user_admin), :scope => :user
			visit root_path 
		end

		scenario 'The Visitor is viewing full consumers index' do
			expect(page).to have_content 'Пользователь: admin'
		end

		scenario 'The Visitor can delete a consumer from the index ' do
		end

		scenario 'The Visitor is viewing a consumer info' do
		end

		scenario 'The Visitor can delete a consumer from the info screen ' do
		end

		scenario 'Visitor can edit a consumer' do
		end

		scenario 'Visitor can add a consumer' do
		end

	end

	context 'When Visitor is logged in as Manager' do
		before do 
			login_as FactoryBot.create(:user_manager), :scope => :user 
			visit root_path
		end

		scenario 'The Visitor is viewing index of their consumers' do
			expect(page).to have_content 'Пользователь: manager'
		end

		scenario 'The Visitor can delete a consumer from the index ' do
		end

		scenario 'The Visitor is viewing a consumer info' do
		end

		scenario 'The Visitor can delete a consumer from the info screen ' do
		end

		scenario 'Visitor can edit a consumer' do
		end

		scenario 'Visitor can add a consumer' do
		end
	end

	context 'When Visitor is logged in as Client' do
		before do 
			login_as FactoryBot.create(:user_client), :scope => :user 
			visit root_path
		end

		scenario 'The Visitor is viewing index of their consumers' do
			expect(page).to have_content 'Пользователь: client'
		end

		scenario 'The Visitor can not delete a consumer from the index ' do
		end

		scenario 'The Visitor is viewing a consumer info' do
		end

		scenario 'The Visitor can not delete a consumer from the info screen ' do
		end

		scenario 'Visitor can not edit a consumer' do
		end

		scenario 'Visitor can not add a consumer' do
		end
	end
end