FROM ruby:3.3.5
RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client
WORKDIR /portfolio
COPY Gemfile /portfolio/Gemfile
COPY Gemfile.lock /portfolio/Gemfile.lock
COPY README.md /portfolio/README.md
RUN bundle install
ADD . /portfolio
CMD ["rails", "server", "-b", "0.0.0.0"]