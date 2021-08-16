# Base image
FROM ruby:alpine

# Information
LABEL maintainer="FrozenFOXX <frozenfoxx@churchoffoxx.net>"

# Environment variables
ENV APP_HOME=/app \
  BUILD_DEPENDENCIES="build-base ruby-dev" \
  HOST=0.0.0.0 \
  PORT=8080

WORKDIR ${APP_HOME}

# Install build dependencies
RUN apk -U --no-cache --virtual .build-deps \
  add ${BUILD_DEPENDENCIES}

# Install gems
COPY Gemfile* ${APP_HOME}/
RUN bundle install

# Cleanup build dependencies
RUN apk del .build-deps

# Add source
COPY . /app

# Expose port
EXPOSE ${PORT}

ENTRYPOINT [ "./entrypoint.sh" ]