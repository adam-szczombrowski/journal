task :remind => :environment do
  u = User.first
  u.email = 'asdfasdf@email.com'
  u.save!
  puts u
  puts u.email
end
