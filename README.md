# Tasks

## #1

Requests to Acme's API are timing out after 15 seconds. After some investigation in production, they've identified that the `User#count_hits` method's response time is around 500ms and is called 50 times per second (on average).

### Objective

Make changes to the code provided so that the API response time is back to acceptable levels and users no longer see timeouts. Feel free to use additional gems, tools, methods, or techniques.


### Solution

Using Redis cache to store hits count per user. That will avoid querying the hits table for each request.
Querying the hits table will be an expensive task because the hits table will grow rapidly.


## #2

Users in Australia are complaining they still get some “over quota” errors from the API after their quota resets at the beginning of the month and after a few hours it resolves itself.

### Objective

Describe the root cause of the issue and provide a fix for it.

### Solution

The issue is because of the timezone. 
While fetching the hits count, we are doing `Time.now.beginning_of_month` and `created_at` in the `hits` table is in UTC.
So, to fix this we can do `Time.current.beginning_of_month`. That is why for setting the cache expiry, we are doing `Time.current.end_of_month`.


## #3

Acme identified that some users have been able to make API requests over the monthly limit.

### Objective

Describe how can that be possible and provide a fix for it.

### Solution

I can think of 2 possible reasons:
1. Timezone: The user is in GMT - HOURS timezone. This should get fixed because now we are using UTC time for comparison.
2. An edge case would be "multiple requests have come in at the same time and the existing hits are not committed into the DB yet".
Redis cache should solve the issue because we are not querying DB for checking quota.


## #4

Acme's development team has reported working with the code base is difficult due to accumulated technical debt and bad coding practices. They've asked the community to help them refactor the code so it's clean, readable, maintainable, and well-tested.

### Objective

Make changes to the code so it matches Acme's new code quality standards.


### Solution

1. Using the cache makes the code simple & clean.
2. I have moved the code into individual concerns.
3. Added basic spec folder to show how specs will look.
4. Added I18n to move strings into yml.
5. Further controller specs cleanup can be done by creating request specs.
