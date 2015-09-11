module Mail
    class User
        attr_accessor :username
        attr_accessor :password
        attr_accessor :display_name
        attr_accessor :domain
        
        def initialize(username, password, display_name = nil, domain = nil)
            self.username = username
            self.password = password
            self.display_name = display_name
            self.domain = domain
        end
    end
end