# ACPC Server

This [README](README.md) contains information about the server code for the [Annual Computer Poker Competition](http://www.computerpokercompetition.org/).  Please see the [LICENCE](LINCENSE.md) file for information regarding the code's licence.

## Software Requirements

This code was developed and tested for use on Unix based systems.  Though it may work on other platforms, there are no guarantees.

You will need standard Unix developer tools to build the software including `gcc`, and `make`.

## Getting Started

### Building the code

The Makefile provides instructions for compiling the code.  Running `make` from the command line will compile the required programs.

### The programs

- `dealer` - Communicates with agents connected over sockets to play a game
- `example_player` - A sample player implemented in C
- `play_match.pl` - A perl script for running matches with the dealer

Usage information for each of the programs is available by running the executable without any arguments.

### Playing a match

The fastest way to start a match is through the `play_match.pl` script.  An example follows:

```
$ ./play_match.pl matchName holdem.limit.2p.reverse_blinds.game 1000 0 Alice ./example_player.limit.2p.sh Bob ./example_player.limit.2p.sh
```

After `play_match.pl` finishes running, there will be two output files for the dealer and two output files for each player in the game:

- `matchName.err` - The stderr from dealer including the messages sent to players
- `matchName.log` - The log for the hands played during the match
- `matchName.playerN.std` - stdout from player N
- `matchName.playerN.err` - stderr from player N

Note, `play_match.pl` expects player executables that take exactly two arguments: the server IP followed by the port number.  The executable must be specified such that it is either a path or the executable name if it can be found in your `$PATH`.

If you need to pass specific arguments to you agent, we suggest wrapping it in another script.  `play_match.pl` will pass any extra arguments to dealer. Matches can also be started by calling dealer and starting the players manually.  More information on this is contained in the dealer section below.

### Dealer

Running dealer will start a process that waits for other players to connect to it.  After starting dealer, it will output something similar to the following:

```
$ ./dealer matchName holdem.limit.2p.reverse_blinds.game 1000 0 Alice Bob
16177 48777
# name/game/hands/seed matchName holdem.limit.2p.reverse_blinds.game 1000 0
#--t_response 10000
#--t_hand 600000
#--t_per_hand 6000
```

On the first line of output there should be as many numbers as there are players in the game (in this case, "16177" and "48777").  These are the ports the dealer is listening on for players.  Note that these ports are specific to the positions for players in the game.

Once all the players have connected to the game, the dealer will begin playing the game and outputting the messages sent to each player.  After the end of the match, you should have a log file called `matchName.log` in the directory where dealer was started with the hands that were played.

Matches can also be started by starting the dealer and connecting the executables by hand.  This can be useful if you want to start your own program in a way that is difficult to script (such as running it in a debugger).

## Game Definitions

The dealer takes game definition files to determine which game of poker it plays.  Please see the included game definitions for some examples.  The code for handling game definitions is found in `game.c` and `game.h`.

Game definitions can have the following fields (case is ignored):

- `gamedef` - the starting tag for a game definition 
- `end gamedef` - ending tag for a game definition
- `stack` - the stack size for each player at the start of each hand (for no-limit)
- `blind` - the size of the blinds for each player (relative to the dealer)
- `raisesize` - the size of raises on each round (for limit games)
- `limit` - specifies a limit game
- `nolimit` - specifies a no-limit game
- `numplayers` - number of players in the game
- `numrounds` - number of betting rounds per hand of the game
- `firstplayer` - the player that acts first (relative to the dealer) on each round
- `maxraises` - the maximum number of raises on each round
- `numsuits` - the number of different suits in the deck
- `numranks` - the number of different ranks in the deck
- `numholecards` - the number of private cards to deal to each player
- `numboardcards` - the number of cards revealed on each round

Empty lines or lines with `#` as the very first character will be ignored.

If you are creating your own game definitions, please note that game.h defines some constants for maximums in games (e.g., number of rounds).  These may need to be changed for games outside of the what is being run for the [Annual Computer Poker Competition](http://www.computerpokercompetition.org/).
