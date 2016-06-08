task :remind => :environment do
  users = User.all.decorate
  users.each do |u|
    entry = Entry.where(user_id: u.id).order("RANDOM()").first.decorate
    JournalMailer.remind_mail(u, entry).deliver_now
  end
end
