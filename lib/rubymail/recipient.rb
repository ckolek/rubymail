module Mail
    class Recipient
        attr_accessor :address
        attr_accessor :name
        
        def initialize(address = nil, name = nil)
            self.address = address
            self.name = name
        end
        
        def has_name?
            return !self.name.nil?
        end
        
        def inspect
            return self.to_s
        end
        
        def to_s
            return self.has_name? ? "#{@name} <#{@address}>" : @address
        end
        
        class Group
            attr_accessor :name
            attr_reader :recipients
            
            def initialize(name, recipients)
                @name = name
                @recipients = recipients
            end
        
            def inspect
                return self.to_s
            end
            
            def to_s
                return @name + ": " + @recipients.join(", ") + ";"
            end
        end
    end
end