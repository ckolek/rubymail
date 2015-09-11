module Mail
    module SMTP
        class Message
            # @!attribute
            # @return [DateTime]
            # Specifies the date and time at which the creator of the message indicated that the
            # message was complete and ready to enter the mail delivery system.
            attr_accessor :date
            
            #@!group Originator Field Attributes
            
            # @!attribute
            # @return [Array<Recipient, Recipient::Group>]
            # Specifies the author(s) of the message, that is, the mailbox(es) of the person(s) or
            # system(s) responsible for the writing of the message.
            attr_reader :from
            
            # @!attribute
            # @return [Recipient]
            # Specifies the mailbox of the agent responsible for the actual transmission of the
            # message.
            attr_accessor :sender
            
            # @!attribute
            # @return [Array<Recipient, Recipient::Group>]
            # Indicates the mailbox(es) to which the author of the message suggests that replies be
            # sent.
            attr_reader :reply_to
            
            # @!attribute
            # @return [Boolean]
            # Field contains a comma-separated list of important words and phrases that might be
            # useful for the recipient.
            attr_accessor :disclose_sender
            alias_method :disclose_sender?, :disclose_sender
            
            #@!endgroup
            #@!group Destination Address Field Attributes
            
            # @!attribute
            # @return [Array<Recipient, Recipient::Group>]
            # Contains the address(es) of the primary recipient(s) of the message.
            attr_reader :to
            
            # @!attribute
            # @return [Array<Recipient, Recipient::Group>]
            # Contains the addresses of others who are to receive the message, though the content of
            # the message may not be directed at them.
            attr_reader :cc
            
            # @!attribute
            # @return [Array<Recipient, Recipient::Group>]
            # Contains addresses of recipients of the message whose addresses are not to be revealed
            # to other recipients of the message.
            attr_reader :bcc
            
            #@!endgroup
            #@!group Identification Field Attributes
            
            # @!attribute
            # @return [String]
            # Provides a unique message identifier that refers to a particular version of a
            # particular message.
            attr_accessor :message_id
            
            # @!attribute
            # @return [String]
            # Used when creating a reply to a message. Holds the message identifier of the original
            # message and the message identifiers of other messages. May be used to identify the
            # message (or messages) to which the new message is a reply.
            attr_accessor :in_reply_to
            
            # @!attribute
            # @return [String]
            # Used when creating a reply to a message. Holds the message identifier of the original
            # message and the message identifiers of other messages. May be used to identify a
            # "thread" of conversation.
            attr_accessor :references
            
            #@!endgroup
            #@!group Informational Field Attributes
            
            # @!attribute
            # @return [String]
            # Contains a short string identifying the topic of the message.
            attr_accessor :subject
            
            # @!attribute
            # @return [String]
            # Contains any additional comments on the text of the body of the message.
            attr_accessor :comments
            
            # @!attribute
            # @return [Array<String>]
            # Field contains a comma-separated list of important words and phrases that might be
            # useful for the recipient.
            attr_reader :keywords
            
            #@!endgroup
            #@!group Entity Attributes
            
            # @!attribute
            # @return [String]
            # Field contains a comma-separated list of important words and phrases that might be
            # useful for the recipient.
            attr_accessor :body
            
            # @!attribute
            # @return [Array<Attachment>]
            # Field contains a comma-separated list of important words and phrases that might be
            # useful for the recipient.
            attr_reader :attachments
            
            # @!attribute
            # @return [Numeric]
            # Field contains a comma-separated list of important words and phrases that might be
            # useful for the recipient.
            attr_accessor :mime_version
            
            #@!endgroup
            
            def initialize
                @from = []
                @reply_to = []
                @to = []
                @cc = []
                @bcc = []
                @keywords = []
                @attachments = []
                self.disclose_sender = true
                self.disclose_recipients = true
                self.mime_version = 1.0
            end
            
            def add_from(address, name = nil, is_sender = false)
                @from << (from = Recipient.new(address, name))
                
                if (is_sender) then
                    @sender = from
                end
            end
            
            def set_sender(address, name = nil)
                @sender = Recipient.new(address, name)
            end
            
            def add_reply_to(address, name = nil)
                @reply_to << Recipient.new(address, name)
            end
            
            def add_to(address, name = nil)
                @to << Recipient.new(address, name)
            end
            
            def add_cc(address, name = nil)
                @cc << Recipient.new(address, name)
            end
            
            def add_bcc(address, name = nil)
                @bcc << Recipient.new(address, name)
            end
            
            def recipients
                return @to + @cc + @bcc
            end
            
            def recipient_addresses
                return self.recipients.map { |recipient| recipient.address }
            end
            
            def add_attachment(attrs)
                @attachments << Attachment.new(attrs)
            end
            
            def add_attachment(path, mime_type = nil, content_id = nil)
                @attachments << Attachment.new(path, mime_type, content_id)
            end
            
            def has_attachments?
                return !@attachments.empty?
            end
            
            def inspect
                return self.to_s
            end
            
            def to_s
                marker = Message.create_marker
                
                date = self.date.nil? ? DateTime.now : self.date
                
                s =<<HEADERS
Date: #{date.strftime('')}
From: #{self.disclose_sender? ? self.from : nil}
To: #{self.disclose_recipients? ? self.to.join(", ") : nil}
Cc: #{self.disclose_recipients? ? self.cc.join(", ") : nil}
Subject: #{self.subject}
MIME-Version: #{self.mime_version}
Content-Type: multipart/mixed; boundary=#{marker}
HEADERS

                parts = [self.body]
                parts += self.attachments
                
                s += parts.join("--#{marker}\r\n")
                s += "--"
                
                return s
            end
            
            def self.create_marker
                alpha = [('a'..'z'), ('A'..'Z'), (0..9)].map { |i| i.to_a }.flatten
                return (0...25).map{ alpha[rand(alpha.length)] }.join
            end
        end
    end
end