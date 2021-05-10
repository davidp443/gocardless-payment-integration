require 'gocardless_pro'

class PaymentsController < ApplicationController
  def index
    client = helpers.get_client
    @payments = client.payments.list.records
    pp @payments
  end

  def new
    client = helpers.get_client
    @mandates = client.mandates.list.records
    pp @mandates
  end

  def create
    pp params
    mandate_id = params["payment"]["mandate_id"]
    pp mandate_id
    client = helpers.get_client
    payment = client.payments.create(
      params: {
        amount: 1000, # 10 GBP in pence
        currency: 'GBP',
        links: {
          mandate: mandate_id
                 # The mandate ID from last section
        },
        # Almost all resources in the API let you store custom metadata,
        # which you can retrieve later
        metadata: {
          invoice_number: '001'
        }
      },
      headers: {
        'Idempotency-Key' => 'random_payment_specific_string'
      }
    )
    
    # Keep hold of this payment ID - we will use it in a minute
    # It should look like "PM000260X9VKF4"
    puts "ID: #{payment.id}"

    redirect_to payments_path
  end  
end
