compile:
	hare build -R -L. -lraylib -o example/example example/example.ha
run: compile
	./example/example
