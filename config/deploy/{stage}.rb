# the Uberspace server you are on
server 'ara.uberspace.de', user: 'cphh', roles: %w{app db web}
set :deploy_to, "/home/cphh/#{fetch :application}"
