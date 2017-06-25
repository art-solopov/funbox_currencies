# README

A qualification assignment — a currency exchange service with pub/sub.

This app was developed and tested on Ruby 2.4.0.

## How to run

1. Install Ruby & bundler
1. Install PostgreSQL
1. Install Redis
1. `bundle install`
1. `rake db:create`
1. `rake db:schema:load`
1. `yarn install`
1. `foreman start`

## How to test

1. Make sure all the above dependencies are installed.
1. Install PhantomJS.
1. `rails spec`
