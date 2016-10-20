FactoryGirl.define do
  factory :code_description_presenter do

    initialize_with { new build(:code_description, :successful) }

    trait :unsuccessful do
      initialize_with { new build(:code_description, :unsuccessful) }
    end

  end    
end
