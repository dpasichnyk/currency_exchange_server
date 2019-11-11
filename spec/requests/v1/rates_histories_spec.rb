require 'rails_helper'

RSpec.describe 'Rates histories', type: :request do
  let!(:rates_histories) { create_list :rates_history, 25 }
  let(:url) { '/v1/rates_histories' }

  before { get url }

  it 'generally works' do
    expect(response.status).to eq 200
    expect(JSON.parse(response.body).length).to eq 25
  end
end