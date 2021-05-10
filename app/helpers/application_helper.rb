module ApplicationHelper
    def get_client
        client = GoCardlessPro::Client.new(
            # We recommend storing your access token in an environment
            # variable for security
            access_token: ENV['GC_ACCESS_TOKEN'],
            # Remove the following line when you're ready to go live
            environment: :sandbox
        )
        client
    end
end
