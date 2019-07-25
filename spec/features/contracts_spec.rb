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
		scenario 'The Visitor can viewing index of contracts' do
		end

		scenario 'The Visitor can delete a contract from the index ' do
		end

		scenario 'The Visitor can edit a contract' do
		end

		scenario 'The Visitor can add a contract' do
		end
	end

	context 'When Visitor is logged in as Manager' do
		scenario 'The Visitor can viewing index of contracts' do
		end

		scenario 'The Visitor can delete a contract from the index ' do
		end

		scenario 'The Visitor can edit a contract' do
		end

		scenario 'The Visitor can add a contract' do
		end
	end

	context 'When Visitor is logged in as Consumer' do
		scenario 'The Visitor can viewing index of contracts' do
		end

		scenario 'The Visitor can not delete a contract from the index ' do
		end

		scenario 'The Visitor can not edit a contract' do
		end

		scenario 'The Visitor can not add a contract' do
		end
	end
end
