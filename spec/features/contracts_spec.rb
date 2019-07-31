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
		let(:selected_contract) { selected_consumer.contracts[0] }

		before do
			login_as @admin, :scope => :user
			visit consumer_path(selected_consumer) 
		end

		scenario 'The Visitor can viewing index of contracts' do
			expect(page).to have_content "Пользователь: #{@admin.username}"
			expect(page).to have_xpath('//tbody/tr', count: 3)

			selected_consumer.contracts.each { |contr| expect(page).to have_content contr.number }
		end

		scenario 'The Visitor can delete a contract from the index' do
			expect(page).to have_xpath('//tbody/tr', count: 3)
			expect(page).to have_content(selected_contract.number)
			first('i.test-delete-contract').click
			page.driver.browser.switch_to.alert.accept
			expect(page).to have_xpath('//tbody/tr', count: 2)
			expect(page).to_not have_content(selected_contract.number)
		end

		scenario 'The Visitor can edit a contract' do
			expect(page).to have_content(selected_contract.number)
			first('i.test-edit-contract').click
			fill_in 'Номер:', with: 'Contract-000'
			click_button 'Сохранить'
			expect(page).to_not have_content(selected_contract.number)
			expect(page).to have_content('Contract-000')
		end

		scenario 'The Visitor can add a contract' do
			expect(page).to have_xpath('//tbody/tr', count: 3)
			expect(page).to_not have_content('Contract-000')
			fill_in 'Номер:', with: 'Contract-000'
			click_button 'Сохранить'
			expect(page).to have_xpath('//tbody/tr', count: 4)
			expect(page).to have_content('Contract-000')
		end
	end

	context 'When Visitor is logged in as Manager' do

		let(:selected_consumer) { @consumers.find { |cons| cons.manager_username == @manager.username } }
		let(:selected_contract) { selected_consumer.contracts[0] }

		before do 
			login_as @manager, :scope => :user 
			visit consumer_path(selected_consumer)
		end

		scenario 'The Visitor can viewing index of contracts' do
			expect(page).to have_content "Пользователь: #{@manager.username}"
			expect(page).to have_xpath('//tbody/tr', count: 3)

			selected_consumer.contracts.each { |contr| expect(page).to have_content contr.number }
		end

		scenario 'The Visitor can delete a contract from the index' do
			expect(page).to have_xpath('//tbody/tr', count: 3)
			expect(page).to have_content(selected_contract.number)
			first('i.test-delete-contract').click
			page.driver.browser.switch_to.alert.accept
			expect(page).to have_xpath('//tbody/tr', count: 2)
			expect(page).to_not have_content(selected_contract.number)
		end

		scenario 'The Visitor can edit a contract' do
			expect(page).to have_content(selected_contract.number)
			first('i.test-edit-contract').click
			fill_in 'Номер:', with: 'Contract-000'
			click_button 'Сохранить'
			expect(page).to_not have_content(selected_contract.number)
			expect(page).to have_content('Contract-000')
		end

		scenario 'The Visitor can add a contract' do
			expect(page).to have_xpath('//tbody/tr', count: 3)
			expect(page).to_not have_content('Contract-000')
			fill_in 'Номер:', with: 'Contract-000'
			click_button 'Сохранить'
			expect(page).to have_xpath('//tbody/tr', count: 4)
			expect(page).to have_content('Contract-000')
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

		scenario 'The Visitor can not delete a contract from the index' do
			expect(page).to_not have_css('i.test-delete-contract')
		end

		scenario 'The Visitor can not edit a contract' do
			expect(page).to_not have_css('i.test-edit-contract')
		end

		scenario 'The Visitor can not add a contract' do
			expect(page).to_not have_content('Добавить договор')
			expect(page).to_not have_content('Сохранить')
		end
	end
end
