require 'rails_helper'

feature 'Access to contract counters', type: :feature do

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
		let(:selected_contract) { selected_consumer.contracts[0] }
		let(:selected_counter)  { selected_contract.counters[0] }

		before do
			login_as @admin, :scope => :user
			visit consumer_path(selected_consumer)
			click_link selected_contract.number
		end

		scenario 'The Visitor can viewing index of counters' do
			selected_contract.counters.each do |counter|
				expect(page).to have_content "Счет №#{counter.account}, счетчик №#{counter.number}, КУ=#{counter.ratio}."
			end
		end

		scenario 'The Visitor can delete a counter' do
			expect(page).to have_content('счетчик №', count: 3)
			first('i.test-delete-counter').click
			page.driver.browser.switch_to.alert.accept
			expect(page).to have_content('счетчик №', count: 2)
		end

		scenario 'The Visitor can edit a counter' do

		end

		scenario 'The Visitor can add a counter' do

		end
	end

	context 'When Visitor is logged in as Manager' do

		let(:selected_consumer) { @consumers.find { |cons| cons.manager_username == @manager.username } }
		let(:selected_contract) { selected_consumer.contracts[0] }
		let(:selected_counter)  { selected_contract.counters[0] }

		before do 
			login_as @manager, :scope => :user 
			visit consumer_path(selected_consumer)
			click_link selected_contract.number
		end

		scenario 'The Visitor can viewing index of counters' do
			selected_contract.counters.each do |counter|
				expect(page).to have_content "Счет №#{counter.account}, счетчик №#{counter.number}, КУ=#{counter.ratio}."
			end
		end

		scenario 'The Visitor can delete a counter' do
			expect(page).to have_content('счетчик №', count: 3)
			first('i.test-delete-counter').click
			page.driver.browser.switch_to.alert.accept
			expect(page).to have_content('счетчик №', count: 2)
		end

		scenario 'The Visitor can edit a counter' do

		end

		scenario 'The Visitor can add a counter' do

		end
	end

	context 'When Visitor is logged in as Consumer' do

		let(:selected_consumer) { @consumers.find { |cons| cons.client_username == @client.username } }
		let(:selected_contract) { selected_consumer.contracts[0] }
		let(:selected_counter)  { selected_contract.counters[0] }

		before do 
			login_as @client, :scope => :user 
			visit consumer_path(selected_consumer)
			click_link selected_contract.number
		end

		scenario 'The Visitor can viewing index of counters' do
			selected_contract.counters.each do |counter|
				expect(page).to have_content "Счет №#{counter.account}, счетчик №#{counter.number}, КУ=#{counter.ratio}."
			end
		end

		scenario 'The Visitor can not delete a counter' do
			expect(page).to_not have_css('i.test-delete-counter')
		end

		scenario 'The Visitor can not edit a counter' do

		end

		scenario 'The Visitor can not add a counter' do

		end
	end
end
