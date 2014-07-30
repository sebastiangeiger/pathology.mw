require 'ostruct'
require_relative '../../app/models/activity_feed'

RSpec.describe ActivityFeed do
  subject { ActivityFeed.new(entries, current_year: 2014).calculate }
  let(:june_13_2014) do
    OpenStruct.new(date_submitted: Date.parse("June 13 2014"))
  end
  let(:june_14_2014) do
    OpenStruct.new(date_submitted: Date.parse("June 14 2014"))
  end
  let(:may_15_2012) do
    OpenStruct.new(date_submitted: Date.parse("May 15 2012"))
  end
  let(:january_6_2011) do
    OpenStruct.new(date_submitted: Date.parse("January 6 2011"))
  end
  describe 'for no entries' do
    let(:entries) do
      []
    end
    it { is_expected.to eql({2014 => []}) }
  end
  describe 'for one entry' do
    let(:entries) do
      [june_13_2014]
    end
    it { is_expected.to eql({2014 => [june_13_2014]}) }
  end
  describe 'for two entries' do
    let(:entries) do
      [june_13_2014,june_14_2014]
    end
    it { is_expected.to eql({2014 => [june_14_2014,june_13_2014]}) }
  end
  describe 'for three entries with a year skipped' do
    let(:entries) do
      [june_13_2014,june_14_2014,may_15_2012]
    end
    it { is_expected.to eql({2014 => [june_14_2014,june_13_2014],
                             2013 => [],
                             2012 => [may_15_2012]}) }
  end
  describe 'for two entries before the current year' do
    let(:entries) do
      [january_6_2011,may_15_2012]
    end
    it { is_expected.to eql({2014 => [],
                             2013 => [],
                             2012 => [may_15_2012],
                             2011 => [january_6_2011]}) }
    it 'has the correct sorting' do
      expect(subject.keys).to eql [2014,2013,2012,2011]
    end
  end
end
