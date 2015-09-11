require "../rubemail"

module Mail
    user = User.new("ckolek@gmail.com", "ripeflow10792")

    smtp = SMTP::Server.new("smtp.gmail.com", 587, AuthenticationType::LOGIN)

    msg = SMTP::Message.new { |m|
        m.set_sender "ckolek@gmail.com", "Chris Kolek"
        m.add_to("ckolek@gmail.com", "Chris Kolek")
        m.subject = "Test #{Time.now}"
        m.body = "<p>This <i>is</i> a <strong>test</strong> message.</p>"
        m.add_attachment(
            "C:/users/ckolek/Documents/School/G - Junior 1/Co-op/Resume.pdf",
            "application/pdf")
        m.add_attachment(
            "C:/users/ckolek/Documents/School/G - Junior 1/Co-op/Cover Letter.pdf",
            "application/pdf")
    }

    smtp.start(user) { |s|
        #s.send_message(msg)
    }

    imap = IMAP::Server.new("imap.gmail.com", 993)

    imap.start(user) { |s|
        s.inbox
        m_ids = s.search { |q|
            q.not.deleted
            q.since(Time.now - (60 * 60 * 24 * 3)) # now - 3 days
            
            print "Query: #{q}\n\n"
        }
        
        print "Results: (#{m_ids.count}): #{m_ids}\n\n"
        
        m_ids.reverse.each { |m_id|
            m = s.fetch(m_id, "RFC822")
            
            puts m[0].attr["RFC822"]
            
            break
        }
    }
end