build:
	mkdir -p run
	elm make src/Main.elm --output=run/elm.js --debug

test:
	elm-test
