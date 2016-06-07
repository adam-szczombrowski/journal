class JournalMailer < ApplicationMailer
  default from: 'journal@example.com'

  def remind_mail(user, entry)
     @user = user
     @url = 'https://journal-everyday.herokuapp.com/entries/new'
     @entry = entry
     mail(to: @user.email, subject: 'What is on your mind today?')
  end
end
