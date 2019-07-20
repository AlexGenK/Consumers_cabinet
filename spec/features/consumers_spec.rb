require 'rails_helper'

feature 'Access to consumers', type: :feature do

	MANAGER_CLIENT_NAME = {'Ivan'  => ['Taya', 'Varya'],
												 'Roman' => ['Olya', 'Sveta', 'Nata']}

	before do

		@admin = create(:user_admin)
		@consumers = []

		MANAGER_CLIENT_NAME.each do |man_name, cli_array|
			@manager = create(:user_manager, username: man_name)
			cli_array.each do |cli_name|
				@client = create(:user_client, username: cli_name)
				@consumers << create(:consumer, client_username: cli_name, manager_username: man_name)
			end
		end
	end

	context 'When Visitor is logged in as Admin' do
		before do
			login_as @admin, :scope => :user
			visit root_path 
		end

		scenario 'The Visitor is viewing full consumers index' do
			expect(page).to have_content "Пользователь: #{@admin.username}"
			expect(page).to have_xpath('//tbody/tr', count: 5)
			@consumers.each { |cons| expect(page).to have_content cons.name }
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
			login_as @manager, :scope => :user 
			visit root_path
		end

		scenario 'The Visitor is viewing index of their consumers' do
			expect(page).to have_content "Пользователь: #{@manager.username}"
			expect(page).to have_xpath('//tbody/tr', count: 3)
			@consumers.each do |cons| 
				if cons.manager_username == @manager.username
					expect(page).to have_content cons.name
				else
					expect(page).not_to have_content cons.name
				end 
			end
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
			login_as @client, :scope => :user 
			visit root_path
		end

		scenario 'The Visitor is viewing index of their consumers' do
			expect(page).to have_content "Пользователь: #{@client.username}"
			expect(page).to have_xpath('//tbody/tr', count: 1)
			@consumers.each do |cons| 
				if cons.client_username == @client.username
					expect(page).to have_content cons.name
				else
					expect(page).not_to have_content cons.name
				end 
			end
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