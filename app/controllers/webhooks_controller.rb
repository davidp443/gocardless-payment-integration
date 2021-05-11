class WebhooksController < ApplicationController
    #include ActionController::Live

    protect_from_forgery except: :create

    def index
    end

    def create
        webhook_endpoint_secret = ENV['GC_WEBHOOK_ENDPOINT_SECRET']
        request_body = request.raw_post

        signature_header = request.headers['Webhook-Signature']

        begin
            pp "BB"
            events = GoCardlessPro::Webhook.parse(request_body: request_body,
                                                  signature_header: signature_header,
                                                  webhook_endpoint_secret: webhook_endpoint_secret)
            pp events
            # Process the events...

            render status: 204, nothing: true

        rescue GoCardlessPro::Webhook::InvalidSignatureError
            render status: 498, nothing: true
        end

    end

end
