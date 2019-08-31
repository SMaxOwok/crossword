require 'rails_helper'

RSpec.describe StatisticsAuthorizer, type: :authorizer do
  let(:owner) { FactoryBot.create(:user, email: 'owner@example.com') }
  let(:unauthorized) { FactoryBot.create(:user, email: 'unauthorized@example.com') }

  describe 'instance authorization' do
    let(:subject) { owner.statistics }

    before(:each) { FactoryBot.create(:puzzle, user: owner) }

    context 'when owner' do
      it 'can be read' do
        expect(subject.authorizer).to be_readable_by(owner)
      end
    end

    context 'when not owner' do
      it 'cannot be read' do
        expect(subject.authorizer).to_not be_readable_by(unauthorized)
      end
    end
  end
end
