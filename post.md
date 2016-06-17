om # Journal everyday

I started to write journal many times, but never kept too long with it. Journaling has numerous benefits that I've seen for myself. Considering this I thought that it's the highest time for my own journal app which will help me with keeping the habit. It was also a great opportunity to learn a little bit more about `ActionMailer`.

## Jobs to be done

When it comes to jobs to be done it's really simple:
1. I want to receive daily email reminders.
2. I want to be able to create journal entries and review them.

In other words it's an app with a single resource (entry) with CRUD functionality. Moreover I'm using `Devise` to manage users accounts.

Because I've never used `ActionMailer` before the challenge here was to send daily reminders.

## ActionMailer

The RailsGuides provide good [introduction](http://guides.rubyonrails.org/action_mailer_basics.html) to `ActionMailer`. After reading the guide I knew what I need to do. First of all `generate` my `JournalMailer` and define method for sending remind emails like this:

```ruby
class JournalMailer < ApplicationMailer
  def remind_mail(user, entry)
     @user = user
    #  @url = 'https://journal-everyday.herokuapp.com/entries/new'
     @entry = entry
     mail(to: @user.email, subject: 'What is on your mind today?')
  end
end
```

The `@user`, `@url` and `@entry` instance variables will be used in mailer views pretty much the same way it works with controllers and views.

## Email views

`rails generate mailer JounralMailer` command generates layouts for views both in `html` and `txt` format as well as `views/journal_mailer` directory where mailer views will reside. I've created the `remind_mail.html.erb` (notice the correlation between view name and method name in `JournalMailer` - pretty much the same as with controllers). `remind_mail.html.erb` looks like this:

```html
<!DOCTYPE html>
<html>
  <head>
    <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
  </head>
  <body>
    <h2>Hi, <%= @user.name %>!</h2>
    <h2>This is your post from <%= @entry.creation_date %>:</h2>
    <% @entry.content.each_line do |l| %>
    <h3>
      <%= l %>
    </h3>
    <% end %>
    <h3>
      Go to <%= @url %> to add new entry!
    </h3>
  </body>
</html>
```
It's supposed to consist of random entry from the past and a link to adding new entry.

## Sending emails

Now everything is in place for sending emails. The last thing to do is configuration of `ActionMailer`. I decided to send emails from gmail account. In order to do this you need to add to your `config/environments/production` following configuration:

```ruby
config.action_mailer.delivery_method = :smtp
# SMTP settings for gmail
config.action_mailer.smtp_settings = {
 :address              => "smtp.gmail.com",
 :port                 => 587,
 :user_name            => ENV['gmail_username'],
 :password             => ENV['gmail_password'],
 :authentication       => "plain",
:enable_starttls_auto => true
}
```
But where does rails take this `ENV['gmail_username']` and `ENV['gmail_password']` from?

#### Figaro gem

With Figaro it's super easy to configure application hosted on Heroku with those variables. All you have to do is:
1. Create `config/application.yml` and put those variables in it.
2. Set the values from your configuration file with a command:
`$ figaro heroku:set -e production`

Those steps are explained in detail on [Figaro website](https://github.com/laserlemon/figaro).

Last thing to do is to allow the less secure apps to access your account. You can do it [this way](https://support.google.com/accounts/answer/6010255?hl=en). Finally we are able to send emails from app with a gmail account.

## Schedule it!

Next thing to do is to schedule the task of sending emails for 8 am every morning. Again Heroku makes it easy: there is a `scheduler` add-on which you need to add to your app. Then all that is left to do is:
1. Create `lib/tasks/scheduler.rake` and create a rake task in this file.
```ruby
task :remind => :environment do
  users = User.all.decorate
  users.each do |u|
    entry = Entry.where(user_id: u.id).order("RANDOM()").first.decorate
    JournalMailer.remind_mail(u, entry).deliver_now
  end
end
```

2. Schedule the time for the task on [Heroku scheduler website](https://scheduler.heroku.com/dashboard).

## Wrapping up

Creating this app I learned a lot about `ActionMailer`. I spent some time looking for the best way to schedule rake tasks. What is most important I'm journaling again and don't plan to stop anytime soon.
