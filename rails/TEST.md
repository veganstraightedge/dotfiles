# Testing the Rails Template

## What this is

`template.rb` is a Rails application template that sets up a new app with:

- PostgreSQL, Redis, Sidekiq
- Bootstrap (vendored CSS/JS, no build system, auto dark/light mode)
- Roll-your-own auth (has_secure_password, session-based, /signup /signin /signout)
- User, Org, Role, UserRole, Subscription models
- CanCanCan authorization
- Stripe billing (polymorphic subscriptions on User or Org)
- RSpec, FactoryBot, Faker
- RuboCop + 7 plugins, erb_lint, fasterer, mdl, brakeman, overcommit
- Kaminari pagination
- FriendlyId, meta-tags, sitemap_generator, ahoy_matey
- Sentry, rack-attack, rack-contrib, rack-timeout
- kramdown, rubypants, stringex, http, down, image_processing
- Active Storage with S3
- Admin namespace (CRUD for Users/Orgs, site_admin-only)
- Environment banner (green dev, yellow staging, hidden prod)
- Mailers: welcome, email confirmation, password reset, org invite, subscription receipt
- Rake tasks: bootstrap:update, db:export/import (S3)
- Scripts to Rule Them All (script/bootstrap, setup, update, server, test, console, cibuild)
- GitHub Actions CI, dependabot, issue/PR templates
- Procfile (Heroku), .slugignore, .env.example
- Seeds: default roles + site admin user
- Config via config_for: services/app.yml, services/stripe.yml, services/redis.yml

## How to test

```
cd /tmp
rails new testapp
cd testapp
```

`.railsrc` is symlinked to `~/.railsrc`, so no flags needed.

## What to verify

1. `bundle install` succeeded (check Gemfile)
2. Dot files exist (.rubocop.yml, .rspec, .overcommit.yml, etc.)
3. Config files exist (config/services/*.yml, config/storage.yml, initializers)
4. `bin/rails db:create db:migrate db:seed` works
5. `bin/rails server` starts, home page loads with Bootstrap styling
6. Sign up, sign in, sign out work
7. Admin dashboard at `/admin` (requires site_admin role)
8. Environment banner shows green bar in development
9. `bundle exec rspec` runs (even if no specs yet)
10. `bundle exec rubocop` runs
11. `script/*` files are executable
12. `vendor/bootstrap.css` exists (downloaded by rake task)

## Cleanup

```
cd /tmp
rm -rf testapp
```
