# --------------------------------
# Base Container
# --------------------------------
FROM ruby:2.5.1-stretch as base

# Install dependencies
RUN apt-get update && apt-get install -y -qq \
        git \
        build-essential \
        g++ \
        libpq-dev \
        qt4-dev-tools \
        libqt4-dev \
        nodejs \
        openssh-server \
        tcptraceroute

# Create our working directory
RUN mkdir -p /var/app

# Set up a working directory
WORKDIR /var/app

# Install rails a layer about bundle as it's slow and we _always_ want it cached
RUN gem install rails -v 5.2.3

# Copy in the gemfile for caching purposes
COPY Gemfile Gemfile.lock ./

# Bundle install
RUN bundle install --without development test


# --------------------------------
# Release Container
# --------------------------------
FROM base as release

# Configure password for SSH
RUN echo "root:Docker!" | chpasswd

COPY . ./

EXPOSE 2222 8080

CMD RAILS_ENV=production bundle exec rails s -p 8080 -b 0.0.0.0


# --------------------------------
# Test Container
# --------------------------------
FROM base as test

COPY . ./

RUN bundle install --with test


# --------------------------------
# Development Container
# --------------------------------
FROM base as dev

EXPOSE 8080

RUN bundle install --with development

CMD bundle exec rails s -p 8080 -b 0.0.0.0
