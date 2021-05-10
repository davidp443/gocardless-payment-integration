require 'gocardless_pro'
require 'pp'

class CustomersController < ApplicationController
  def new
    client = helpers.get_client
    redirect_flow = client.redirect_flows.create(
      params: {
        description: 'Lager Kegs', # This will be shown on the payment pages
        session_token: 'dummy_session_token', # Not the access token
        success_redirect_url: 'https://developer.gocardless.com/example-redirect-uri/',
        prefilled_customer: { # Optionally, prefill customer details on the payment page
          given_name: 'Tim',
          family_name: 'Rogers',
          email: 'tim@gocardless.com',
          address_line1: '338-346 Goswell Road',
          city: 'London',
          postal_code: 'EC1V 7LQ'
        }
      }
    )
    @redirect_url = redirect_flow.redirect_url
    @flow_id = redirect_flow.id
  end

  def create
    client = helpers.get_client
    redirect_flow = client.redirect_flows.complete(
      params["flow"]["id"], # The redirect flow ID from above.
      params: { session_token: 'dummy_session_token' })
    pp redirect_flow
    redirect_to customers_path
  end

  def index
    client = helpers.get_client
    @customers = client.customers.list.records
    pp @customers
  end
end
