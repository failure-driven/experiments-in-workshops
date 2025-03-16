module GuestbookWithAIFull
  class EntriesController < ApplicationController
    before_action :set_entry, only: %i[update]

    # GET /entries
    def index
      @entries = Entry.published
    end

    # GET /entries/new
    def new
      @entry = Entry.new
    end

    # POST /entries
    def create
      @entry = Entry.new(entry_params)

      if @entry.save
        if @entry.generate_ai_text?
          # TODO: move to a better place
          # LAB 3 - START CODE
          generate_text_job = GenerateAITextJob.perform_later(@entry)
          @entry.update!(generate_job_id: generate_text_job.job_id)
          # LAB 3 - END CODE
          flash.now[:notice] = "AI is generating the response, please wait..."
          render :new, status: :ok
        else
          redirect_to guestbook_with_ai_full_root_path, notice: "Entry was successfully created."
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /entries/1
    def update
      # TODO: check if still processing? or don't let it come here
      if params[:button] == "check"
        flash.now[:notice] = if @entry.generated_text.present? && @entry.generate_job_id.blank?
          "AI generation complete"
        else
          "AI is generating the response, please wait..."
        end
        render :new, status: :ok
      elsif @entry.update(entry_params) && @entry.generate_ai_text && @entry.generated_text.present?
        redirect_to guestbook_with_ai_full_root_path, notice: "Entry was successfully created."
      elsif @entry.update(entry_params) && @entry.generate_ai_text && @entry.generated_text.blank?
        flash.now[:notice] = "AI is generating the response, please wait..."
        render :new, status: :ok
      elsif @entry.update(entry_params) && !@entry.generate_ai_text
        redirect_to guestbook_with_ai_full_root_path, notice: "Entry was successfully created."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def entry_params
      params.require(:entry).permit(
        :title,
        :text,
        :name,
        :date,
        :generate_ai_text,
        :use_generated_text
      )
    end
  end
end
