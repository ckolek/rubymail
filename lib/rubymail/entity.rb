module Mail
    module SMTP
        class Entity
            attr_reader :content_type
            attr_reader :content_transfer_encoding
            attr_reader :content_id
            attr_reader :content_description
            
            def initialize(attrs)
                initialize(
                    attrs[:content_type],
                    attrs[:content_transfer_encoding],
                    attrs[:content_id],
                    attrs[:content_description]
                )
            end
            
            def initialize(content_type, content_transfer_encoding, content_id = nil, content_description = nil)
                @content_type = content_type
                @content_transfer_encoding = content_transfer_encoding
                @content_id = content_id
                @content_description = content_description
            end
            
            def inspect
                return self.to_s
            end
            
            def to_s
                s = "Content-Type: #{@content_type}\r\n"
				s += "Content-Transfer-Encoding: #{@content_transfer_encoding}\r\n"
                s += "Content-ID: #{@content_id}\r\n" unless @content_id.nil?
                s += "Content-Description: #{@content_description}\r\n" unless @content_description.nil?
                
                return s
            end
        end
    end
end