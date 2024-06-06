game:
	hare build -R -L. -lraylib -o examples/game examples/game.ha
	./examples/game

fib:
	hare build -R -L. -lraylib -o examples/fib examples/fib.ha
	./examples/fib

doc:
	@rm -rf doc
	@mkdir doc
	@haredoc -t -Fhtml raylib > doc/temp
	@echo '<head> <meta charset="utf-8" /> <meta name="viewport" content="width=device-width, initial-scale=1"> </head> <style> :root { --color: #d5c4a1; --color-h1: #ebdbb2; --color-h2: #bdae93; --background-color: #1d2021; --background-color-alt: #282828; --border: #3c3836; --color-red: #fb4934; --color-yellow: #d79921; --color-blue: #458588; --color-azure: #8ec07c; --color-purple: #b16286; } *::-webkit-scrollbar { display: none; } * { font-family: monospace; } .keyword { color: var(--color-red); } .type { color: var(--color-yellow); } .comment { color: var(--color); font-weight: bold; } .heading-body { color: var(--color-yellow)} .heading-extra { color: var(--color-azure)} html { display: block; background-color: var(--background-color)} body { display: block; border: solid 2px var(--border); margin: 1em auto; padding: 1em; width: 80ch; background-color: var(--background-color-alt);} summary { color: var(--color-purple); padding: 0 1em;} a { text-decoration: none; color: var(--color-blue); } a:hover { color: var(--color-azure); } pre { padding: 1em; overflow: scroll; border: solid 2px var(--color-azure); color: var(--color); background-color: var(--background-color); margin-left: auto; margin-right: auto} ol, ul { color: var(--color); } p { color: var(--color-h2); margin-top: 0; margin-bottom: 1em; } p { margin-top: 1em; } h1 { color: var(--color-h1); } h2, h3 { color: var(--color-h2); } h4 { color: var(--color-h2); padding-bottom: 4px; border-bottom: solid 1px var(--border)}</style>' > doc/index.html
	@cat doc/temp >> doc/index.html
	@rm doc/temp

