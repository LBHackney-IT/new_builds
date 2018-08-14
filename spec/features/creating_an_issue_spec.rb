require 'rails_helper'

RSpec.feature 'Operative can create an issue' do
  before do
    create(:user,
      email: 'test@test.com',
      password: 'password',
      password_confirmation: 'password'
    )
    dwelling = create(:location_dwelling)
    scheme = dwelling.scheme
    create(:scheme_priority, scheme: scheme, name: 'p1')
    create(:resident, dwelling: dwelling)
  end
  scenario 'with valid details' do
    visit '/'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'password'
    click_on 'Sign in'
    click_on 'SchemeName'
    click_on 'Add new issue'
    fill_in 'Urn', with: 'URN1'
    select 'Dwelling 1', from: 'Location'
    select 'p1', from: 'Scheme priority'
    select 'Resident Name', from: 'Resident'
    fill_in 'Description', with: 'Issue Description'
    select 'Outstanding', from: 'Status'
    click_on 'Create Issue'
    expect(page).to have_content('SchemeName')
  end
end
