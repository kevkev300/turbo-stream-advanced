# README

This is a little tik tak toe Ruby on Rails app to demonstrate some advanced hotwire turbo stream broadcasting functionality that is **NOT a chat**!

## Use Case

- Tik Tak Toe game
- 2 player involved
- Can only play when both players are in the game simultaneously
- Actions of one player effect the other player’s UI

To make it interesting and have some level up in complexity we have 3 constraints that build on each other. Each constraint has its own branch so that you can check out the changes for each constraints easily.

### Constraint 1
Player 1 needs to start the game and can only do so once Player 2 is present.

- Level: basic turbo stream broadcasting usage
- Branch: `master`

### Constraint 2
Only 2 players are allowed to connect via the websocket in one game.

- Level: reject connection within ActionCable::Connection for a third player
- Branch: `constraint_2`

### Constraint 3
Player 2 cannot be in the process without Player 1. When Player 1 leaves, Player 2 is kicked out.

- Level: Customized (ActionCable::Channel) with unsubscription logic (aka CleanUp)
- Branch: `constraing_2`
