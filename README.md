## Journal


1. Answer Questions
  - What are we building?
  - Who are we building it for?
  - What features do we need to have?
2. User Stories.
3. Model our Data
4. Think through the pages we need in our app.
5. Tools

---

1.
 - I am building a journal app which sends email remainders daily    to write something.
 - I am building this app mostly for myself but also for anyone who would be interested in using it
 - Features:
    - adding new journal entries
    - seding email remainders
    - (ideally) being able to post new entry through email

2.
  - As a logged in user I can add new entry
  - As a logged in user I can view my past entries
  - As a user I recieve daily remainders on my email
  - As a user I can rate my day on the scale 1-10

3.
  - Entry:
    - content:text
    - rating:integer
  - User(with devise)

4. root => entries#index
   entries#show
   entries#new
   home#welcome

5. Devise, 
