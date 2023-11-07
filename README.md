# Tasks

## #1

Requests to Acme's API are timing out after 15 seconds. After some investigation in production, they've identified that the `User#count_hits` method's response time is around 500ms and is called 50 times per second (on average).

### Objective

Make changes to the code provided so that the API response time is back to acceptable levels and users no longer see timeouts. Feel free to use additional gems, tools, methods, or techniques.


### Solution

Using redis cache to store hits count per user. That will avoid quering hits table for each request.
Quering hits table will be an expensive task because hits table will grow rapidly.


## #2

Users in Australia are complaining they still get some “over quota” errors from the API after their quota resets at the beginning of the month and after a few hours it resolves itself.

### Objective

Describe the root cause of the issue and provide a fix for it.

### Solution

The issue is because of timezone. 
While fetching the hits count, we are doing `Time.now.beginning_of_month` and `created_at` in the `hits` table is in UTC.
So, to fix this we can do `Time.current.beginning_of_month`. That is why for setting the cache expiry, we are doing `Time.current.end_of_month`.


## #3

Acme identified that some users have been able to make API requests over the monthly limit.

### Objective

Describe how can that be possible and provide a fix for it.

### Solution

This can be because multiple requests have come in at the same time and the existing hits are not committed into the DB yet.
Using the redis cache should solve the issue because we are not quering DB for checking quota.


## #4

Acme's development team has reported working with the code base is difficult due to accumulated technical debt and bad coding practices. They've asked the community to help them refactor the code so it's clean, readable, maintainable, and well-tested.

### Objective

Make changes to the code so it matches Acme's new code quality standards.


### Solution

> Using the cache makes the code simple & clean.
> I have moved the code into individual concerns.
> Added basic spec folder to show how specs will look.
> Added I18n to move strings into yml.
> Further controller specs cleanup can be done by creating request specs.
