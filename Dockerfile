FROM ruby:3.0.0-slim
RUN apt-get update -qq && apt-get install -y imagemagick && apt-get install -y build-essential libpq-dev nodejs libsqlite3-dev cron \
    && apt-get clean autoclean \
    && apt-get autoremove -y
RUN apt remove cmdtest
RUN apt remove yarn
RUN apt-get install curl -y
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install yarn -y    
RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle install 
COPY . /app
RUN chmod u+x bin/rails
CMD bundle exec rails s -p 3000 -b '0.0.0.0'
EXPOSE 3000
