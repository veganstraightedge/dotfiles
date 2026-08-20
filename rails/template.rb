# STATUS: ⚠️🐉
# VERY INCOMPLETE, WORK IN PROGRESS
#
# TODO: manually test this
#       see TEST.md for test plan

# Rails Application Template
#
# Usage:
#   rails new myapp \
#     --database=postgresql \
#     --skip-test \
#     --skip-docker \
#     --skip-kamal \
#     --skip-thruster \
#     --skip-action-cable \
#     --skip-action-text \
#     --skip-devcontainer \
#     --skip-solid \
#     -m path/to/template.rb

# ==============================================================================
# Gems
# ==============================================================================

# Core
gem 'sidekiq'
gem 'redis'
gem 'kaminari'
gem 'cancancan'
gem 'jbuilder'
gem 'image_processing', '~> 1.2'
gem 'aws-sdk-s3', require: false

# Frontend / Content
gem 'kramdown'
gem 'markdown_media'
gem 'rubypants'
gem 'stringex'

# Auth / Billing
gem 'bcrypt', '~> 3.1.7'
gem 'stripe'

# SEO / Meta
gem 'friendly_id', '~> 5.5'
gem 'sitemap_generator'
gem 'meta-tags'

# Analytics
gem 'ahoy_matey'

# Monitoring
gem 'sentry-ruby'
gem 'sentry-rails'

# HTTP
gem 'http'
gem 'down'

# Rack
gem 'rack-attack'
gem 'rack-contrib'
gem 'rack-timeout'

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'

  gem 'rubocop', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-rspec_rails', require: false
  gem 'rubocop-require_tools', require: false

  gem 'erb_lint', require: false
  gem 'fasterer', require: false
  gem 'mdl', require: false
  gem 'overcommit', require: false
  gem 'brakeman', require: false

  gem 'i18n-debug'
end

gem_group :development do
  gem 'web-console'
end

# ==============================================================================
# Dot files
# ==============================================================================

file '.ruby-version', <<~TXT
  4.0.1
TXT

file '.rspec', <<~TXT
  --color
  --require spec_helper
TXT

file '.bootstrap-version', <<~TXT
  5.3.8
TXT

file '.fasterer.yml', <<~YAML
  speedups:
    each_with_index_vs_while: false
    fetch_with_argument_vs_block: false
YAML

file '.gitattributes', <<~TXT
  config/credentials/*.yml.enc diff=rails_credentials
  config/credentials.yml.enc diff=rails_credentials
TXT

file '.yamllint', <<~YAML
  extends: default

  rules:
    colons: disable
    document-start: disable
    line-length: disable

    comments:
      min-spaces-from-content: 1
YAML

file '.rubocop.yml', <<~YAML
  plugins:
    - rubocop-factory_bot
    - rubocop-performance
    - rubocop-rake
    - rubocop-rails
    - rubocop-rspec
    - rubocop-rspec_rails

  AllCops:
    NewCops: enable
    Exclude:
      - db/schema.rb
      - vendor/**/*

  Layout/HashAlignment:
    EnforcedHashRocketStyle: table
    EnforcedColonStyle: table

  Layout/LineLength:
    Exclude:
      - db/**/*

  Style/AsciiComments:
    Enabled: false

  Style/Documentation:
    Enabled: false

  Style/FrozenStringLiteralComment:
    Enabled: false

  Style/MethodDefParentheses:
    EnforcedStyle: require_no_parentheses

  Style/MixinUsage:
    Exclude:
      - script/*
YAML

file '.overcommit.yml', <<~YAML
  PreCommit:
    BundleCheck:
      enabled: true

    HardTabs:
      enabled: true

    LineEndings:
      enabled: true
      exclude:
        - app/assets/fonts/*
        - app/assets/images/*
        - app/assets/images/*/*

        - db/seeds/articles/*
        - public/*
        - public/*/*
        - public/*/*/*
        - public/*/*/*/*

    RailsSchemaUpToDate:
      enabled: true

    RuboCop:
      enabled: true
      on_warn: fail # Treat all warnings as failures

    TrailingWhitespace:
      enabled: true
      exclude:
        - '**/db/structure.sql' # Ignore trailing whitespace in generated files

    YamlSyntax:
      enabled: true

    YamlLint:
      enabled: true

  PostCommit:
    BundleInstall:
      enabled: true

  PostMerge:
    BundleInstall:
      enabled: true

    NextStepsHelper:
      enabled: true
      description: 'Checking for next steps to run after a merge/pull'
YAML

file '.mdlrc', <<~TXT
  # see: https://github.com/markdownlint/markdownlint/blob/main/docs/configuration.md

  git_recurse true
  show_kramdown_warnings true
  style "\#{File.dirname(__FILE__)}/markdownlint.rb"
TXT

file 'markdownlint.rb', <<~RUBY
  # mdl (markdownlint) links
  # gem repo:
  #     https://github.com/markdownlint/markdownlint
  # rules:
  #     https://github.com/markdownlint/markdownlint/blob/main/docs/RULES.md
  # configuration:
  #     https://github.com/markdownlint/markdownlint/blob/main/docs/configuration.md
  #     relevant .mdlrc
  # styles:
  #     https://github.com/markdownlint/markdownlint/blob/main/docs/creating_styles.md
  #     relevant to this file!

  # load all rules
  all

  # skip these rules/tags
  # https://github.com/markdownlint/markdownlint/blob/main/docs/RULES.md

  # allow long lines
  exclude_rule 'MD013'

  # configure these rules (like .rubocop.yml)
  # any rule in with `params` is configurable
  # search here for which rules have `params`:
  # https://github.com/markdownlint/markdownlint/blob/main/lib/mdl/rules.rb

  # ensure that all headings are ATX style
  # ATX headings are 1-6 leading octothorpes, example:
  #     # This is an ATX H1
  #     ## This is an ATX H2
  rule 'MD003', style: :atx

  # ensure that all unordered lists start with a hyphen,
  # not asterisks or pluses
  rule 'MD004', style: :dash

  # indent nested listed with four spaces
  rule 'MD007', indent: 4

  # allow ending heading with question mark
  # default disallowed list is: '.,;:!?'
  rule 'MD026', punctuation: "'.,;:!"

  # ensure that all horizontal lists are hyphen style,
  # not asterisks or hyphens with spaces
  rule 'MD035', style: '---'

  # ensure that all code blocks use backtick fences, not indentation
  # example:
  # ```ruby
  # ...
  # ```
  rule 'MD046', style: :fenced
RUBY

# ==============================================================================
# Environment config
# ==============================================================================

environment 'config.generators.apply_rubocop_autocorrect_after_generate!', env: 'development'

environment 'config.force_ssl = true', env: 'production'

environment "config.time_zone = 'UTC'"

# Load service configs
environment "config.x.app    = config_for 'services/app'"
environment "config.x.stripe = config_for 'services/stripe'"
environment "config.x.redis  = config_for 'services/redis'"

# ==============================================================================
# Config: services/*.yml
# ==============================================================================

