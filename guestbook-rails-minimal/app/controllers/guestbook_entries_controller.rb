class GuestbookEntriesController < ApplicationController
  before_action :set_guestbook_entry, only: %i[show edit update destroy]

  # GET /guestbook_entries
  def index
    @guestbook_entries = GuestbookEntry.all
  end

  # GET /guestbook_entries/1
  def show
  end

  # GET /guestbook_entries/new
  def new
    @guestbook_entry = GuestbookEntry.new
  end

  # GET /guestbook_entries/1/edit
  def edit
  end

  # POST /guestbook_entries
  def create
    @guestbook_entry = GuestbookEntry.new(guestbook_entry_params)

    if @guestbook_entry.save
      redirect_to @guestbook_entry, notice: "Guestbook entry was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /guestbook_entries/1
  def update
    if @guestbook_entry.update(guestbook_entry_params)
      redirect_to @guestbook_entry, notice: "Guestbook entry was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /guestbook_entries/1
  def destroy
    @guestbook_entry.destroy!
    redirect_to guestbook_entries_url, notice: "Guestbook entry was successfully destroyed.", status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_guestbook_entry
    @guestbook_entry = GuestbookEntry.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def guestbook_entry_params
    params.require(:guestbook_entry).permit(:body, :name)
  end
end
