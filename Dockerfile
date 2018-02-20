FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /smarthealthcar_api
WORKDIR /smarthealthcar_api
COPY Gemfile /smarthealthcar_api/Gemfile
COPY Gemfile.lock /smarthealthcar_api/Gemfile.lock
RUN bundle install
COPY . /smarthealthcar_api
