require 'spec_helper'

describe CodeDescriptionPresenter do

  describe '#code' do
    let(:code_description_presenter) { build(:code_description_presenter) }

    it 'returns the model :code' do
      expect(code_description_presenter.code).to be_present
      expect(code_description_presenter.code).to eq('J01.01')
    end
  end

  describe '#descriptions' do
    context 'with a successful CodeDescription object' do
      let(:code_description_presenter) { build(:code_description_presenter) }

      it 'should return a hash with title, link, and description values' do 
        expect(code_description_presenter.descriptions).to eq( [{
          title: 'Sinusitis',
          link: 'https://medlineplus.gov/sinusitis.html',
          description: 'Sinusitis means your sinuses are inflamed.'}] )
      end
    end

    context 'with an unsuccessful CodeDescription object' do
      let(:code_description_presenter) { build(:code_description_presenter, :unsuccessful) }

      it 'should return an error message in the description' do
        descriptions = code_description_presenter.descriptions
        description  = descriptions.first

        expect(descriptions.length).to eq(1)
        expect(description[:title]).to be_blank
        expect(description[:link]).to be_blank
        expect(description[:description]).to match /no descriptions were found/i
      end
    end
  end

end
