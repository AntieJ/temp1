FROM ruby:3.0.1

ENV APP_HOME /seedrs-api

RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
    build-essential \
    postgresql-client \
  && apt-get -q clean \
  && rm -rf /var/lib/apt

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install
COPY . .

CMD bundle exec rails s -p 3000