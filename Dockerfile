FROM ruby:3.3.5
RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client
# RUN mkdir /portfolio #ディレクトリから作る場合
# yarnはあとでインストールするので今はかかない
WORKDIR /portfolio
COPY Gemfile /portfolio/Gemfile
COPY Gemfile.lock /portfolio/Gemfile.lock
RUN bundle install