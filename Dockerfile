FROM ruby:2.6-alpine

WORKDIR /usr/src/app

COPY . .

CMD ["./logs-nodes.rb"]
