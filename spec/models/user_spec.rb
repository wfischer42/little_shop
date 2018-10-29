require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_presence_of(:name)}
  it { is_expected.to validate_presence_of(:password)}
  it { is_expected.to validate_presence_of(:email)}
  it { is_expected.to validate_presence_of(:address)}
  it { is_expected.to validate_presence_of(:city)}
  it { is_expected.to validate_presence_of(:state)}
  it { is_expected.to validate_presence_of(:zip_code)}
  it { is_expected.to validate_presence_of(:role)}
  it { is_expected.to validate_uniqueness_of(:email)}
  it { is_expected.to validate_numericality_of(:zip_code)}
  it { is_expected.to have_many(:orders)}
  it { is_expected.to have_many(:items)}
  it { expect(subject.role).to eq("customer") }
end
