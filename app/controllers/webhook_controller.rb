class WebhookController < ApplicationController
  skip_before_action :verify_authenticity_token
  #  before_action :verify_event
  
  # POST Webhook events https://mywebsite.com/webhook-events 
  def webhook_events
    # acknowledge the data by sending 200 OK..
    head :ok, content_type: 'application/json'
    # Queue the webhook for processing...
    json_body = request.body.read()
    WebhookWorker.perform_async(json_body)
  end

  private

  #  authenticate that the events come from Paystack only.
  def verify_event
    valid_ips = ['52.31.139.75', '52.49.173.169', '52.214.14.220']
    # Signature verification as well..
  end
end
