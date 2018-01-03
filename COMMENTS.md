### Install

To get application running

- `npm install`
- `bundle`
- `rake db:create`
- `rake db:migrate`
- `bundle exec rails s`

And in a separate tab:
- `redis-server`

### Usage

- Visit `http://localhost:3000/`
- Click **Sign Up** and login to the app
- Fill out a **Household size*
- Fill out an **Income*
- Click **Submit**


### Things that I would have done

This is an MVP; however, it is no where near being in the condition that I would ever submit it as a completed PR yet.

Some general areas that I would have addressed before submitting as a completed PR:

- refactoring
- apply styling best practices
- apply pattern best practices
- add spec coverage
- add Yard documentation
- add CSS and styling
- add clear UI for logging in and out
