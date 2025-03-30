class MessagesController < ApplicationController
  before_action :set_message, only: %i[show edit update destroy]

  # GET /messages
  def index
    @messages = Message.all
  end

  # GET /messages/1
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  def create
    @message = Message.new(message_params)

    if @message.save
      # NOTE: original approach to perfrom inline
      # generated_text = AITextGenerator.generate_text(@message.text)
      # @message.update!(generated_text: generated_text)
      # NOTE: next version with a perform later
      GenerateAIMessageJob.perform_later(@message)

      redirect_to edit_message_path(@message), notice: "Message was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      # NOTE: one of the issues with having the same model for text and AI
      # generated text
      GenerateAIMessageJob.perform_later(@message)

      redirect_to messages_path, notice: "Message was successfully created."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy!
    redirect_to messages_url, notice: "Message was successfully destroyed.", status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:text, :name)
  end
end
