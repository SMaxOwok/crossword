# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Puzzle, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:puzzle)).to be_valid
  end

  it 'is invalid without a user' do
    expect(FactoryBot.build(:puzzle, user: nil)).to_not be_valid
  end

  describe ':completed' do
    context 'when true' do
      it 'is invalid without a time' do
        expect(FactoryBot.build(:puzzle, completed: true, hours: 0, minutes: 0, seconds: 0)).to_not be_valid
      end
    end

    context 'when false' do
      it 'is valid without a time' do
        expect(FactoryBot.build(:puzzle, completed: false, hours: 0, minutes: 0, seconds: 0)).to be_valid
      end
    end
  end

  describe '#formatted_time' do
    context 'when time present' do
      let(:subject) { FactoryBot.build_stubbed(:puzzle, hours: 2, minutes: 43, seconds: 2) }

      it 'returns a string in the format hms' do
        expect(subject.formatted_time).to eq '2h43m2s'
      end
    end

    context 'when time not present' do
      let(:subject) { FactoryBot.build_stubbed(:puzzle, hours: 0, minutes: 0, seconds: 0, completed: false) }

      it 'returns \'-\'' do
        expect(subject.formatted_time).to eq '-'
      end
    end
  end

  describe '#set_day_of_week!' do
    let(:date) { Date.today }
    let(:subject) { FactoryBot.build(:puzzle, date: date) }
    let(:expected) { date.strftime('%A').downcase }

    it 'sets :day_of_week by :date' do
      expect do
        subject.save
      end.to change(subject, :day_of_week).from(nil).to(expected)
    end
  end

  describe '#set_time_taken_in_seconds!' do
    let(:subject) { FactoryBot.create(:puzzle) }

    context 'when hours, minutes, or seconds are changed' do
      it 'changes :time_taken_in_seconds' do
        subject.hours = subject.hours + 1
        expect { subject.save }.to change(subject, :time_taken_in_seconds)
      end
    end

    context 'when hours, minutes, or seconds are unchanged' do
      it 'does not change :time_taken_in_seconds' do
        expect { subject.save }.to_not change(subject, :time_taken_in_seconds)
      end
    end
  end

  describe 'filtering' do
    before(:all) do
      user = FactoryBot.create(:user)
      30.times { |i| FactoryBot.create(:puzzle, date: Date.today - i.days, user: user) }
    end

    it 'can be filtered by :completed' do
      subject = false

      expect(Puzzle.filter(completed: subject).pluck(:completed)).to all eq subject
    end

    it 'can be filtered by :day_of_week' do
      subject = 'tuesday'

      expect(Puzzle.filter(day_of_week: subject).pluck(:day_of_week)).to all eq subject
    end

    it 'can be filtered by :source' do
      subject = 'nyt'

      expect(Puzzle.filter(source: subject).pluck(:source)).to all eq subject
    end
  end
end
