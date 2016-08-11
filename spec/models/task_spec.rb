require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do 
    it 'should switch complete to false if it began as true' do 
      task = Task.create(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end

    it 'should switch complete to true if it began as false' do 
      task = Task.create(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end

  describe '#overdue?' do 
    it 'should return true if deadline of task is earlier than now' do 
      task = Task.new(deadline: 1.day.ago)
      expect(task.overdue?).to eq(true)
    end

    it 'should return false if deadline of task is later than now' do 
      task = Task.new(deadline: 1.day.from_now)
      expect(task.overdue?).to eq(false)
    end
  end

  describe '#snooze_hour!' do 
    it 'should move the deadline past one hour' do
      deadline = DateTime.new(2016, 10, 31)
      task = Task.new(deadline: deadline)
      task.snooze_hour!
      expect(task.deadline).to eq(deadline + 1.hour)
    end
  end
end
