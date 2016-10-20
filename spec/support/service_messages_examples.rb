shared_examples_for 'a ServiceMessages service' do

  it { expect( described_class.const_defined?(:MESSAGE_SUCCESS) ).to eq(true) }
  it { expect( described_class::MESSAGE_SUCCESS.frozen? ).to eq(true) }
  it { expect( described_class::MESSAGE_SUCCESS.to_s ).to eq('Success') }
  it { expect( described_class.const_defined?(:MESSAGE_INVALID) ).to eq(true) }
  it { expect( described_class::MESSAGE_INVALID.frozen? ).to eq(true) }
  it { expect( described_class::MESSAGE_INVALID.to_s ).to eq('Invalid Diagnosis Code.') }
  it { expect( described_class.const_defined?(:ERROR_NO_RESPONSE) ).to eq(true) }
  it { expect( described_class::ERROR_NO_RESPONSE.frozen? ).to eq(true) }
  it { expect( described_class::ERROR_NO_RESPONSE.to_s ).to eq('Unable to reach client.') }

end
