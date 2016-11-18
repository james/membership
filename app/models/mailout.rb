class Mailout < ApplicationRecord
  belongs_to :group
  belongs_to :user

  def send_email
    mg_client = Mailgun::Client.new ENV['MAILGUN_API_KEY']
    mb_obj = Mailgun::BatchMessage.new(mg_client, "mailer.abscond.org")
    mb_obj.set_from_address(self.from_email, {"first"=>"James", "last" => "Darling"})
    mb_obj.set_subject(self.subject)
    mb_obj.set_text_body(self.body)
    self.group.people.each do |person|
      mb_obj.add_recipient(:to, person.email_address, {"first_name" => person.first_name, "last_name" => person.last_name})
    end
    response = mb_obj.finalize
    self.mailgun_id = response.keys.first
    self.save!
  end

  def events
    mg_client = Mailgun::Client.new ENV['MAILGUN_API_KEY']
    mg_events = Mailgun::Events.new(mg_client, "mailer.abscond.org")
    result = mg_events.get({'limit' => 25,
                            'message-id' => self.mailgun_id})
  end
end
