FROM ruby:3.2.1-alpine 
# Create app directory
RUN apk update && \
  apk add --no-cache build-base libpq-dev nodejs postgresql-client yarn
WORKDIR /rails

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
# Install Gems
COPY Gemfile* ./
RUN bundle install --jobs=3 --retry=3
# Install npm packages
COPY package.json yarn.lock ./
COPY . .

# Configure the main process to run when running the image
EXPOSE 3000
CMD ["rails", "s", "-b", "0.0.0.0"]