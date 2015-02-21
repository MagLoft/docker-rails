Docker Rails - Docker tools for rails applications
==================================================

**This gem allows you to setup a comprehensive docker/rails environment.**
<https://github.com/magloft/docker-rails>


INSTALLATION
------------

Install the gem for command line usage or inclusion in your ruby/rails project:

    gem install docker-rails

CONFIGURATION
-------------

You need to create a configuration file in config/docker-rails.yml, similar to fig (<http://www.fig.sh/>):

```yaml
db:
  build:
    - 'FROM orchardup/postgresql:latest'
    - 'ENV POSTGRESQL_DB=example'
    - 'ENV POSTGRESQL_USER=example'
    - 'ENV POSTGRESQL_PASS=example'
  image: example/postgres
  ports: ["5432"]
web:
  build:
    - 'FROM ruby:2.2.0'
    - 'RUN apt-get update && apt-get install -qy nodejs postgresql-client sqlite3 --no-install-recommends && rm -rf /var/lib/apt/lists/*'
    - 'ENV RAILS_VERSION 4.1.1'
    - 'RUN gem install rails --version "$RAILS_VERSION"'
    - 'RUN mkdir -p /usr/src/app  '
    - 'WORKDIR /usr/src/app'
    - 'EXPOSE 3000'
    - 'ENV PORT=3000'
    - 'ADD Gemfile /usr/src/app/Gemfile  '
    - 'ADD Gemfile.lock /usr/src/app/Gemfile.lock '
    - 'RUN bundle install --without development test'
    - 'ENV RAILS_ENV=production'
    - 'ENV SECRET_KEY_BASE=mysecret'
    - 'CMD ["foreman","start"]'
    - 'ADD ./ /usr/src/app'
  image: example/rails
  ports: ["3000"]
  links: ["db:db"]
```

USAGE
-----

    docker-rails --help

CHANGELOG
---------

* **0.0.2**
  * Initial release

LICENSE
-------

  _Copyright (C) 2014, Tobias Strebitzer_
  _Licensed under **BSD Opensource License** (free for personal and commercial use)_
