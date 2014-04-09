# Sudoku - Web Version

The Week 5 Project for Makers Academy, this is a web version of the week 4 project (albeit with a standard version of the business logic provided as part of the challenge). The Sinatra-based application provides you with a Sudoku to solve, and tells you whether or not your answer is correct. The app's online [here](http://lit-scrubland-pro.herokuapp.com/) and details are below.

## How to play

To recap, Sudoku is a game in which you must place the numbers one to nine, nine times each, into a nine by nine grid such that there is only one instance of each number in every row, column, and three by three box. But you probably knew that already. When you load up the site (address above), you'll be presented with a random Sudoku of normal difficulty. You can then proceed to solve the puzzle by entering the correct answer in the correct cell (as you'd expect).

Once you're finished, stuck, or just bored, there are seven buttons to play with (well, `.button`s, anyway - they're a mixture of `<button>`s, `<input>`s and `<a>`s, which makes styling more painful than usual. There was one day in the course where I think my only topic of conversation was button alignment. Anyway...). These do the following: 

### 1 Check Solution

This checks your entered values against the correct answers. Any incorrect answers are highlighted in red. Correct answers stay white. Provided values remain grey.

### 2 View Solution

This shows you the correct answer, with provided values in grey. The only buttons on this page are for starting a new puzzle, the assumption being that if you're viewing the solution, you aren't all that interested in solving the previous puzzle for yourself.

### 3 Save Solution

Allows you to save your current guesses in the session, letting you return to the site (slightly) later to continue puzzling.

### 4 New Sudoku

This randomly generates a new puzzle for you to solve of a normal difficulty.

### 5 New Hard Sudoku

This does the same as the previous button, but with more cells left blank, giving you more of a challenge.

### 6 Reset

This is just an input[type=reset] because I was curious about how it works. This will clear out any entries you have added on this visit to the site, but won't clear any values saved (with the save button). Essentially, it's a reset to saved state button. If you want to fully restart the puzzle, you'll want:

### 7 Really Reset

This cleans every single value that you've entered, giving you a clean start on the same puzzle.

## Deployment

The test for this week was to deploy the app to Heroku, in both a production and staging version, with New Relic monitoring for the production version. They're identical, but if you're curious you can find them here:

- [Staging](http://lit-scrubland-5491.herokuapp.com/)
- [Production](http://lit-scrubland-pro.herokuapp.com/)