file 'config/services/app.yml', <<~YAML
  development:
    on_staging: false
    on_production: false
    static_export_images: <%= ENV.fetch('STATIC_EXPORT_IMAGES', nil).present? %>

  test:
    on_staging: false
    on_production: false
    static_export_images: <%= ENV.fetch('STATIC_EXPORT_IMAGES', nil).present? %>

  production:
    on_staging: <%= ENV.fetch('ON_STAGING', 'FALSE') == 'TRUE' %>
    on_production: <%= ENV.fetch('ON_PRODUCTION', 'FALSE') == 'TRUE' %>
    static_export_images: <%= ENV.fetch('STATIC_EXPORT_IMAGES', nil).present? %>
YAML

file 'config/services/stripe.yml', <<~YAML
  development:
    publishable_key: <%= ENV.fetch('STRIPE_PUBLISHABLE_KEY', nil) %>
    secret_key: <%= ENV.fetch('STRIPE_SECRET_KEY', nil) %>
    webhook_secret: <%= ENV.fetch('STRIPE_WEBHOOK_SIGNING_SECRET', nil) %>

  test:
    publishable_key: <%= ENV.fetch('STRIPE_PUBLISHABLE_KEY', nil) %>
    secret_key: <%= ENV.fetch('STRIPE_SECRET_KEY', nil) %>
    webhook_secret: <%= ENV.fetch('STRIPE_WEBHOOK_SIGNING_SECRET', 'whsec_test') %>

  production:
    publishable_key: <%= ENV.fetch('STRIPE_PUBLISHABLE_KEY', nil) %>
    secret_key: <%= ENV.fetch('STRIPE_SECRET_KEY', nil) %>
    webhook_secret: <%= ENV.fetch('STRIPE_WEBHOOK_SIGNING_SECRET', nil) %>
YAML

file 'config/services/redis.yml', <<~YAML
  development:
    provider: <%= ENV.fetch('REDIS_PROVIDER', 'REDIS_URL') %>
    url: <%= ENV.fetch(ENV.fetch('REDIS_PROVIDER', 'REDIS_URL'), nil) %>

  test:
    provider: <%= ENV.fetch('REDIS_PROVIDER', 'REDIS_URL') %>
    url: <%= ENV.fetch(ENV.fetch('REDIS_PROVIDER', 'REDIS_URL'), nil) %>

  production:
    provider: <%= ENV.fetch('REDIS_PROVIDER', 'REDIS_URL') %>
    url: <%= ENV.fetch(ENV.fetch('REDIS_PROVIDER', 'REDIS_URL'), nil) %>
YAML

# ==============================================================================
# Config: storage.yml
# ==============================================================================

file 'config/storage.yml', <<~YAML, force: true
  local:
    service: Disk
    root:    <%= Rails.root.join 'storage' %>

  test:
    service: Disk
    root:    <%= Rails.root.join 'tmp/storage' %>

  production:
    service:           S3
    access_key_id:     <%= ENV.fetch('S3_ACCESS_KEY') { 'TODO' } %>
    secret_access_key: <%= ENV.fetch('S3_SECRET_KEY') { 'TODO' } %>
    bucket:            <%= ENV.fetch('S3_BUCKET')     { 'TODO' } %>
    region:            <%= ENV.fetch('S3_REGION')     { 'TODO' } %>
    public:            true
YAML

# ==============================================================================
# Initializers
# ==============================================================================

initializer 'kaminari.rb', <<~RUBY
  Kaminari.configure do |config|
    # config.default_per_page = 25
    # config.max_per_page = nil
    config.window = 1
    config.outer_window = 3
    # config.left = 0
    # config.right = 0
    # config.page_method_name = :page
    # config.param_name = :page
    # config.max_pages = nil
    config.params_on_first_page = true # forces /page/1 instead of /
  end
RUBY

initializer 'mime_types.rb', <<~RUBY
  Mime::Type.register 'text/markdown', :markdown
RUBY

initializer 'stripe.rb', <<~RUBY
  Rails.configuration.stripe = {
    publishable_key: Rails.application.config.x.stripe.publishable_key,
    secret_key:      Rails.application.config.x.stripe.secret_key,
    webhook_secret:  Rails.application.config.x.stripe.webhook_secret
  }

  Stripe.api_key     = Rails.configuration.stripe[:secret_key]
  Stripe.api_version = '2026-01-28.clover'
RUBY

initializer 'sidekiq.rb', <<~RUBY
  SIDEKIQ_REDIS_CONFIGURATION = {
    # use REDIS_PROVIDER for Redis environment variable name, defaulting to REDIS_URL
    url:        Rails.application.config.x.redis.url,
    ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
  }.freeze

  Sidekiq.configure_server do |config|
    config.redis = SIDEKIQ_REDIS_CONFIGURATION
  end

  Sidekiq.configure_client do |config|
    config.redis = SIDEKIQ_REDIS_CONFIGURATION
  end
RUBY

initializer 'sentry.rb', <<~RUBY
  Sentry.init do |config|
    config.dsn = ENV.fetch('SENTRY_DSN', nil)
    config.breadcrumbs_logger = [:active_support_logger, :http_logger]
    config.traces_sample_rate = 0.1
    config.enabled_environments = %w[production]
  end
RUBY

initializer 'rack_attack.rb', <<~RUBY
  class Rack::Attack
    # Throttle all requests by IP (60rpm)
    throttle('req/ip', limit: 300, period: 5.minutes) do |req|
      req.ip
    end

    # Throttle login attempts by IP
    throttle('logins/ip', limit: 5, period: 20.seconds) do |req|
      req.ip if req.path == '/signin' && req.post?
    end
  end
RUBY

# ==============================================================================
# Layouts
# ==============================================================================

# TODO: remove this? probably
app_name = app_name # capture the app name for use in heredocs

file 'app/views/layouts/application.html.erb', <<~ERB, force: true
  <!DOCTYPE html>
  <html>
    <head>
      <!-- auto-switch Bootstrap between light and dark mode -->
      <script>
        // set theme to the viewer's preferred color scheme
        function updateTheme() {
          const colorMode = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
          document.querySelector('html').setAttribute('data-bs-theme', colorMode);
        }

        // set theme on load
        updateTheme()

        // update theme when the preferred scheme changes
        window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', updateTheme)
      </script>

      <%= render 'layouts/head' %>
    </head>

    <body>
      <%= render 'layouts/environment_banner' %>
      <%= render 'layouts/nav' %>

      <main class='container py-4'>
        <% if notice.present? %>
          <div class='alert alert-success alert-dismissible fade show' role='alert'>
            <%= notice %>
            <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
          </div>
        <% end %>

        <% if alert.present? %>
          <div class='alert alert-danger alert-dismissible fade show' role='alert'>
            <%= alert %>
            <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
          </div>
        <% end %>

        <%= yield %>
      </main>

      <%= render 'layouts/footer' %>
    </body>
  </html>
ERB

file 'app/views/layouts/admin.html.erb', <<~ERB
  <!DOCTYPE html>
  <html>
    <head>
      <!-- auto-switch Bootstrap between light and dark mode -->
      <script>
        // set theme to the viewer's preferred color scheme
        function updateTheme() {
          const colorMode = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
          document.querySelector('html').setAttribute('data-bs-theme', colorMode);
        }

        // set theme on load
        updateTheme()

        // update theme when the preferred scheme changes
        window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', updateTheme)
      </script>

      <%= render 'layouts/head' %>
    </head>

    <body>
      <%= render 'layouts/environment_banner' %>
      <%= render 'layouts/admin_nav' %>

      <main class='container py-4'>
        <% if notice.present? %>
          <div class='alert alert-success alert-dismissible fade show' role='alert'>
            <%= notice %>
            <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
          </div>
        <% end %>

        <% if alert.present? %>
          <div class='alert alert-danger alert-dismissible fade show' role='alert'>
            <%= alert %>
            <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
          </div>
        <% end %>

        <%= yield %>
      </main>

      <%= render 'layouts/footer' %>
    </body>
  </html>
