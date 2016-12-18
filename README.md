# Tilter
Tilter is a twitter-like webapp where you can post what made you tilt instead of
useful informations.
It was created to learn Rails as part of a school assignment.

![build](https://travis-ci.org/baloran/tilter.svg?branch=master)

## Install

```
bundle install
```

## Make the awesome

```
rake db:drop && rake db:create && rake db:migrate && rake db:seed
rails s
```

## To run the tests

```
rake db:migrate RAILS_ENV=test
rspec
```

## Guidelines

[Ruby Styleguide](https://github.com/bbatsov/ruby-style-guide)

[Linter](https://github.com/bbatsov/rubocop)
