FROM ruby:alpine

COPY Gemfile* /tmp/
WORKDIR /tmp
RUN gem install bundler
RUN bundle install

WORKDIR /app
COPY . /app/

EXPOSE 9292

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0"]