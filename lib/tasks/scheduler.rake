task :remind => :environment do
  u = User.where(email: 'adam.szczombrowski@gmail.com').first
  entry = Entry.new(content: 'test entry')
  JournalMailer.welcome_mail(u, entry).deliver_now
end
