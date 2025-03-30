class GeneratedGuestbookEntriesController < ApplicationController
  before_action :set_generated_guestbook_entry, only: %i[edit update]

  def edit
  end

  def create
    @generated_guestbook_entry = GeneratedGuestbookEntry.find_or_create_by(generated_guestbook_entry_params)

    # LAB 2 - call generate text inline
    # @generated_guestbook_entry.body = AITextGenerator.generate_text(
    #   @generated_guestbook_entry.guestbook_entry.body
    # )

    # LAB 4 - call generate text in background job
    # @generated_guestbook_entry.update!(body: nil) # TODO: is this needed?
    GeneratedGuestbookEntryJob.perform_later(@generated_guestbook_entry)

    if @generated_guestbook_entry.save
      flash.now[:notice] = "AI text is being generated."
      render :new
    end
  end

  def update
    if params[:refresh]
      flash.now[:notice] = if @generated_guestbook_entry.body.present?
        "AI text successfully generated."
      else
        "AI text is being generated."
      end
      render :new
    elsif @generated_guestbook_entry.update(generated_guestbook_entry_params)
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
    params.require(:generated_guestbook_entry).permit(:guestbook_entry_id, :body)
  end
end
