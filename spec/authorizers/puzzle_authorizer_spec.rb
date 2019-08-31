require 'rails_helper'

RSpec.describe PuzzleAuthorizer, type: :authorizer do
  let(:owner) { FactoryBot.create(:user, email: 'owner@example.com') }
  let(:unauthorized) { FactoryBot.create(:user, email: 'unauthorized@example.com') }

  describe 'instance authorization' do
    let(:subject) { FactoryBot.create(:puzzle, user: owner) }

    context 'when owner' do
      it 'can be created' do
        expect(subject.authorizer).to be_creatable_by(owner)
      end

      it 'can be destroyed' do
        expect(subject.authorizer).to be_deletable_by(owner)
      end

      it 'can be updated' do
        expect(subject.authorizer).to be_updatable_by(owner)
      end
    end

    context 'when not owner' do
      it 'cannot be created' do
        expect(subject.authorizer).to_not be_creatable_by(unauthorized)
      end

      it 'cannot be destroyed' do
        expect(subject.authorizer).to_not be_deletable_by(unauthorized)
      end

      it 'cannot be updated' do
        expect(subject.authorizer).to_not be_updatable_by(unauthorized)
      end
    end
  end
end
