all:
	mkdir -p dist && \
		elm make src/Main.elm --output dist/app.js && \
		cp -r assets dist/ && \
		cp index.html dist/

live:
	npx elm-live src/Main.elm

test:
	elm-test