ERB

file 'app/views/layouts/_head.html.erb', <<~ERB
  <meta charset='utf-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1'>
  <%= display_meta_tags site: "#{app_name.titleize}" %>
  <%= csrf_meta_tags %>
  <%= csp_meta_tag %>

  <%= stylesheet_link_tag 'vendor/bootstrap.css' %>
  <%= stylesheet_link_tag :application %>

  <%= javascript_importmap_tags %>
ERB

file 'app/views/layouts/_nav.html.erb', <<~ERB
  <nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container">
      <%= link_to "#{app_name.titleize}", root_path, class: "navbar-brand" %>

      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto">
          <li class="nav-item">
            <%= link_to "About", about_path, class: "nav-link" %>
          </li>
        </ul>

        <ul class="navbar-nav">
          <% if Current.user %>
            <li class="nav-item">
              <%= link_to "Sign out", signout_path, class: "nav-link" %>
            </li>
          <% else %>
            <li class="nav-item">
              <%= link_to "Sign in", signin_path, class: "nav-link" %>
            </li>
            <li class="nav-item">
              <%= link_to "Sign up", signup_path, class: "nav-link" %>
            </li>
          <% end %>
        </ul>
      </div>
    </div>
  </nav>
ERB

file 'app/views/layouts/_admin_nav.html.erb', <<~ERB
  <nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container">
      <%= link_to "#{app_name.titleize} Admin", admin_root_path, class: "navbar-brand" %>

      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbarNav" aria-controls="adminNavbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="adminNavbarNav">
        <ul class="navbar-nav me-auto">
          <li class="nav-item">
            <%= link_to "Users", admin_users_path, class: "nav-link" %>
          </li>
          <li class="nav-item">
            <%= link_to "Orgs", admin_orgs_path, class: "nav-link" %>
          </li>
        </ul>

        <ul class="navbar-nav">
          <li class="nav-item">
            <%= link_to "Back to site", root_path, class: "nav-link" %>
          </li>
          <li class="nav-item">
            <%= link_to "Sign out", signout_path, class: "nav-link" %>
          </li>
        </ul>
      </div>
    </div>
  </nav>
ERB

file 'app/views/layouts/_environment_banner.html.erb', <<~ERB
  <% unless Rails.env.production? %>
    <%
      banner_colors = {
        "development" => "background-color: #198754;", # green
        "staging"     => "background-color: #ffc107; color: #000;", # yellow
        "test"        => "background-color: #0dcaf0; color: #000;"  # cyan
      }
    %>
    <div style="<%= banner_colors.fetch(Rails.env, 'background-color: #dc3545;') %> text-align: center; padding: 4px; font-size: 12px; font-weight: bold;">
      <%= Rails.env.upcase %>
    </div>
  <% end %>
ERB

file 'app/views/layouts/_footer.html.erb', <<~ERB
  <footer class="container py-4 mt-4 border-top">
    <p class="text-muted text-center">
      &copy; <%= Date.current.year %> #{app_name.titleize}
    </p>
  </footer>
ERB

# ==============================================================================
# Models
# ==============================================================================

file 'app/models/current.rb', <<~RUBY, force: true
  class Current < ActiveSupport::CurrentAttributes
    attribute :user, :role, :locale, :org
  end
RUBY

file 'app/models/user.rb', <<~RUBY, force: true
  class User < ApplicationRecord
    has_secure_password

    has_many :user_roles, dependent: :destroy
    has_many :roles, through: :user_roles
    has_many :orgs, through: :user_roles
    has_many :subscriptions, dependent: :destroy

    store_accessor :settings

    normalizes :email, with: ->(email) { email.strip.downcase }
    normalizes :username, with: ->(username) { username.strip.downcase }

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username, presence: true, uniqueness: true
    validates :display_username, presence: true

    generates_token_for :password_reset, expires_in: 15.minutes do
      password_salt&.last(10)
    end

    generates_token_for :email_confirmation, expires_in: 24.hours do
      email
    end

    def site_admin?
      roles.exists? name: "site_admin"
    end

    def admin_of? org
      user_roles.exists? org: org, role: Role.find_by(name: "admin")
    end

    def owner_of? org
      user_roles.exists? org: org, role: Role.find_by(name: "owner")
    end

    def member_of? org
      orgs.include? org
    end
  end
RUBY

file 'app/models/org.rb', <<~RUBY, force: true
  class Org < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged

    has_many :user_roles, dependent: :destroy
    has_many :users, through: :user_roles
    has_many :subscriptions, dependent: :destroy

    validates :name, presence: true, uniqueness: true
    validates :slug, presence: true, uniqueness: true
  end
RUBY

file 'app/models/role.rb', <<~RUBY, force: true
  class Role < ApplicationRecord
    has_many :user_roles, dependent: :destroy
    has_many :users, through: :user_roles

    validates :name, presence: true, uniqueness: true

    NAMES = %w[user member admin owner site_admin].freeze
  end
RUBY

file 'app/models/user_role.rb', <<~RUBY, force: true
  class UserRole < ApplicationRecord
    belongs_to :user
    belongs_to :role
    belongs_to :org, optional: true

    validates :role_id, uniqueness: { scope: %i[user_id org_id] }
  end
RUBY

file 'app/models/subscription.rb', <<~RUBY, force: true
  class Subscription < ApplicationRecord
    belongs_to :subscribable, polymorphic: true

    validates :stripe_subscription_id, presence: true, uniqueness: true
    validates :status, presence: true

    scope :active, -> { where status: "active" }
  end
RUBY

file 'app/models/ability.rb', <<~RUBY
  class Ability
    include CanCan::Ability

    def initialize user
      user ||= User.new

      # All users (including guests)
      can :read, :all

      return unless user.persisted?

      # Signed-in users
      can :manage, User, id: user.id

      # Org members
      user.orgs.each do |org|
        can :read, Org, id: org.id

        if user.admin_of?(org) || user.owner_of?(org)
          can :manage, Org, id: org.id
        end
      end

      # Site admins
      return unless user.site_admin?

      can :manage, :all
    end
  end
RUBY

# ==============================================================================
# Controllers
# ==============================================================================

file 'app/controllers/application_controller.rb', <<~RUBY, force: true
  class ApplicationController < ActionController::Base
    before_action :set_current_user

    private

    def set_current_user
      Current.user = User.find_by id: session[:user_id] if session[:user_id]
    end

    def require_authentication
      redirect_to signin_path, alert: "Please sign in." unless Current.user
    end

    def require_site_admin
      redirect_to root_path, alert: "Not authorized." unless Current.user&.site_admin?
    end
  end
RUBY

file 'app/controllers/pages_controller.rb', <<~RUBY
  class PagesController < ApplicationController
    def home
    end

    def about
    end

    def terms
    end

    def contact
    end
  end
