Given(/^it is currently (.+)$/) do |date|
  date = Date.parse(date)
  Timecop.travel date
end
