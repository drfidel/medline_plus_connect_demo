require 'rails_helper'

RSpec.describe CodeDescription do
  it { is_a? ActiveModel::Model }
  it_behaves_like 'a DiagnosisCodeHelper model'

  context 'attributes' do
    let(:cd)   { CodeDescription.new }
    let(:data) { { hash: 'browns' } }
    let(:code) { 'J01.01' }

    describe '#description_data=' do
      it 'should not be publically writable' do
        expect{ cd.description_data = data }.to raise_error(
          NoMethodError, /private method `description_data=' called/)
      end

      it 'should be publically readable' do
        allow(cd).to receive(:description_data) { data }

        expect{ cd.description_data }.to_not raise_error
        expect(cd.description_data).to eq(data)
      end
    end

    describe '#code' do
      it 'should be publically writable' do
        expect{ cd.code = code }.to_not raise_error
      end

      it 'should be publically readable' do
        allow(cd).to receive(:code) { code }

        expect{ cd.code }.to_not raise_error
        expect(cd.code).to eq(code)
      end
    end
  end

end
