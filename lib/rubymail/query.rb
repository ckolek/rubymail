module Mail
    module IMAP
        class Query
            ALL = "ALL"
            ANSWERED = "ANSWERED"
            BCC = "BCC"
            BEFORE = "BEFORE"
            BODY = "BODY"
            CC = "CC"
            DELETED = "DELETED"
            DRAFT = "DRAFT"
            FLAGGED = "FLAGGED"
            FROM = "FROM"
            HEADER = "HEADER"
            KEYWORD = "KEYWORD"
            LARGER = "LARGER"
            NEW = "NEW"
            NOT = "NOT"
            OLD = "OLD"
            ON = "ON"
            OR = "OR"
            RECENT = "RECENT"
            SEEN = "SEEN"
            SENTBEFORE = "SENTBEFORE"
            SENTON = "SENTON"
            SENTSINCE = "SENTSINCE"
            SINCE = "SINCE"
            SMALLER = "SMALLER"
            SUBJECT = "SUBJECT"
            TEXT = "TEXT"
            TO = "TO"
            UID = "UID"
            UNANSWERED = "UNANSWERED"
            UNDELETED = "UNDELETED"
            UNDRAFT = "UNDRAFT"
            UNFLAGGED = "UNFLAGGED"
            UNKEYWORD = "UNKEYWORD"
            UNSEEN = "UNSEEN"
            
            def initialize
                @params = []
            end
            
            # Messages with message sequence numbers corresponding to the
            #  specified message sequence number set.
            def message_set(sequence_set)
                return add_params(sequence_set)
            end
            
            # All messages in the mailbox; the default initial key for
            #  ANDing.
            def all
                return add_params(ALL)
            end
            
            # Messages with the \Answered flag set.
            def answered
                return add_params(ANSWERED)
            end
            
            # Messages that contain the specified string in the envelope
            #  structure's BCC field.
            def bcc(string)
                return add_params(BCC, string)
            end
            
            # Messages whose internal date (disregarding time and timezone)
            #  is earlier than the specified date.
            def before(date)
                return add_params(BEFORE, date_to_s(date))
            end
            
            # Messages that contain the specified string in the body of the
            #  message.
            def body(string)
                return add_params(BODY, string)
            end
            
            # Messages that contain the specified string in the envelope
            #  structure's CC field.
            def cc(string)
                return add_params(CC, string)
            end
            
            # Messages with the \Deleted flag set.
            def deleted
                return add_params(DELETED)
            end
            
            # Messages with the \Draft flag set.
            def draft
                return add_params(DRAFT)
            end
            
            # Messages with the \Flagged flag set.
            def flagged
                return add_params(FLAGGED)
            end
            
            # Messages that contain the specified string in the envelope
            #  structure's FROM field.
            def from(string)
                return add_params(FROM, string)
            end
            
            # Messages that have a header with the specified field-name (as
            #  defined in [RFC-2822]) and that contains the specified string
            #  in the text of the header (what comes after the colon).  If the
            #  string to search is zero-length, this matches all messages that
            #  have a header line with the specified field-name regardless of
            #  the contents.
            def header(field_name, string)
                return add_params(HEADER, field_name, string)
            end
            
            # Messages with the specified keyword flag set.
            def keyword(flag)
                return add_params(KEYWORD, flag)
            end
            
            # Messages with an [RFC-2822] size larger than the specified
            #  number of octets.
            def larger(n)
                return add_params(LARGER, n)
            end
            
            # Messages that have the \Recent flag set but not the \Seen flag.
            #  This is functionally equivalent to "(RECENT UNSEEN)".
            def new
                return add_params(NEW)
            end
            
            # Messages that do not match the specified search key.
            def not
                if (block_given?) then
                    child = Query.new
                
                    yield child
                
                    return add_params(NOT, child)
                else
                    return add_params(NOT)
                end
            end
            
            # Messages that do not have the \Recent flag set.  This is
            #  functionally equivalent to "NOT RECENT" (as opposed to "NOT
            #  NEW").
            def old
                return add_params(OLD)
            end
            
            # Messages whose internal date (disregarding time and timezone)
            #  is within the specified date.
            def on(date)
                return add_params(ON, date_to_s(date))
            end
            
            # Messages that match either search key.
            def or
                left = Query.new
                right = Query.new
                
                yield left, right
                
                return add_params(OR, left, right)
            end
            
            # Messages that have the \Recent flag set.
            def recent
                return add_params(RECENT)
            end
            
            # Messages that have the \Seen flag set.
            def seen
                return add_params(SEEN)
            end
            
            # Messages whose [RFC-2822] Date: header (disregarding time and
            #  timezone) is earlier than the specified date.
            def sent_before(date)
                return add_params(SENTBEFORE, date_to_s(date))
            end
            
            # Messages whose [RFC-2822] Date: header (disregarding time and
            #  timezone) is within the specified date.
            def sent_on(date)
                return add_params(SENTON, date_to_s(date))
            end
            
            # Messages whose [RFC-2822] Date: header (disregarding time and
            #  timezone) is within or later than the specified date.
            def sent_since(date)
                return add_params(SENTSINCE, date_to_s(date))
            end
            
            # Messages whose internal date (disregarding time and timezone)
            #  is within or later than the specified date.
            def since(date)
                return add_params(SINCE, date_to_s(date))
            end
            
            # Messages with an [RFC-2822] size smaller than the specified
            #  number of octets.
            def smaller(n)
                return add_params(SMALLER, n)
            end
            
            # Messages that contain the specified string in the envelope
            #  structure's SUBJECT field.
            def subject(string)
                return add_params(SUBJECT, string)
            end
            
            # Messages that contain the specified string in the header or
            #  body of the message.
            def text(string)
                return add_params(TEXT, string)
            end
            
            # Messages that contain the specified string in the envelope
            #  structure's TO field.
            def to(string)
                return add_params(TO, string)
            end
            
            # Messages with unique identifiers corresponding to the specified
            #  unique identifier set.  Sequence set ranges are permitted.
            def uid(sequence_set)
                return add_params(UID, sequence_set)
            end
            
            # Messages that do not have the \Answered flag set.
            def unanswered
                return add_params(UNANSWERED)
            end
            
            # Messages that do not have the \Deleted flag set.
            def undeleted
                return add_params(UNDELETED)
            end
            
            # Messages that do not have the \Draft flag set.
            def undraft
                return add_params(UNDRAFT)
            end
            
            # Messages that do not have the \Flagged flag set.
            def unflagged
                return add_params(UNFLAGGED)
            end
            
            # Messages that do not have the specified keyword flag set.
            def unkeyword(flag)
                return add_params(UNKEYWORD, flag)
            end
            
            # Messages that do not have the \Seen flag set.
            def unseen
                return add_params(UNSEEN)
            end
            
            def add_params(*params)
                @params.concat(params)
                
                return self
            end
            
            def date_to_s(date)
                return date.strftime("%-d-%b-%Y")
            end
            
            def inspect
                return self.to_s
            end
            
            def to_s
                return @params.join(" ")
            end
        end
    end
end