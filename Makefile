all:
	hare build -R -L. -lraylib -o examples/game examples/game.ha
	hare build -R -L. -lraylib -o examples/fib examples/fib.ha

compile-game:
	hare build -R -L. -lraylib -o examples/game examples/game.ha

game: compile-game
	./examples/game

compile-fib:
	hare build -R -L. -lraylib -o examples/fib examples/fib.ha

fib: compile-fib
	./examples/fib
