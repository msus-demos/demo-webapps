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

# Configure ports for HTTP and SSH here so they can be overridden outside if needed
ENV PORT 8080
ENV SSH_PORT 2222

# Exporse ports for HTTP and SSH
EXPOSE 8080 2222

# Specify App Service specific variables we may want later
ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance
ENV PATH ${PATH}:/var/app

# Copy in SSH configuration so we can use the App Service SSH Connection Feature
COPY sshd_config /etc/ssh/

# Copy in our release container init script
COPY init_container.sh /bin/

# Make the init script executable.  Always start the container in /var/app
RUN chmod 755 /bin/init_container.sh \
    && echo "cd /var/app" >> /etc/bash.bashrc

# Configure password for root which will be used in SSH
RUN echo "root:Docker!" | chpasswd

# Copy in the application files
COPY . ./

# Set the startup command
CMD /bin/init_container.sh


# --------------------------------
# Test Container
# --------------------------------
FROM base as test

# Copy in the application files
COPY . ./

# Install test dependencies
RUN bundle install --with test

# Set the startup command to run tests
CMD bundle exec rspec


# --------------------------------
# Development Container
# --------------------------------
FROM base as dev

# Expose the http port
EXPOSE 8080

# Install developmemnt dependencies
RUN bundle install --with development

# Set the startup command to run the app
CMD bundle exec rails s -p 8080 -b 0.0.0.0
