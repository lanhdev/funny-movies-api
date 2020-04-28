require 'rails_helper'

RSpec.describe User, type: :model do
  subject { user }

  let(:user) { build(:user) }

  it { is_expected.to respond_to(:username) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:password_confirmation) }

  it { is_expected.to be_valid }

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }

  it { should have_many(:movies) }
end
