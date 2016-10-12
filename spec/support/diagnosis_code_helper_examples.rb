shared_examples_for 'a DiagnosisCodeHelper model' do

  let(:diagnosis_code_helper_example) { described_class.new }
  let(:description_data)              { { hash: 'browns' } }
  let(:code)                          { 'S11.12' }

  describe '#fetch_code_description_data!' do
    it 'sets the model\'s #description_data attribute' do
      allow(diagnosis_code_helper_example).to receive(:fetch_code_description_data!) {
        diagnosis_code_helper_example.send(:description_data=, description_data) }

      expect{ diagnosis_code_helper_example.fetch_code_description_data! }.not_to raise_error
      expect(diagnosis_code_helper_example.description_data).to eq(description_data)
    end
  end

  describe '#code_description' do
    context 'successful API call' do
      it 'returns a description of a diagnosis code' do
        allow(diagnosis_code_helper_example).to receive(:code_description) { description_data }

        expect{ diagnosis_code_helper_example.code_description(code) }.not_to raise_error
        expect(diagnosis_code_helper_example.code_description(code)).to eq(description_data)
      end
    end

    context 'unsuccessful API call' do
      it 'raises a DiagnosisCodeServiceError' do
        allow(diagnosis_code_helper_example).to receive(:code_description).and_raise(
          DiagnosisCodeServiceError, 'Error(s) with diagnosis code description service: service unreachable.')

        expect{ diagnosis_code_helper_example.code_description(code) }.to raise_error(
          DiagnosisCodeServiceError, /Error\(s\) with diagnosis code description service: /)
      end
    end
  end
end
