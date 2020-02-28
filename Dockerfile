FROM node:12.13.1 AS builder

WORKDIR /home/node

COPY package.json .
RUN chown -R node:node .


ARG BUILD_EXPIRE
ARG BUILD_DOMAIN
ARG NPM_AUTH_TOKEN

RUN npm i -g yarn

RUN chown node:node .

USER node

ENV NPM_AUTH_TOKEN=${NPM_AUTH_TOKEN}

RUN echo "//registry.npmjs.org/:_authToken=${NPM_AUTH_TOKEN}" > .npmrc
RUN yarn config set registry https://registry.npm.taobao.org/
RUN yarn install

COPY . .

USER root
RUN chown -R node:node src/ public/ build/

USER node
RUN ./scripts/build.sh

FROM nginx:mainline-alpine

COPY --from=builder /home/node/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 3000
