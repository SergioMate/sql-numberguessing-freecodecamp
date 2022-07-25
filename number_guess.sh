#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

NUMBER=$(($RANDOM % 1000 + 1))

echo "Enter your username:"
read USERNAME
PLAYER=$($PSQL "SELECT username, games_played, best_game FROM players WHERE username='$USERNAME'")
if [ -z "$PLAYER" ]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here"
  $PSQL "INSERT INTO players(username) VALUES('$USERNAME')" > /dev/null
else
  echo $PLAYER | {
    IFS=" | "
    read USERNAME GAMES_PLAYED BEST_GAME
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  }
fi
