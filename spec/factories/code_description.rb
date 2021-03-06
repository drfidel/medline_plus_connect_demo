FactoryGirl.define do
  factory :code_description do

    code 'J01.01'

    trait :successful do
      after :build do |cd|
        allow(cd).to receive(:description_data) { [{
          title:'Sinusitis',
          link: 'https://medlineplus.gov/sinusitis.html',
          description: 'Sinusitis means your sinuses are inflamed.' }] }
      end
    end

    trait :unsuccessful do
      after :build do |cd|
        allow(cd).to receive(:description_data) { nil }
      end
    end

  end
end
