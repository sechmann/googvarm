build:
	mkdir -p run
	elm make src/Main.elm --output=run/elm.js

run:
	elm reactor index.html
