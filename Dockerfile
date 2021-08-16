# Base image
FROM ruby:alpine

# Information
LABEL maintainer="FrozenFOXX <frozenfoxx@churchoffoxx.net>"

# Environment variables
ENV BUILD_DEPENDENCIES="build-base ruby-dev" \
  HOST=0.0.0.0 \
  PORT=8080

WORKDIR /usr/src/app

# Throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

# Install build dependencies
RUN apk -U --no-cache --virtual .build-deps \
  add ${BUILD_DEPENDENCIES}

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .

# Cleanup build dependencies
RUN apk del .build-deps

# Expose port
EXPOSE ${PORT}

ENTRYPOINT [ "./entrypoint.sh" ]
