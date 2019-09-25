class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def incident_email
    @subscriber = params[:subscriber]
    @incident = params[:incident]
    mail(to: @subscriber.email, subject: 'New incident!', template_path: 'subscribers_mailer')
    sleep(3.second) # Simulate mail latency
  end
end
