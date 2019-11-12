# README

Dependencies.

```
 ruby 2.6.3p62
 redis
 postgres
```

Setup:

* Copy master key https://onetimesecret.com/secret/n2zygyxg447gh1gtigk1jsf1d790hzt (password is my phone number without +(plus),
  place it to `config/master.key`.
* Run: `cp config/database.yml.example config/database.yml`, change database credentials.
   - Run `rake db:create rake db:migrate rake db:seed`.
   
* Run: `bundle exec rspec`   

**Implementation notes:**
 * There are 2 controllers: one supposed to be written in "REST" style whereas other one is "RPC" as it doesn't work with "resources".
 * Sidekiq job scheduled on 8am every day.
