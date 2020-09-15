all:
	npm run build

live:
	npx elm-live src/Main.elm

test:
	elm-test
