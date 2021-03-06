FROM alpine:edge

WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN apk --update add nodejs git ruby ruby-dev ruby-bundler less ruby-nokogiri build-base && \
    bundle install -j 4 && \
    apk del build-base && rm -fr /usr/share/ri

RUN npm install -g codeclimate/csslint.git#7a3a6be

RUN adduser -u 9000 -D app
USER app

COPY . /usr/src/app

CMD ["/usr/src/app/bin/csslint"]
