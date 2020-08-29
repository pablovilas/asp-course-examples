class Incident < ApplicationRecord
    belongs_to :organization
    has_and_belongs_to_many :components

    after_save :notify
    after_update :notify

    def notify
        self.components.each do |component|
            puts "======== #{component.name} ========"
            component.subscribers.each do |subscriber|
                puts "======== #{subscriber.email} ========"
                ApplicationMailer.with(subscriber: subscriber, incident: self).incident_email.deliver_later
            end
        end 
    end
end
