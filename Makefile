all:
	mkdir -p dist && \
		./node_modules/.bin/elm make src/Main.elm --output dist/app.js && \
		cp -r assets dist/ && \
		cp index.html dist/

live:
	./node_modules/.bin/elm-live src/Main.elm

test:
	./node_modules/.bin/elm-test

install:
	npm install
