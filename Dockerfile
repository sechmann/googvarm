FROM node:10-alpine as builder
WORKDIR /home/node/app

COPY ./package* ./
RUN npm install

COPY ./src/ ./src/
COPY ./tests/ ./tests/
COPY ./assets/ ./assets/
COPY ./elm.json ./
COPY ./index.html ./

RUN npm test
RUN npm run build

FROM nginx

COPY --from=builder /home/node/app/dist /usr/share/nginx/html

#USER www-data
