module Mail
    module SMTP
        class Attachment < Entity
            attr_reader :filename
            attr_reader :path
            
            def initialize(attrs)
                super.initialize(attrs)
                
                @path = attrs[:path]
                @filename = @path[(@path.rindex("/") + 1)..-1]
            end
            
            def initialize(path, content_type, content_transfer_encoding, content_id = nil,
                content_description = nil)
                super.initialize(content_type, content_transfer_encoding, content_id,
                    content_description)
                
                @path = path
                @filename = path[(path.rindex("/") + 1)..-1]
            end
            
            def content_type
                return "#{super.content_type}; name=\"#{@filename}"
            end
            
            def to_s
                s = super.to_s
                
                s += "Content-Disposition: attachment; filename=\"#{@filename}\"\r\n"
                s += "\r\n"
                s += Base64.encode64(File.binread(path)) + "\r\n"
                
                return s
            end
        end
    end
end