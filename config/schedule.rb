every :day, :at => '12:01 am' do
  runner "Schedule.set_schedule",
  :output => {:error => 'error.log', :standard => 'cron.log'}
  command "/usr/bin/cmd"
end