# Add all gems in the global gemset to the $LOAD_PATH so they can be used in rails3 console with bundler
if defined?(::Bundler)
  $LOAD_PATH.concat Dir.glob("#{ENV['rvm_ruby_global_gems_path']}/gems/*/lib")
end

require 'rubygems' unless defined? Gem
require 'irb/completion'
ARGV.concat [ "--readline", "--prompt-mode", "simple" ]
require 'wirble'
require 'wirb'
require 'hirb'
require 'ap'
Wirb.start
# load wirble
Wirble.init
Wirble.colorize

# load hirb
Hirb::View.enable

IRB.conf[:AUTO_INDENT] = true

if ENV.include?('RAILS_ENV')
  if !Object.const_defined?('RAILS_DEFAULT_LOGGER')
    require 'logger'
    Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(STDOUT))
  end

  if ENV['RAILS_ENV'] == 'test'
    require 'test/test_helper'
  end

# for rails 3
elsif defined?(Rails) && !Rails.env.nil?
  if Rails.logger
    Rails.logger =Logger.new(STDOUT)
    ActiveRecord::Base.logger = Rails.logger if defined?(ActiveRecord)
  end
  if Rails.env == 'test'
    require 'test/test_helper'
  end
else
  # nothing to do
end

# annotate column names of an AR model
def show(obj)
  y(obj.send("column_names"))
end

puts "> all systems are go wirble/hirb/ap/show <"
