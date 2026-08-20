# unix navigating
alias la="ls -la"
alias ll="ls -l"
alias o="open ."
alias oagc='open -a "Google Chrome"'
alias oas="open -a Safari.app"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# TCR: test && commit || revert
alias tcr="rspec && git commit -am working || git reset --hard"

# misc
alias random="head /dev/random | md5"
alias tails="tail"
alias yt="yt-dlp --cookies-from-browser=safari "

# Rails
alias b="bundle"
alias be="bundle exec"
alias ber="bundle exec rails"
alias berc="bundle exec rails console"
alias berg="bundle exec rails generate"
alias bers="bundle exec rails server"
alias bert="bundle exec rails test"
alias r="rails"
alias rs="r s"
alias mm="be middleman"
alias f3="foreman start -p 3000"
alias o3="open http://localhost:3000"
alias o4="open http://localhost:4567"

alias dbm="bundle exec rails db:migrate"
alias dbmt="ber db:migrate RAILS_ENV=TEST"
alias nuke="DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop db:create; bundle exec rails db:environment:set RAILS_ENV=development; bundle exec rails db:migrate; bundle exec rails db:seed"
alias nukers="nuke && bers"
alias seed="bundle exec rails db:migrate; bundle exec rails db:seed"

alias acab="bundle exec rubocop"
alias ACAB="acab"
alias ra="be rubocop -A"
alias rao="be rubocop -A --only"
alias ru="bundle exec rubocop"
alias ra="bundle exec rubocop -A"
alias rao="bundle exec rubocop -A --only"
alias ru="bundle exec rubocop"
alias rutodo="bundle exec rubocop --auto-gen-config"
alias rag="git diff --name-only --cached | grep  '.rb$' | tr '\n' ' ' |  xargs  bundle exec rubocop -a"

# markdown
alias md="mdl --rules ~MD013,~MD034,~MD036 README.md"

# utiilites
alias ov="overcommit"
alias ovs="overcommit --sign"

# Zed
alias e="zed ."
alias M="m"
alias m="zed"
alias z="zed"
alias Z="z"

# heroku
alias h3="heroku local -p 3000"
alias gdhm="git pull heroku master"
alias gphm="git push heroku master"
alias h="heroku"
alias hu="git push heroku main"
alias hd="git pull heroku master"
alias hdbm="h run rake db:migrate"
alias hc="h run console"
alias horg="h orgs:default"

# git
alias hb="hub browse"
alias d="git pull"
alias master="gco master"
alias main="gco main"
alias u="git push"
alias gbDD='git branch | grep -v "main" | xargs git branch -D'
alias gbDDm='git branch | grep -v "master" | xargs git branch -D'
alias GDONE="master && gbDD && d && ./script/update"

# go to my projects
alias drop="cd ~/Dropbox"
alias work=" cd ~/Developer"