RUBY

file 'app/controllers/registrations_controller.rb', <<~RUBY
  class RegistrationsController < ApplicationController
    def new
      @user = User.new
    end

    def create
      @user = User.new user_params

      if @user.save
        session[:user_id] = @user.id
        UserMailer.welcome(@user).deliver_later
        UserMailer.email_confirmation(@user).deliver_later
        redirect_to root_path, notice: "Welcome! You have signed up successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :username, :display_username, :password, :password_confirmation)
    end
  end
RUBY

file 'app/controllers/sessions_controller.rb', <<~RUBY
  class SessionsController < ApplicationController
    def new
    end

    def create
      user = User.authenticate_by email: params[:email], password: params[:password]

      if user
        session[:user_id] = user.id
        redirect_to root_path, notice: "Signed in successfully."
      else
        flash.now[:alert] = "Invalid email or password."
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      session.delete :user_id
      Current.user = nil
      redirect_to root_path, notice: "Signed out successfully."
    end
  end
RUBY

file 'app/controllers/passwords_controller.rb', <<~RUBY
  class PasswordsController < ApplicationController
    before_action :require_authentication, only: %i[edit update]

    def new
    end

    def create
      user = User.find_by email: params[:email]
      UserMailer.password_reset(user).deliver_later if user
      redirect_to signin_path, notice: "If that email exists, we sent password reset instructions."
    end

    def edit
      @user = User.find_by_token_for :password_reset, params[:token]
      redirect_to signin_path, alert: "Invalid or expired token." unless @user
    end

    def update
      @user = User.find_by_token_for :password_reset, params[:token]

      if @user&.update password_params
        redirect_to signin_path, notice: "Password has been reset. Please sign in."
      else
        redirect_to signin_path, alert: "Invalid or expired token."
      end
    end

    private

    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  end
RUBY

file 'app/controllers/email_confirmations_controller.rb', <<~RUBY
  class EmailConfirmationsController < ApplicationController
    def show
      user = User.find_by_token_for :email_confirmation, params[:token]

      if user
        user.update! email_confirmed_at: Time.current
        redirect_to root_path, notice: "Email confirmed successfully."
      else
        redirect_to root_path, alert: "Invalid or expired confirmation link."
      end
    end
  end
RUBY

file 'app/controllers/admin/base_controller.rb', <<~RUBY
  module Admin
    class BaseController < ApplicationController
      before_action :require_authentication
      before_action :require_site_admin

      layout "admin"
    end
  end
RUBY

file 'app/controllers/admin/dashboard_controller.rb', <<~RUBY
  module Admin
    class DashboardController < BaseController
      def index
      end
    end
  end
RUBY

file 'app/controllers/admin/users_controller.rb', <<~RUBY
  module Admin
    class UsersController < BaseController
      before_action :set_user, only: %i[show edit update destroy]

      def index
        @users = User.page(params[:page])
      end

      def show
      end

      def edit
      end

      def update
        if @user.update user_params
          redirect_to admin_user_path(@user), notice: "User updated."
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
        redirect_to admin_users_path, notice: "User deleted."
      end

      private

      def set_user
        @user = User.find params[:id]
      end

      def user_params
        params.require(:user).permit(:name, :email, :username, :display_username)
      end
    end
  end
RUBY

file 'app/controllers/admin/orgs_controller.rb', <<~RUBY
  module Admin
    class OrgsController < BaseController
      before_action :set_org, only: %i[show edit update destroy]

      def index
        @orgs = Org.page(params[:page])
      end

      def show
      end

      def edit
      end

      def update
        if @org.update org_params
          redirect_to admin_org_path(@org), notice: "Org updated."
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @org.destroy
        redirect_to admin_orgs_path, notice: "Org deleted."
      end

      private

      def set_org
        @org = Org.friendly.find params[:id]
      end

      def org_params
        params.require(:org).permit(:name)
      end
    end
  end
RUBY

# ==============================================================================
# Routes
# ==============================================================================

file 'config/routes.rb', <<~RUBY, force: true
  require "sidekiq/web"

  Rails.application.routes.draw do
    # Homepage
    root 'pages#home'

    # Auth
    get  'signup',  to: 'registrations#new'
    post 'signup',  to: 'registrations#create'
    get  'signin',  to: 'sessions#new'
    post 'signin',  to: 'sessions#create'
    get  'signout', to: 'sessions#destroy'

    # Password reset
    resources :passwords, only: %i[new create edit update], param: :token

    # Email confirmation
    get 'email_confirmation/:token', to: 'email_confirmations#show', as: :email_confirmation

    # Pages
    get 'about',   to: 'pages#about'
    get 'terms',   to: 'pages#terms'
    get 'contact', to: 'pages#contact'

    # Admin
    namespace :admin do
      root 'dashboard#index'

      resources :users, except: %i[new create]
      resources :orgs
    end

    # Sidekiq (site admins only)
    Sidekiq::Web.use Rack::Auth::Basic do |_username, password|
      ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(password),
        ::Digest::SHA256.hexdigest(ENV.fetch('SIDEKIQ_WEB_PASSWORD', 'password'))
      )
    end

    mount Sidekiq::Web => '/sidekiq'

    # Health check
    get 'up', to: 'rails/health#show', as: :rails_health_check
  end
RUBY

# ==============================================================================
# Mailers
# ==============================================================================

file 'app/mailers/application_mailer.rb', <<~RUBY, force: true
  class ApplicationMailer < ActionMailer::Base
    default from: 'noreply@example.com'
    layout 'mailer'
  end
RUBY

file 'app/mailers/user_mailer.rb', <<~RUBY
  class UserMailer < ApplicationMailer
    def welcome user
      @user = user
      mail to: @user.email, subject: 'Welcome!'
    end

    def email_confirmation user
      @user = user
      @token = user.generate_token_for :email_confirmation
      mail to: @user.email, subject: 'Confirm your email'
    end

    def password_reset user
      @user = user
      @token = user.generate_token_for :password_reset
      mail to: @user.email, subject: 'Reset your password'
    end
  end
RUBY

file 'app/mailers/org_mailer.rb', <<~RUBY
  class OrgMailer < ApplicationMailer
    def invitation org, email, invited_by
      @org = org
      @invited_by = invited_by
      mail to: email, subject: "You’ve been invited to join \#{@org.name}"
    end

    def subscription_receipt org, subscription
      @org = org
      @subscription = subscription
      owner = org.user_roles.joins(:role).where(roles: { name: 'owner' }).first&.user
      mail to: owner&.email, subject: "Subscription receipt for \#{@org.name}" if owner
    end
  end
RUBY

file 'app/views/user_mailer/welcome.html.erb', <<~ERB
  <h1>Welcome, <%= @user.name %>!</h1>
  <p>Thanks for signing up.</p>
ERB

file 'app/views/user_mailer/email_confirmation.html.erb', <<~ERB
  <h1>Confirm your email</h1>
  <p>Click the link below to confirm your email address:</p>
  <p><%= link_to "Confirm email", email_confirmation_url(token: @token) %></p>
ERB

