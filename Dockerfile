FROM node:alpine as buildImg

RUN apk update
RUN apk --no-cache add gnupg python make curl


RUN mkdir -p /usr/src/app
ENV PATH="$PATH:/usr/src/app"
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN npm install --production --loglevel=warn


FROM node:alpine
RUN apk add --upgrade --no-cache libssl1.1
RUN mkdir -p /usr/src/app
ENV PATH="$PATH:/usr/src/app"
WORKDIR /usr/src/app
COPY --from=buildImg /usr/src/app /usr/src/app
CMD ["npm", "start"]
