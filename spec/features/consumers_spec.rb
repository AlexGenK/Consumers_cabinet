require 'rails_helper'

feature 'Access to consumers', type: :feature do
	before do
		@admin 					= FactoryBot.create(:user_admin)
		@manager_ivan 	= FactoryBot.create(:user_manager, 	username: 'Ivan')
		@manager_roman 	= FactoryBot.create(:user_manager, 	username: 'Roman')
		@client_taya 		= FactoryBot.create(:user_client, 	username: 'Taya')
		@client_varya 	= FactoryBot.create(:user_client, 	username: 'Varya')
		@client_olya 		= FactoryBot.create(:user_client, 	username: 'Olya')
		@client_sveta 	= FactoryBot.create(:user_client, 	username: 'Sveta')
		@client_nata 		= FactoryBot.create(:user_client, 	username: 'Nata')
		@consumers = create_list :consumer, 5
		(0..2).each { |i| @consumers[i].manager_username = @manager_ivan.username }
		(3..4).each { |i| @consumers[i].manager_username = @manager_roman.username }
		@consumers[0].client_username = @client_taya.username
		@consumers[1].client_username = @client_varya.username
		@consumers[2].client_username = @client_olya.username
		@consumers[3].client_username = @client_sveta.username
		@consumers[4].client_username = @client_nata.username
	end

	context 'When Visitor is logged in as Admin' do
		before do
			login_as @admin, :scope => :user
			visit root_path 
		end

		scenario 'The Visitor is viewing full consumers index' do
			expect(page).to have_content "Пользователь: #{@admin.username}"
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
			login_as @manager_ivan, :scope => :user 
			visit root_path
		end

		scenario 'The Visitor is viewing index of their consumers' do
			expect(page).to have_content "Пользователь: #{@manager_ivan.username}"
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
			login_as @client_taya, :scope => :user 
			visit root_path
		end

		scenario 'The Visitor is viewing index of their consumers' do
			expect(page).to have_content "Пользователь: #{@client_taya.username}"
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