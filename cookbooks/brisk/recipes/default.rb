#
# Cookbook Name:: brisk
# Recipe:: default
#
# Copyright 2011, DataStax
#
# Apache License
#

###################################################
# 
# Public Variable Declarations
# 
###################################################

# Stop Brisk if it is running.
# Different for Debian due to service package.
if node[:platform] == "debian"
  service "brisk" do
    action :stop
    ignore_failure true
  end
else
  service "brisk" do
    action :stop
  end
end

# Only for debug purposes
OPTIONAL_INSTALL = true





include_recipe "cassandra::setup_repos"


include_recipe "cassandra::required_packages"


if OPTIONAL_INSTALL
  include_recipe "cassandra::optional_packages"
end


include_recipe "brisk::install"


# include_recipe "cassandra::raid"


include_recipe "cassandra::additional_settings"
include_recipe "brisk::additional_settings"

include_recipe "brisk::token_generation"


include_recipe "brisk::create_seed_list"


include_recipe "cassandra::write_configs"
include_recipe "brisk::write_configs"

include_recipe "brisk::restart_service"
