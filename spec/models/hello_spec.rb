require 'rails_helper'

describe 'Hello' do
  before do
    puts '1'
  end

  before(:all) do
    puts 'before all'
  end

  before(:suite) do
    puts 'before suite'
  end

  describe 'normal expect' do

    it 'to eq' do
      expect(1+1).to eq(2)
    end

    it 'not to eq' do
      expect(1+2).not_to eq(2)
    end

  end

  describe 'string matcher' do
    it 'include' do
      expect('abcdef').to include('bcd')
    end
  end

  describe 'be' do
    it 'be >' do
      expect(1).to be > 0
    end

    it 'be xxxx? method' do
      u = User.new
      expect(u.new_record?).to eq(true)
      expect(u).to be_new_record
    end
  end

  describe 'expect change...to' do

    before do
      puts '3'
    end

    describe 'yyy' do

      before do
        puts '4'
      end

    end

    describe 'xxxx' do

      before do
        puts '2'
      end

      it do
        puts '2-1'
      end

      it do
        puts '2-2'
      end
    end

    let!(:c) do
      puts '222'
      Category.create(name: 'haha')
    end

    before do
      puts '111'
    end

    it 'testing let' do
      c
      puts 'second: c'
      c
    end

    it 'normal' do
      puts "3-1"
      expect {
        c.save
      }.to change { Category.count }
    end

    it '.by' do
      expect {
        c.save
      }.to change { Category.count }.by(1)
    end

    it '.to' do
      expect {
        c.save
      }.to change { Category.count }.to(1)
    end

    it '.from ... .to' do
      expect {
        c.save
      }.to change { Category.count }.from(0).to(1)
    end
  end
end
