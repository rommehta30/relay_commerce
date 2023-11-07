require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:hits) }

  describe '#count_hits' do
    it 'returns hits count' do
    end

    it 'returns 0 in case of no hits' do
    end
  end
end
