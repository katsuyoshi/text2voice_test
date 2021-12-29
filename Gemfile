# frozen_string_literal: true

source "https://rubygems.org"
win = /mswin|msys|mingw|cygwin|bccwin|wince|emc/ =~ RbConfig::CONFIG['host_os']

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem "text2voice"
gem "dotenv"
gem "win32-sound" if win
