require 'rails_helper'

  describe 'Merchant Index Page' do
    before { visit merchants_path }
    subject { merchants_path }

    it {is_expected.to eq(merchants_path)}
  end
