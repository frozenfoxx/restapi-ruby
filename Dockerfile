# Base image
FROM ruby:alpine

# Information
LABEL maintainer="FrozenFOXX <frozenfoxx@churchoffoxx.net>"

# Environment variables
ENV APP_HOME=/app
ENV HOST=0.0.0.0
ENV PORT=80

WORKDIR ${APP_HOME}

# Install gems
COPY Gemfile* ${APP_HOME}/
RUN bundle update --bundler && \
  bundle config set system 'true' && \
  bundle install

# Add source
COPY . /app

# Expose port
EXPOSE ${PORT}

ENTRYPOINT [ "./entrypoint.sh" ]