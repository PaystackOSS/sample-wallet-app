class User < ApplicationRecord
  #include paystack
  has_many :recipients
  has_many :payins
  has_many :payouts
  has_many :cards
  has_one :wallet

  validates :name, :email, presence: true

  # Callback function after creating the user.
  after_create :create_wallet

  # Create user's wallet
  def create_wallet
    Wallet.create(balance: 0_00, user: self)
  end
end