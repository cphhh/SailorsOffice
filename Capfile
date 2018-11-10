# Capfile

# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# include rails tasks
require 'capistrano/rails'

# include uberspace tasks
require 'capistrano/uberspace'

# ...

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

config/deploy/{stage}.rb

# the Uberspace server you are on
server 'ara.uberspace.de', user: 'cphh', roles: %w{app db web}
set :deploy_to, "/home/cphh/#{fetch :application}"
