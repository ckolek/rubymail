module Mail
    module SMTP
        class Server
            DEFAULT_PORT = 25
            DEFAULT_AUTH_TYPE = AuthenticationType::CRAM_MD5
            
            attr_accessor :host
            attr_accessor :port
            attr_accessor :auth_type
            
            def initialize(host, port = DEFAULT_PORT, auth_type = DEFAULT_AUTH_TYPE)
                self.host = host
                self.port = port
                self.auth_type = auth_type
            end
            
            def start(user)
                @smtp = Net::SMTP.new(self.host, self.port)
                @smtp.enable_starttls
                @smtp.start(
                    user.domain,
                    user.username,
                    user.password,
                    self.auth_type)
                
                if (block_given?) then
                    yield self
                    self.stop
                else
                    return self
                end
            end
            
            def send_message(message)
                begin
                    @smtp.send_message(
                        message.to_s,
                        message.from.address,
                        message.recipient_addresses)
                    
                    return true
                rescue Exception => e
                    puts e
                    
                    return false
                end
            end
            
            def stop
                @smtp.finish
                @smtp = nil
            end
        end
    end
    
    module IMAP
        class Server
            DEFAULT_PORT = 143
            DEFAULT_SSL = { verify_mode: OpenSSL::SSL::VERIFY_NONE }
            
            attr_accessor :host
            attr_accessor :port
            attr_accessor :ssl
            
            def initialize(host, port = DEFAULT_PORT, ssl = DEFAULT_SSL)
                self.host = host
                self.port = port
                self.ssl = ssl
            end
            
            def start(user)
                @imap = Net::IMAP.new(host, port: self.port, ssl: self.ssl)
                @imap.login(user.username, user.password)
                
                if (block_given?) then
                    yield self
                    self.stop
                else
                    return self
                end
            end
            
            def select(mailbox)
                return @imap.select(mailbox)
            end
            
            def inbox
                return select('INBOX')
            end
            
            def list(refname = "", mailbox)
                return @imap.list(refname, mailbox)
            end
            
            def responses
                return @imap.responses
            end
            
            def search(query = Query.new.all, charset = nil)
                if (block_given?) then
                    yield query
                end
                
                return @imap.search(query.to_s, charset)
            end
            
            def fetch(set, attr = nil)
                return @imap.fetch(set, attr)
            end
            
            def capability
                return @imap.capability
            end
            
            def stop
                @imap.disconnect
                @imap = nil
            end
        end
    end
end