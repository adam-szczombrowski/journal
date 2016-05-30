class JournalMailer < ApplicationMailer
  default from: 'journal@example.com'

  def welcome_mail(user, entry)
     @user = user
     @url = 'https://journal-everyday.herokuapp.com/entries/new'
     @entry = entry
     puts 'nice'
     mail(to: @user.email, subject: 'Welcome to journal')
  end
end
