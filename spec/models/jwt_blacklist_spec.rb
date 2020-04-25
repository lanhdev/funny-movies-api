require 'rails_helper'

RSpec.describe JwtBlacklist, type: :model do
  subject { jwt_blacklist }

  let(:jwt_blacklist) { build(:jwt_blacklist) }

  it { is_expected.to respond_to(:jti) }
  it { is_expected.to respond_to(:exp) }
end
