require 'rails_helper'

RSpec.describe RatesHistory, type: :model do
  it_behaves_like 'model with a factory'

  describe 'validations' do
    it { is_expected.to validate_inclusion_of(:from_currency).in_array(SUPPORTED_CURRENCIES) }
    it { is_expected.to validate_inclusion_of(:to_currency).in_array(SUPPORTED_CURRENCIES) }
    it { is_expected.to validate_numericality_of(:rate).is_greater_than(0) }
  end
end
