require 'rails_helper'

RSpec.describe User, type: :model do
    it 'returns the full username for a user' do
        user = build(:user, email: 'poop@poop.com', password: 'poopoo')
        expect(user.email).to eq 'poop@poop.com'
    end
end
