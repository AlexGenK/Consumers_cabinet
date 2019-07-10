require 'rails_helper'

feature 'Access to consumers', type: :feature do
	before do 
	end

	context 'When Visitor is logged in as Superadmin' do
		before do 
		end

		scenario 'The Visitor is viewing full consumers index' do
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
		end

		scenario 'The Visitor is viewing index of their consumers' do
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
		end

		scenario 'The Visitor is viewing index of their consumers' do
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