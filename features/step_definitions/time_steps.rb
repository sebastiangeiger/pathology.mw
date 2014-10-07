Given(/^it is currently (.+)$/) do |date|
  date = Time.zone.parse(date).to_date
  Timecop.travel(date)
  expect(Time.zone.today).to eql(date)
end
