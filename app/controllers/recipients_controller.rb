class RecipientsController < ApplicationController
  before_action :set_recipient, only: %i[show edit update destroy]
  before_action :set_user, only: %i[create]

  # GET /recipients
  def index
    @recipients = Recipient.all
  end

  # GET /recipients/1
  def show; end

  # GET /recipients/new
  def new
    @recipient = Recipient.new
  end

  # GET /recipients/1/edit
  def edit; end

  # POST /recipients
  def create
    @recipient = Recipient.new(recipient_params)
    @recipient.user = @user
    # TODO: Create Recipient on Paystack and get the code.
    @recipient.recipient_code = 'RCP_8gwqt1fnkhyryf7'

    if @recipient.save
      redirect_to @user, notice: 'Recipient was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recipients/1
  def update
    if @recipient.update(recipient_params)
      redirect_to @recipient, notice: 'Recipient was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /recipients/1
  def destroy
    @recipient.destroy
    redirect_to recipients_url, notice: 'Recipient was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipient
    @recipient = Recipient.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  # Only allow a list of trusted parameters through.
  def recipient_params
    params.permit(:account, :name, :bank_code, :recipient_code, :user)
  end
end
