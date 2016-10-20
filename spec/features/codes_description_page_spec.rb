require 'rails_helper'

feature 'Diagnosis Code Description Page' do

  let!(:api_url)  { 'https://apps.nlm.nih.gov/medlineplus/services/mpconnect_service.cfm' }
  let!(:code)     { 'J01.01' }
  let!(:bad_code) { 'nerf' }

  before :all do
    WebMock.disable_net_connect! allow_localhost: true
  end

  after :all do
    WebMock.allow_net_connect!
  end

  scenario 'loading page' do
    visit codes_description_path

    expect(page).to have_xpath    "//form[@action='#{codes_submit_code_path}']"
    expect(page).to have_selector 'h2', text: 'Diagnosis Code Descriptions'
    expect(page).to have_selector '.cont__code-id-title', visible: false
    expect(page).to have_selector '.cont__description-body', visible: false
  end

  context 'looking up diagnosis code descriptions', js: true do
    context 'with valid diagnosis code' do
      scenario 'should produce a bootstrap card with code description text' do

        visit codes_description_path

        stub_request(:get, api_url).
          with(query: hash_including({ 'mainSearchCriteria.v.c' => code })).
          to_return(status: 200, body:
            '{"feed":{"entry":[{
              "title": {"_value": "Sinusitis"},
              "link": [{"title": "Sinusitis", "href": "https://medlineplus.gov/sinusitis.html"}],
              "summary": {"_value": "Sinusitis means your sinuses are inflamed."}}]}}')

        fill_in 'diagnosis-code', with: code
        click_button 'Fetch Code'

        expect(page).to have_selector '.cont__code-id-title', visible: true
        expect(page).to have_selector '.cont__description-body', visible: true
        expect(page).to have_selector '.cont__code-id', text: code

        within '.cont__description-body' do
          expect(page).to have_selector '.card'
          expect(page).to have_selector '.cont__nlm-description', text: 'Sinusitis means your sinuses are inflamed.'
        end
      end
    end

    context 'with invalid diagnosis code' do
      scenario 'should produce a bootstrap card with code description text' do

        visit codes_description_path

        stub_request(:get, api_url).
          with(query: hash_including({ 'mainSearchCriteria.v.c' => bad_code })).
          to_return(status: 200, body: '{"feed":{"entry":[]}}')

        fill_in 'diagnosis-code', with: bad_code
        click_button 'Fetch Code'

        expect(page).to have_selector '.cont__code-id-title', visible: true
        expect(page).to have_selector '.cont__description-body', visible: true
        expect(page).to have_selector '.cont__code-id', text: bad_code

        within '.cont__description-body' do
          expect(page).to have_selector '.card', count: 1
          expect(page).to have_selector '.cont__nlm-description', count: 1,
            text: 'No descriptions were found for this code.'
        end
      end
    end
  end
end
