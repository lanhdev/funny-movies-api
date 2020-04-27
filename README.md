# Funny Movies API

### Prerequisites

* [Ruby](https://www.ruby-lang.org/en/): 2.5.1
* [PostgreSQL](https://www.postgresql.org/) 9.4 or higher.

### Installation

0.  Make sure all the prerequisites are installed.
1.  Clone the repository
2.  `gem install bundler -v 1.17.3`
3.  `bundle install`
4.  Set up your environment variables/secrets
    * Take a look at `.env.development`. This file lists all the `ENV` variables which are used in the application.
    * For any key that you wish to enter/replace:
      a.  Create `.env` by copying from the provided template (ie. with bash: `cp .env.development .env`). This file will be ignored by git.
      b.  Obtain the development variable and apply the key you wish to enter/replace. ie:
      ```
      DEVISE_JWT_SECRET_KEY: can generate this key by running command `rails secret`
      ```
### Database creation
* Run `rails db:create db:schema:load` to create database and load the schema

### Database initialization
* * Run `rails db:seed` to add example data

### Starting the application
* Run `rails server` to start the application

### How to run the test suite

* Run all specs: `rspec`
* Run all features:
  * Starting the backend by running `rails server`
  * Starting the fronend by cloning frontend repository [funny-movies-app](https://github.com/lanhhoang/funny-movies-app) and running `npm run start`
  * `cucumber`
