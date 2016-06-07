task :remind => :environment do
  u = User.where(email: 'adam.szczombrowski@gmail.com').first
  entry = Entry.where(user_id: u.id).order("RANDOM()").first.decorate
  JournalMailer.remind_mail(u, entry).deliver_now
end
