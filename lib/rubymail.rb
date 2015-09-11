require 'net/smtp'
require 'net/imap'
require 'base64'
require 'logger'

require_relative 'rubymail/server'
require_relative 'rubymail/query'
require_relative 'rubymail/authentication_type'
require_relative 'rubymail/user'
require_relative 'rubymail/message'
require_relative 'rubymail/recipient'
require_relative 'rubymail/attachment'

module Mail
    $LOG = Logger.new(STDOUT)
    $LOG.formatter = proc { |severity, datetime, progname, msg|
        "#{datetime} (#{severity}) [#{progname}]: #{msg}\n"
    }
end