# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

server '191.238.164.179', port: 22, roles: %w{app}

set :user, "rubix"
set :ssh_options, {
    user: fetch(:user),
    keys: %w(~/.ssh/id_rsa.pub),
    forward_agent: true
  }
set :stage, :production
set :branch, :production
