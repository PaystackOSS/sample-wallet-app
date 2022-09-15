class WebhookWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  # sort the webhook events based on data.event
  def perform(webhook)
    json_data = JSON.parse(webhook)
    puts "Webhook #{json_data['data']['status']}"
    case json_data['event']
      # Deposit event
    when 'charge.success'
      add_balance(json_data['data'])
      # Transfer event
    when 'transfer.success'
      remove_balance(json_data['data'])
    else
      puts "Not a transfer  or transaction #{json_data}"
    end
  end

  # add to the user's balance when it's a successful transaction
  def add_balance(transaction)
    # Find the user using the transaction email
    user = User.find_by(email: transaction['customer']['email'])
    wallet = Wallet.find_by user: user
    # Update the payins.
    payin = Payin.new(amount: transaction['amount'],
                      ref: transaction['reference'],
                      date: transaction['paid_at'],
                      user_id: user.id)
    # Save transaction
    payin.save
    # update the wallet's balance
    wallet.increment!(:balance, transaction['amount'])
    # Rudimentary logging.
    puts "Task complete! New Balance: #{wallet.balance}"

    # Save the user's card if it's new check the signature to ensure you're saving a correct card
    return unless transaction['channel'] == 'card'

    # Access the Authorization object from the webhook payload
    authorization = transaction['authorization']
    new_card = Card.new(auth_code: authorization['authorization_code'],
                        last_4: authorization['last4'],
                        brand: authorization['brand'],
                        bank: authorization['bank'],
                        signature: authorization['signature'],
                        user_id: user.id)
    puts "New Card Added #{new_card.valid?}"
    # Check if the signature exists already.
    new_card.valid? ? new_card.save : return
  end

  # deduct from the wallet when its a successful Transfer
  def remove_balance(transfer)
    puts "Transfer #{transfer}"
    recipient = Recipient.find_by(recipient_code: transfer['recipient_code'])
    # find user by transfer recipient, deduct the amount then save
    transfer_wallet = Wallet.find_by(user: recipient.user_id)
    # Payout shows who received it...
    payout = Payout.new(amount: transfer['amount'],
                        transfer_code: transfer['transfer_code'],
                        reason: transfer['reason'],
                        user_id: recipient.user_id)
    # Save the pay out..
    payout.save
    # Deduct from the user's wallet the amount.
    transfer_wallet.decrement!(:balance, transfer['amount'])
    puts "Task complete! New Balance: #{wallet.balance}"
  end
end
