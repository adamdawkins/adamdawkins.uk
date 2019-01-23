class Adam::NotesController < AdamController
  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)

    @note.publish if params[:publish]

    if @note.save
      TwitterService.post(@note) if params[:publish] && params[:send_to_twitter]
      redirect_to adam_posts_path, notice: "Note created successfully"
    end
  end

  def show
    set_note
  end

  def index
    @notes = Note.all
  end

  def publish
    set_note
    if @note.publish!
      TwitterService.post(@note) if params[:send_to_twitter]
      redirect_to note_path(@note.params), notice: "Note published successfully"
    end
  end

  private

    def set_note
      @note = Note.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:content)
    end
end
