require 'spec_helper'

describe DiagnosisCodeDescriptionService do

  it_behaves_like 'a ServiceMessages service'

  let!(:api_url)  { 'https://apps.nlm.nih.gov/medlineplus/services/mpconnect_service.cfm' }
  let!(:code)     { 'J01.01' }
  let!(:bad_code) { 'nerf' }

  before :all do
    WebMock.disable_net_connect! allow_localhost: true
  end

  after :all do
    WebMock.allow_net_connect!
  end
   
  describe '#perform' do
    it 'returns success message and diagnosis code description data when code is valid' do
      stub_request(:get, api_url).
        with(query: hash_including({ 'mainSearchCriteria.v.c' => code })).
        to_return(status: 200, body:
          '{"feed":{"entry":[{"link": [{"title": "Sinusitis", "href": "https://medlineplus.gov/sinusitis.html"}], "summary": {"_value": "Sinusitis means your sinuses are inflamed."}}]}}')

      result = DiagnosisCodeDescriptionService.perform code

      expect(result.success?).to eq(true)
      expect(result.descriptions).to eq [{
        link: [{ title: 'Sinusitis', href: 'https://medlineplus.gov/sinusitis.html' }],
        summary: { _value: 'Sinusitis means your sinuses are inflamed.' }}]
      expect(result.message).to match /success/i
    end

    it 'returns invalid message and empty success response when code is invalid' do
      stub_request(:get, api_url).
        with(query: hash_including({ 'mainSearchCriteria.v.c' => bad_code })).
        to_return(status: 200, body: '{"feed":{"entry":[]}}')

      result = DiagnosisCodeDescriptionService.perform bad_code

      expect(result.success?).to eq(true)
      expect(result.descriptions).to be_blank
      expect(result.message).to match /invalid/i
    end

    it 'returns error response when client fails to respond' do
      stub_request(:get, api_url).
        with(query: hash_including({ 'mainSearchCriteria.v.c' => code })).
        to_return(status: 200)

      result = DiagnosisCodeDescriptionService.perform code

      expect(result.success?).to eq(false)
      expect(result.failure?).to eq(true)
      expect(result.descriptions).to be_blank
      expect(result.errors).to include(/unable/i)
    end
  end
end
