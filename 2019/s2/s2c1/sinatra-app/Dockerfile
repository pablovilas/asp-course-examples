FROM ruby:2.6.3

ADD Gemfile /app/Gemfile
ADD app.rb /app/app.rb

WORKDIR /app
RUN bundle install

EXPOSE 4567

CMD ["ruby", "app.rb", "-o", "0.0.0.0"]