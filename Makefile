build:
	mkdir -p run
	elm make src/Main.elm --output=run/elm.js --debug

run:
	elm reactor index.html
