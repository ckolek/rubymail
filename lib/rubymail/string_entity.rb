module Mail
    module SMTP
        class StringEntity < Entity
            attr_reader :content
            
            def initialize(attrs)
                super.initialize(attrs)
                
                @content = attrs[:content]
            end
            
            def to_s
                s = super.to_s
                s += content.to_s + "\r\n"
                
                return s
            end
        end
    end
end