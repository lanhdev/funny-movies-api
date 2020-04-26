require 'rails_helper'

RSpec.describe Movie, type: :model do
  subject { movie }

  let(:movie) { build(:movie) }

  it { is_expected.to respond_to(:user_id) }
  it { is_expected.to respond_to(:url) }

  it { should belong_to :user }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:url) }
  it { should delegate_method(:name).to(:user).allow_nil }
end
