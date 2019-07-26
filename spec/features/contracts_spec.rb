require 'rails_helper'

feature 'Access to contracts of consumer', type: :feature do

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

		let(:selected_consumer) { @consumers[0] }

		before do
			login_as @admin, :scope => :user
			visit consumer_path(selected_consumer) 
		end

		scenario 'The Visitor can viewing index of contracts' do
			expect(page).to have_content "Пользователь: #{@admin.username}"
			expect(page).to have_xpath('//tbody/tr', count: 3)

			selected_consumer.contracts.each { |contr| expect(page).to have_content contr.number }
		end

		scenario 'The Visitor can delete a contract from the index ' do
		end

		scenario 'The Visitor can edit a contract' do
		end

		scenario 'The Visitor can add a contract' do
		end
	end

	context 'When Visitor is logged in as Manager' do

		let(:selected_consumer) { @consumers.find { |cons| cons.manager_username == @manager.username } }

		before do 
			login_as @manager, :scope => :user 
			visit consumer_path(selected_consumer)
		end

		scenario 'The Visitor can viewing index of contracts' do
			expect(page).to have_content "Пользователь: #{@manager.username}"
			expect(page).to have_xpath('//tbody/tr', count: 3)

			selected_consumer.contracts.each { |contr| expect(page).to have_content contr.number }
		end

		scenario 'The Visitor can delete a contract from the index ' do
		end

		scenario 'The Visitor can edit a contract' do
		end

		scenario 'The Visitor can add a contract' do
		end
	end

	context 'When Visitor is logged in as Consumer' do

		let(:selected_consumer) { @consumers.find { |cons| cons.client_username == @client.username } }

		before do 
			login_as @client, :scope => :user 
			visit consumer_path(selected_consumer)
		end

		scenario 'The Visitor can viewing index of contracts' do
			expect(page).to have_content "Пользователь: #{@client.username}"
			expect(page).to have_xpath('//tbody/tr', count: 3)

			selected_consumer.contracts.each { |contr| expect(page).to have_content contr.number }
		end

		scenario 'The Visitor can not delete a contract from the index ' do
		end

		scenario 'The Visitor can not edit a contract' do
		end

		scenario 'The Visitor can not add a contract' do
		end
	end
end