file 'app/views/user_mailer/password_reset.html.erb', <<~ERB
  <h1>Reset your password</h1>
  <p>Click the link below to reset your password:</p>
  <p><%= link_to 'Reset password', edit_password_url(token: @token) %></p>
  <p>This link expires in 15 minutes.</p>
ERB

file 'app/views/org_mailer/invitation.html.erb', <<~ERB
  <h1>You’ve been invited!</h1>
  <p><%= @invited_by.name %> has invited you to join <%= @org.name %>.</p>
  <p><%= link_to 'Accept invitation', signup_url %></p>
ERB

file 'app/views/org_mailer/subscription_receipt.html.erb', <<~ERB
  <h1>Subscription receipt</h1>
  <p>This confirms the subscription for <%= @org.name %>.</p>
ERB

# ==============================================================================
# Migrations (using generate so timestamps are sequential)
# ==============================================================================

generate :migration,
         'CreateUsers',
         'name:string',
         'email:string:uniq',
         'username:string:uniq',
         'display_username:string',
         'password_digest:string',
         'email_confirmed_at:datetime',
         'settings:jsonb'

generate :migration,
         'CreateOrgs',
         'name:string:uniq',
         'slug:string:uniq'

generate :migration,
         'CreateRoles',
         'name:string:uniq'

generate :migration,
         'CreateUserRoles',
         'user:references',
         'role:references',
         'org:references'

generate :migration,
         'CreateSubscriptions',
         'subscribable:references{polymorphic}',
         'stripe_subscription_id:string:uniq',
         'stripe_customer_id:string',
         'plan_name:string',
         'status:string',
         'current_period_start:datetime',
         'current_period_end:datetime'

generate :migration,
         'CreateFriendlyIDSlugs',
         'sluggable:references{polymorphic}',
         'slug:string:uniq',
         'scope:string'

# ==============================================================================
# Rake tasks
# ==============================================================================

rakefile 'bootstrap.rake', <<~RUBY
    namespace :bootstrap do
      desc 'Check for Bootstrap updates and download if newer version available'
      task update: :environment do
        require 'down'
        require 'json'

        version_file = Rails.root.join '.bootstrap-version'
        current_version = version_file.exist? ? version_file.read.strip : '0.0.0'

        print 'Checking for Bootstrap updates... '

        response       = HTTP.get 'https://api.github.com/repos/twbs/bootstrap/releases/latest'
        latest         = JSON.parse response.body.to_s
        latest_version = latest['tag_name'].delete_prefix 'v'

        if Gem::Version.new(latest_version) > Gem::Version.new(current_version)
          puts "updating from \#{current_version} to \#{latest_version}"

          css_url     = "https://cdn.jsdelivr.net/npm/bootstrap@\#{latest_version}/dist/css/bootstrap.css"
          css_map_url = "https://cdn.jsdelivr.net/npm/bootstrap@\#{latest_version}/dist/css/bootstrap.css.map"
          js_url      = "https://cdn.jsdelivr.net/npm/bootstrap@\#{latest_version}/dist/js/bootstrap.bundle.js"
          js_map_url  = "https://cdn.jsdelivr.net/npm/bootstrap@\#{latest_version}/dist/js/bootstrap.bundle.js.map"
  "
          css_dir = Rails.root.join 'vendor'
          js_dir  = Rails.root.join 'vendor'

          FileUtils.mkdir_p css_dir
          FileUtils.mkdir_p js_dir

          Down.download css_url,     destination: css_dir.join('bootstrap.css').to_s
          Down.download css_map_url, destination: css_dir.join('bootstrap.css.map').to_s
          Down.download js_url,      destination: js_dir.join('bootstrap.bundle.js').to_s
          Down.download js_map_url,  destination: js_dir.join('bootstrap.bundle.js.map').to_s

          version_file.write latest_version
          puts "Bootstrap \#{latest_version} downloaded to vendor/bootstrap.*"
        else
          puts "already at latest (\#{current_version})"
        end
      end
    end
RUBY

rakefile 'db_export.rake', <<~RUBY
  namespace :db do
    namespace :export do
      desc 'Dump local development DB'
      task dump: :environment do
        config = ActiveRecord::Base.connection_db_config.configuration_hash
        db_name = config[:database]
        dump_file = Rails.root.join("tmp/\#{db_name}.dump")

        sh "pg_dump -Fc --no-owner \#{db_name} > \#{dump_file}"
        puts "Dumped to \#{dump_file}"
      end

      desc 'Pull production DB'
      task pull: :environment do
        app_name = Rails.application.class.module_parent_name.underscore.dasherize
        dump_file = Rails.root.join 'tmp/production.dump'

        sh "heroku pg:backups:capture --app \#{app_name}"
        sh "heroku pg:backups:download --app \#{app_name} --output \#{dump_file}"
        puts "Downloaded to \#{dump_file}"
      end

      desc 'Scrub private production data from DB'
      task scrub: :environment do
        puts 'Scrubbing private data...'

        User.find_each do |user|
          user.update_columns email:            "user\#{user.id}@example.com",
                              name:             "User \#{user.id}",
                              username:         "user\#{user.id}",
                              display_username: "User\#{user.id}"
        end

        puts 'Done scrubbing.'
      end

      desc 'Upload DB dump to S3'
      task upload: :environment do
        dump_file = Rails.root.join('tmp/production.dump')
        abort "No dump file found at \#{dump_file}" unless File.exist?(dump_file)

        bucket = ENV.fetch 'S3_BUCKET'
        key = "db-dumps/\#{Date.current.iso8601}-production.dump"

        s3 = Aws::S3::Client.new
        File.open(dump_file, 'rb') do |file|
          s3.put_object bucket: bucket, key: key, body: file
        end
        puts "Uploaded to s3://\#{bucket}/\#{key}"
      end
    end

    desc 'Export (scrubbed) production DB to S3'
    task export: :environment do
      Rake::Task["db:export:pull"].invoke
      Rake::Task["db:export:scrub"].invoke
      Rake::Task["db:export:dump"].invoke
      Rake::Task["db:export:upload"].invoke
    end
  end
RUBY

