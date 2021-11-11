# Welcome to tea_subscription_api
  - API for a Tea Subscription Service.

## Table of Contents

- [Overview](#overview)
- [Tools Utilized](#tools-used)
- [Getting Started](#getting-started)
- [Endpoints](#endpoints)
- [Database Schema](#database-schema)
------

### Overview

- An endpoint to subscribe a customer to a tea subscription
- An endpoint to cancel a customer’s tea subscription
- An endpoint to see all of a customer’s subsciptions (active and cancelled)

------

## Tools Used

| Stack            | Database       | Testing suite   | Gems            |
|   :----:         |    :----:      |    :----:       |    :----:       |
| Ruby 2.7.2       | PostgresSQL    | RSpec           | Pry             |
| Rails 5.2.5       |               |                 | ShouldaMatchers |
|                  |                |                 | SimpleCov       |
|                   |               |                 | Capybara        |
|                   |               |                 | rspec-rails     |
|                   |               |                 | fast_jsonapi    |
|                   |               |                 | launchy         |

------

## Endpoints

The following table presents each API endpoint and its documentation.


HTTP Verb | Endpoint              | Description                              | 
----------|-----------------------|------------------------------------------|
POST       | `/api/v1/subscriptions` | Create a new customer tea subscription | 


------


## Database Schema
![Screen Shot 2021-11-11 at 1 20 57 PM](https://user-images.githubusercontent.com/81139173/141376739-8ee4ce33-4d5a-4834-b156-de3c75654ffa.png)
