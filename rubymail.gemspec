Gem::Specification.new do |spec|
  spec.name        = 'rubymail'
  spec.version     = '1.0'
  spec.date        = '2013-12-09'
  spec.summary     = "SMTP Library for Ruby"
  spec.description = "A library for composing and sending or receiving email messages through SMTP/IMAP servers."
  spec.authors     = ["Chris Kolek"]
  spec.email       = 'christopher.w@kolek.me'
  spec.files       = [  "lib/rubymail.rb",
                        "lib/attachment.rb",
                        "lib/authentication_type.rb",
                        "lib/message.rb",
                        "lib/recipient.rb",
                        "lib/server.rb",
                        "lib/user.rb" ]
  spec.homepage    =
    'http://github.com/ckolek/rubymail'
end