class GeneratedGuestbookEntriesController < ApplicationController
  before_action :set_generated_guestbook_entry, only: %i[edit update]

  def edit
  end

  def create
    @generated_guestbook_entry = GeneratedGuestbookEntry.find_or_initialize_by(generated_guestbook_entry_params)
    @generated_guestbook_entry.body = AITextGenerator.generate_text(
      @generated_guestbook_entry.guestbook_entry.body
    )

    if @generated_guestbook_entry.save
      render :new
    end
  end

  def update
    if @generated_guestbook_entry.update(generated_guestbook_entry_params)
      redirect_to \
        @generated_guestbook_entry.guestbook_entry,
        notice: "Guestbook entry was successfully updated.",
        status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_generated_guestbook_entry
    @generated_guestbook_entry = GeneratedGuestbookEntry.find(params[:id])
  end

  def generated_guestbook_entry_params
    params.require(:generated_guestbook_entry).permit(:guestbook_entry_id)
  end
end