rakefile 'db_import.rake', <<~RUBY
  namespace :db do
    namespace :import do
      desc 'Download DB dump from S3'
      task download: :environment do
        bucket = ENV.fetch 'S3_BUCKET'

        s3 = Aws::S3::Client.new
        objects = s3.list_objects_v2(bucket: bucket, prefix: 'db-dumps/'').contents
        latest = objects.sort_by(&:last_modified).last
        abort "No dumps found in s3://\#{bucket}/db-dumps/" unless latest

        dump_file = Rails.root.join 'tmp/production.dump'
        s3.get_object bucket: bucket, key: latest.key, response_target: dump_file.to_s
        puts "Downloaded \#{latest.key} to \#{dump_file}"
      end

      desc 'Import pg dump into local development DB'
      task populate: :environment do
        config = ActiveRecord::Base.connection_db_config.configuration_hash
        db_name = config[:database]
        dump_file = Rails.root.join 'tmp/production.dump'
        abort "No dump file found at \#{dump_file}" unless File.exist?(dump_file)

        Rake::Task['db:drop'].invoke
        Rake::Task['db:create'].invoke
        sh "pg_restore --no-owner -d \#{db_name} \#{dump_file}"
        Rake::Task['db:migrate'].invoke
        puts "Imported \#{dump_file} into \#{db_name}"
      end
    end

    desc 'Import (scrubbed) production DB from S3'
    task import: :environment do
      Rake::Task['db:import:download'].invoke
      Rake::Task['db:import:populate'].invoke
    end
  end
RUBY

# ==============================================================================
# Scripts to Rule Them All
# ==============================================================================

file 'script/bootstrap', <<~BASH, force: true
  #!/bin/bash

  # script/bootstrap: Resolve all dependencies that the application requires to run.

  set -e

  cd "$(dirname "$0")/.."

  echo "==> Installing Ruby dependencies..."
  bundle install

  echo "==> Installing overcommit hooks..."
  bundle exec overcommit --install

  echo "==> Downloading Bootstrap..."
  bundle exec rake bootstrap:update

  echo "==> Done!"
BASH

file 'script/setup', <<~RUBY
  #!/usr/bin/env ruby

  # script/setup: Set up the application for the first time after cloning,
  #               or set it back to the initial first unused state.

  require "fileutils"

  def system! *args
    system(*args, exception: true)
  end

  FileUtils.chdir File.expand_path("..", __dir__) do
    puts "==> Running bootstrap..."
    system! "script/bootstrap"

    puts "\\n==> Preparing database..."
    system! "bin/rails db:prepare"

    puts "\\n==> Seeding database..."
    system! "bin/rails db:seed"

    puts "\\n==> Removing old logs and tempfiles..."
    system! "bin/rails log:clear tmp:clear"

    puts "\\n==> Done! Run script/server to start the app."
  end
RUBY

file 'script/update', <<~RUBY
  #!/usr/bin/env ruby

  # script/update: Update application to run for its current checkout.

  require "fileutils"

  def system! *args
    system(*args, exception: true)
  end

  FileUtils.chdir File.expand_path("..", __dir__) do
    puts "==> Installing dependencies..."
    system! "bundle install"

    puts "\\n==> Updating Bootstrap..."
    system! "bundle exec rake bootstrap:update"

    puts "\\n==> Running database migrations..."
    system! "bin/rails db:migrate"

    puts "\\n==> Done!"
  end
RUBY

file 'script/server', <<~RUBY
  #!/usr/bin/env ruby

  # script/server: Launch the application and any extra required processes
  #                locally.

  require "fileutils"

  def system! *args
    system(*args, exception: true)
  end

  FileUtils.chdir File.expand_path("..", __dir__) do
    puts "==> Starting Rails server..."
    system! "bin/rails server"
  end
RUBY

file 'script/test', <<~RUBY
  #!/usr/bin/env ruby

  # script/test: Run the test suite for the application.

  require "fileutils"

  def system! *args
    system(*args, exception: true)
  end

  FileUtils.chdir File.expand_path("..", __dir__) do
    puts "==> Running tests..."
    system! "bundle exec rspec"
  end
RUBY

file 'script/console', <<~RUBY
  #!/usr/bin/env ruby

  # script/console: Launch a console for the application.

  require "fileutils"

  def system! *args
    system(*args, exception: true)
  end

  FileUtils.chdir File.expand_path("..", __dir__) do
    system! "bin/rails console"
  end
RUBY

file 'script/cibuild', <<~RUBY
  #!/usr/bin/env ruby

  # script/cibuild: Setup environment for CI to run tests. This is primarily
  #                 designed to run on the continuous integration server.

  require "fileutils"

  def system! *args
    system(*args, exception: true)
  end

  FileUtils.chdir File.expand_path("..", __dir__) do
    puts "==> Preparing database..."
    system! "bin/rails db:prepare"

    puts "\\n==> Running linters..."
    system! "bundle exec rubocop"
    system! "bundle exec erblint --lint-all"
    system! "bundle exec brakeman --no-pager"
    system! "bundle exec fasterer"
    system! "mdl ."

    puts "\\n==> Running tests..."
    system! "bundle exec rspec"
  end
RUBY

run 'chmod +x script/*'

# ==============================================================================
# GitHub files
# ==============================================================================

file '.github/dependabot.yml', <<~YAML
  version: 2
  updates:
    - package-ecosystem: "bundler"
      directory: "/"
      schedule:
        interval: "weekly"
      open-pull-requests-limit: 10

    - package-ecosystem: "github-actions"
      directory: "/"
      schedule:
        interval: "weekly"
YAML

file '.github/workflows/ci.yml', <<~YAML
  name: CI

  on:
    push:
      branches: [main]
    pull_request:
      branches: [main]

  jobs:
    lint:
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v4
        - uses: ruby/setup-ruby@v1
          with:
            bundler-cache: true
        - run: bundle exec rubocop
        - run: bundle exec erblint --lint-all
        - run: bundle exec brakeman --no-pager
        - run: bundle exec fasterer
        - run: gem install mdl && mdl .

    test:
      runs-on: ubuntu-latest
      services:
        postgres:
          image: postgres:16
          env:
            POSTGRES_USER: postgres
            POSTGRES_PASSWORD: postgres
          ports:
            - 5432:5432
          options: >-
            --health-cmd pg_isready
            --health-interval 10s
            --health-timeout 5s
            --health-retries 5
        redis:
          image: redis:7
          ports:
            - 6379:6379
          options: >-
            --health-cmd "redis-cli ping"
            --health-interval 10s
            --health-timeout 5s
            --health-retries 5
      env:
        RAILS_ENV: test
        DATABASE_URL: postgres://postgres:postgres@localhost:5432/test
        REDIS_URL: redis://localhost:6379/0
      steps:
        - uses: actions/checkout@v4
        - uses: ruby/setup-ruby@v1
          with:
            bundler-cache: true
        - run: bin/rails db:prepare
        - run: bundle exec rspec
YAML

file '.github/ISSUE_TEMPLATE/bug_report.md', <<~MD
  ---
  name: Bug report
  about: Create a report to help us improve
  ---

  ## Description

  A clear and concise description of the bug.

  ## Steps to reproduce

  1.
  2.
  3.

  ## Expected behavior

  What you expected to happen.

  ## Actual behavior

  What actually happened.

  ## Environment

  - Ruby version:
  - Rails version:
  - OS:
MD

file '.github/ISSUE_TEMPLATE/feature_request.md', <<~MD
  ---
  name: Feature request
  about: Suggest an idea for this project
  ---

  ## Problem

  A clear description of the problem this feature would solve.

  ## Proposed solution

  A clear description of what you'd like to happen.

  ## Alternatives considered

  Any alternative solutions or features you've considered.
MD

file '.github/PULL_REQUEST_TEMPLATE.md', <<~MD
  ## What

  A brief description of the changes.

  ## Why

  Why these changes are needed.

  ## How

  How the changes were implemented.

  ## Testing

  How the changes were tested.
MD

# ==============================================================================
# Heroku / Deploy files
# ==============================================================================

file 'Procfile', <<~TXT, force: true
  release: bundle exec rake db:migrate
  web: bundle exec puma -C config/puma.rb
  worker: RAILS_MAX_THREADS=${RAILS_MAX_THREADS} bundle exec sidekiq -q default -q mailers -q active_storage_analysis -q active_storage_purge
TXT

file '.slugignore', <<~TXT
  .byebug_history
  .codeclimate
  .gitignore
  .rspec
  .rubocop.yml
  .travis.yml
  Brewfile
  CODE_OF_CONDUCT.md
  CONTRIBUTING.md
  Dockerfile
  issues.md
  LICENSE.md
  README.md
  coverage/*
  docs/*
  script/*
  spec/*
TXT

file '.env.example', <<~TXT
  # PostgreSQL
  DATABASE_URL=postgres://localhost:5432/#{app_name}_development

  # Redis
  REDIS_PROVIDER=REDIS_URL
  REDIS_URL=redis://localhost:6379/0

  # Stripe
  STRIPE_PUBLISHABLE_KEY=
  STRIPE_SECRET_KEY=
  STRIPE_WEBHOOK_SIGNING_SECRET=

  # S3
  S3_ACCESS_KEY=TODO
  S3_SECRET_KEY=TODO
  S3_BUCKET=TODO
  S3_REGION=TODO

  # Sentry
  SENTRY_DSN=TODO

  # Sidekiq
  SIDEKIQ_WEB_PASSWORD=TODO

  # App
  ON_STAGING=FALSE
  ON_PRODUCTION=FALSE
TXT

# Add .env to .gitignore
append_to_file '.gitignore', <<~TXT

  # Environment variables
  .env
TXT

# ==============================================================================
# RSpec setup
# ==============================================================================

file 'spec/spec_helper.rb', <<~RUBY
  RSpec.configure do |config|
    config.expect_with :rspec do |expectations|
      expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    end

    config.mock_with :rspec do |mocks|
      mocks.verify_partial_doubles = true
    end

    config.shared_context_metadata_behavior = :apply_to_host_groups
    config.filter_run_when_matching :focus
    config.example_status_persistence_file_path = 'spec/examples.txt'
    config.disable_monkey_patching!
    config.order = :random
    Kernel.srand config.seed
  end
RUBY

file 'spec/rails_helper.rb', <<~RUBY
  require "spec_helper"
  ENV["RAILS_ENV"] ||= "test"
  require_relative "../config/environment"

  abort("The Rails environment is running in production mode!") if Rails.env.production?

  require "rspec/rails"

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  begin
    ActiveRecord::Migration.maintain_test_schema!
  rescue ActiveRecord::PendingMigrationError => e
    abort e.to_s.strip
  end

  RSpec.configure do |config|
    config.fixture_paths = [Rails.root.join("spec/fixtures")]
    config.use_transactional_fixtures = true
    config.infer_spec_type_from_file_location!
    config.filter_rails_from_backtrace!

    config.include FactoryBot::Syntax::Methods
  end
RUBY

file 'spec/support/.keep', ''

file 'spec/factories/users.rb', <<~RUBY
  FactoryBot.define do
    factory :user do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      username { Faker::Internet.username(specifier: 5..20, separators: %w[_]) }
      display_username { username }
      password { "password123" }
      password_confirmation { "password123" }
    end
  end
RUBY

file 'spec/factories/orgs.rb', <<~RUBY
  FactoryBot.define do
    factory :org do
      name { Faker::Company.name }
    end
  end
RUBY

file 'spec/factories/roles.rb', <<~RUBY
  FactoryBot.define do
    factory :role do
      name { "user" }

      trait :member do
        name { "member" }
      end

      trait :admin do
        name { "admin" }
      end

      trait :owner do
        name { "owner" }
      end

      trait :site_admin do
        name { "site_admin" }
      end
    end
  end
RUBY

# ==============================================================================
# Seeds
# ==============================================================================

file 'db/seeds.rb', <<~RUBY, force: true
  puts "Seeding roles..."
  Role::NAMES.each do |name|
    Role.find_or_create_by! name: name
    puts "  - \#{name}"
  end

  puts "Seeding site admin..."
  admin = User.find_or_create_by!(email: "admin@example.com") do |user|
    user.name             = "Site Admin"
    user.username         = "admin"
    user.display_username = "Admin"
    user.password         = "password123"
    user.password_confirmation = "password123"
    user.email_confirmed_at = Time.current
  end

  site_admin_role = Role.find_by!(name: "site_admin")
  user_role = Role.find_by!(name: "user")
  UserRole.find_or_create_by!(user: admin, role: site_admin_role)
  UserRole.find_or_create_by!(user: admin, role: user_role)
  puts "  - \#{admin.email}"

  puts "Done!"
RUBY

# ==============================================================================
# Bootstrap vendored files (initial download)
# ==============================================================================

file 'public/bootstrap/css/.keep', ''
file 'public/bootstrap/js/.keep', ''

# Add Bootstrap JS to head partial
file 'app/views/layouts/_head.html.erb', <<~ERB, force: true
  <meta charset='utf-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1'>

  <%= display_meta_tags site: "#{app_name.titleize}" %>
  <%= csrf_meta_tags %>
  <%= csp_meta_tag %>

  <%= stylesheet_link_tag 'vendor/bootstrap.css' %>
  <%= stylesheet_link_tag :application %>

  <script src="/bootstrap/js/bootstrap.bundle.min.js"></script>
  <%= javascript_importmap_tags %>
ERB

# ==============================================================================
# View stubs (pages, auth, admin)
# ==============================================================================

# Pages
file 'app/views/pages/home.html.erb', <<~ERB
  <h1>Welcome</h1>
ERB

file 'app/views/pages/about.html.erb', <<~ERB
  <h1>About</h1>
ERB

file 'app/views/pages/terms.html.erb', <<~ERB
  <h1>Terms of Service</h1>
ERB

file 'app/views/pages/contact.html.erb', <<~ERB
  <h1>Contact</h1>
ERB

# Auth
file 'app/views/registrations/new.html.erb', <<~ERB
  <h1>Sign up</h1>

  <%= form_with model: @user, url: :signup do |f| %>
    <% if @user.errors.any? %>
      <div class='alert alert-danger'>
        <ul class='mb-0'>
          <% @user.errors.full_messages.each do |message| %>
            <li><%= message %></li>
          <% end %>
        </ul>
      </div>
    <% end %>

    <div class='mb-3'>
      <%= f.label :name, class: 'form-label' %>
      <%= f.text_field :name, class: 'form-control' %>
    </div>

    <div class='mb-3'>
      <%= f.label :email, class: 'form-label' %>
      <%= f.email_field :email, class: 'form-control' %>
    </div>

    <div class='mb-3'>
      <%= f.label :username, class: 'form-label' %>
      <%= f.text_field :username, class: 'form-control' %>
    </div>

    <div class='mb-3'>
      <%= f.label :display_username, class: 'form-label' %>
      <%= f.text_field :display_username, class: 'form-control' %>
    </div>

    <div class='mb-3'>
      <%= f.label :password, class: 'form-label' %>
      <%= f.password_field :password, class: 'form-control' %>
    </div>

    <div class='mb-3'>
      <%= f.label :password_confirmation, class: 'form-label' %>
      <%= f.password_field :password_confirmation, class: 'form-control' %>
    </div>

    <%= f.submit 'Sign up', class: 'btn btn-primary' %>
  <% end %>

  <p class='mt-3'>Already have an account? <%= link_to 'Sign in', :signin %></p>
ERB

file 'app/views/sessions/new.html.erb', <<~ERB
  <h1>Sign in</h1>

  <%= form_with url: :signin do |f| %>
    <div class='mb-3'>
      <%= f.label :email, class: 'form-label' %>
      <%= f.email_field :email, class: 'form-control' %>
    </div>

    <div class='mb-3'>
      <%= f.label :password, class: 'form-label' %>
      <%= f.password_field :password, class: 'form-control' %>
    </div>

    <%= f.submit 'Sign in', class: 'btn btn-primary' %>
  <% end %>

  <p class='mt-3'><%= link_to 'Forgot password?', new_password_path %></p>
  <p>Don't have an account? <%= link_to 'Sign up', :signup %></p>
ERB

file 'app/views/passwords/new.html.erb', <<~ERB
  <h1>Forgot your password?</h1>

  <%= form_with url: passwords_path do |f| %>
    <div class="mb-3">
      <%= f.label :email, class: "form-label" %>
      <%= f.email_field :email, class: "form-control" %>
    </div>

    <%= f.submit "Send reset instructions", class: "btn btn-primary" %>
  <% end %>
ERB

file 'app/views/passwords/edit.html.erb', <<~ERB
  <h1>Reset your password</h1>

  <%= form_with url: password_path(token: params[:token]), method: :patch do |f| %>
    <div class="mb-3">
      <%= f.label :password, "New password", class: "form-label" %>
      <%= f.password_field :password, class: "form-control", name: "user[password]" %>
    </div>

    <div class="mb-3">
      <%= f.label :password_confirmation, class: "form-label" %>
      <%= f.password_field :password_confirmation, class: "form-control", name: "user[password_confirmation]" %>
    </div>

    <%= f.submit "Reset password", class: "btn btn-primary" %>
  <% end %>
ERB

# Admin
file 'app/views/admin/dashboard/index.html.erb', <<~ERB
  <h1>Admin Dashboard</h1>

  <div class="row">
    <div class="col-md-4">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title">Users</h5>
          <p class="card-text"><%= User.count %></p>
          <%= link_to "Manage", admin_users_path, class: "btn btn-primary" %>
        </div>
      </div>
    </div>

    <div class="col-md-4">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title">Orgs</h5>
          <p class="card-text"><%= Org.count %></p>
          <%= link_to "Manage", admin_orgs_path, class: "btn btn-primary" %>
        </div>
      </div>
    </div>
  </div>
ERB

file 'app/views/admin/users/index.html.erb', <<~ERB
  <h1>Users</h1>

  <table class="table">
    <thead>
      <tr>
        <th>Name</th>
        <th>Email</th>
        <th>Username</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <% @users.each do |user| %>
        <tr>
          <td><%= user.name %></td>
          <td><%= user.email %></td>
          <td><%= user.username %></td>
          <td><%= link_to "View", admin_user_path(user) %></td>
        </tr>
      <% end %>
    </tbody>
  </table>

  <%= paginate @users %>
ERB

file 'app/views/admin/users/show.html.erb', <<~ERB
  <h1><%= @user.name %></h1>

  <dl>
    <dt>Email</dt>
    <dd><%= @user.email %></dd>
    <dt>Username</dt>
    <dd><%= @user.username %></dd>
    <dt>Display Username</dt>
    <dd><%= @user.display_username %></dd>
  </dl>

  <%= link_to "Edit", edit_admin_user_path(@user), class: "btn btn-primary" %>
  <%= link_to "Back", admin_users_path, class: "btn btn-secondary" %>
ERB

file 'app/views/admin/users/edit.html.erb', <<~ERB
  <h1>Edit User</h1>

  <%= form_with model: @user, url: admin_user_path(@user) do |f| %>
    <div class="mb-3">
      <%= f.label :name, class: "form-label" %>
      <%= f.text_field :name, class: "form-control" %>
    </div>

    <div class="mb-3">
      <%= f.label :email, class: "form-label" %>
      <%= f.email_field :email, class: "form-control" %>
    </div>

    <div class="mb-3">
      <%= f.label :username, class: "form-label" %>
      <%= f.text_field :username, class: "form-control" %>
    </div>

    <div class="mb-3">
      <%= f.label :display_username, class: "form-label" %>
      <%= f.text_field :display_username, class: "form-control" %>
    </div>

    <%= f.submit "Update", class: "btn btn-primary" %>
  <% end %>

  <%= link_to "Back", admin_user_path(@user), class: "btn btn-secondary" %>
ERB

file 'app/views/admin/orgs/index.html.erb', <<~ERB
  <h1>Orgs</h1>

  <%= link_to "New Org", new_admin_org_path, class: "btn btn-primary mb-3" %>

  <table class="table">
    <thead>
      <tr>
        <th>Name</th>
        <th>Slug</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <% @orgs.each do |org| %>
        <tr>
          <td><%= org.name %></td>
          <td><%= org.slug %></td>
          <td><%= link_to "View", admin_org_path(org) %></td>
        </tr>
      <% end %>
    </tbody>
  </table>

  <%= paginate @orgs %>
ERB

file 'app/views/admin/orgs/show.html.erb', <<~ERB
  <h1><%= @org.name %></h1>

  <dl>
    <dt>Slug</dt>
    <dd><%= @org.slug %></dd>
    <dt>Users</dt>
    <dd><%= @org.users.count %></dd>
  </dl>

  <%= link_to "Edit", edit_admin_org_path(@org), class: "btn btn-primary" %>
  <%= link_to "Back", admin_orgs_path, class: "btn btn-secondary" %>
ERB

file 'app/views/admin/orgs/edit.html.erb', <<~ERB
  <h1>Edit Org</h1>

  <%= form_with model: @org, url: admin_org_path(@org) do |f| %>
    <div class="mb-3">
      <%= f.label :name, class: "form-label" %>
      <%= f.text_field :name, class: "form-control" %>
    </div>

    <%= f.submit "Update", class: "btn btn-primary" %>
  <% end %>

  <%= link_to "Back", admin_org_path(@org), class: "btn btn-secondary" %>
ERB

file 'app/views/admin/orgs/new.html.erb', <<~ERB
  <h1>New Org</h1>

  <%= form_with model: [:admin, @org || Org.new] do |f| %>
    <div class="mb-3">
      <%= f.label :name, class: "form-label" %>
      <%= f.text_field :name, class: "form-control" %>
    </div>

    <%= f.submit "Create", class: "btn btn-primary" %>
  <% end %>

  <%= link_to "Back", admin_orgs_path, class: "btn btn-secondary" %>
ERB

# ==============================================================================
# CONTRIBUTING.md
# ==============================================================================

file 'CONTRIBUTING.md', <<~MD
  # Contributing

  1. Fork the repo
  2. Create your feature branch (`git checkout -b my-feature`)
  3. Commit your changes (`git commit -am 'Add my feature'`)
  4. Push to the branch (`git push origin my-feature`)
  5. Create a Pull Request
MD

# ==============================================================================
# after_bundle: generators and final setup
# ==============================================================================

after_bundle do
  # Install RSpec
  generate 'rspec:install'

  # Install overcommit
  run 'bundle exec overcommit --install'

  # Download Bootstrap
  run 'bundle exec rake bootstrap:update'

  # Initial git commit
  git :init unless File.exist?('.git')
  git add: '.'
  git commit: "-m 'Initial commit from Rails template'"
end
