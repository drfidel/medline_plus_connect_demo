require 'rails_helper'

RSpec.describe DiagnosisCodeDescriptionService do

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
          '{"feed":{"entry":[{
            "title": {"_value": "Sinusitis"},
            "link": [{"title": "Sinusitis", "href": "https://medlineplus.gov/sinusitis.html"}],
            "summary": {"_value": "Sinusitis means your sinuses are inflamed."}}]}}')

      result = DiagnosisCodeDescriptionService.build(code).perform

      expect(result.success?).to eq(true)
      expect(result.descriptions).to eq [{
        title:'Sinusitis',
        link: 'https://medlineplus.gov/sinusitis.html',
        description: 'Sinusitis means your sinuses are inflamed.' }]
      expect(result.message).to match /success/i
    end

    it 'returns invalid message and empty success response when code is invalid' do
      stub_request(:get, api_url).
        with(query: hash_including({ 'mainSearchCriteria.v.c' => bad_code })).
        to_return(status: 200, body: '{"feed":{"entry":[]}}')

      result = DiagnosisCodeDescriptionService.build(bad_code).perform

      expect(result.success?).to eq(true)
      expect(result.descriptions).to be_blank
      expect(result.message).to match /invalid/i
    end

    it 'returns error response when client is unreachable' do
      # Returning a response body with bad formatted JSON prevents the client
      #  from parsing it, causing an invalid response to be returned to the
      #  service object.
      stub_request(:get, api_url).
        with(query: hash_including({ 'mainSearchCriteria.v.c' => code })).
        to_return(status: 200, body: '{"bad": {"json" []}}')

      result = DiagnosisCodeDescriptionService.build(code).perform

      expect(result.success?).to eq(false)
      expect(result.failure?).to eq(true)
      expect(result.descriptions).to be_blank
      expect(result.errors.map(&:message)).to include(/unable to reach client/i)
    end

    it 'returns the client\'s error response when client experiences internal failure' do
      # Returning no response body causes the client to throw an exception, as
      #  it believes the NLM API is unavailable.
      stub_request(:get, api_url).
        with(query: hash_including({ 'mainSearchCriteria.v.c' => code })).
        to_return(status: 200)

      result = DiagnosisCodeDescriptionService.build(code).perform

      expect(result.success?).to eq(false)
      expect(result.failure?).to eq(true)
      expect(result.descriptions).to be_blank
      expect(result.errors.map(&:message)).to include(/no response/i)
    end

  end

end
