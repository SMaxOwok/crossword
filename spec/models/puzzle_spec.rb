# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Puzzle, type: :model do

  it 'has a valid factory' do
    expect(FactoryBot.build(:puzzle)).to be_valid
  end

  describe '#set_day_of_week!' do
    let(:date) { Date.today }
    let(:subject) { FactoryBot.build(:puzzle, date: date) }
    let(:expected) { date.strftime('%A').downcase }

    it 'sets the day of week by #date' do
      expect do
        subject.save
      end.to change(subject, :day_of_week).from(nil).to(expected)
    end
  end
end
