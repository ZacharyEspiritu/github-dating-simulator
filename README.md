# Github Dating Simulator

A hackathon team matcher that analyzes compatibility between Github users by using graph theory and the power of love.

## Inspiration

As high school students, finding love can be hard. Similarly, finding teams at hackathons can be hard. (But not as hard as finding love, of course.)

## What it does

Github Dating Simulator comes in two flavors. Dating mode allows a user to input two Github usernames to determine how compatible they are. Team generation mode, which allows a user to input a list of Github usernames, will return the best possible pairings for each of the users.

To create matchings, it looks at the language usage of each user and compares it on an experience-based level to those of the other users. This means that a person who has a lot of repositories written in Ruby will be marked at an "expert-level" while someone who only has only 70 lines of Swift will be marked at a "beginner-level".

This allows users to be matched with other coders proportional to their skill level, making for a much easier hackathon experience overall.

## How we built it

On a graph, each user is plotted from other users with different paths of varying "lengths". Path length is calculated by the mean square difference of each of the languages a user knows. The algorithm tries to find the shortest path (hence, the more code written in a language) between two users.

Once a user has been matched with another user, it will delete both users from the graph so they cannot be matched again. The algorithm continues until all users have been matched or there are no more available users to match.

## Challenges we ran into

The Github API has rate limiting, which prevents one from making too many requests in a given time frame. We implemented caching with ActiveRecord in Rails to solve this.

## Accomplishments that we're proud of

Statistical analysis in the matching algorithm.

## What we learned

We learned how to use the Github API and how to write a really efficient quality-based algorithm.

## What's next for Github Dating Simulator

Finding people more love (and hackathon teams).
