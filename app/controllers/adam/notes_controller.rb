class Adam::NotesController < AdamController
  def index
    @notes = Note.all
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)

    if @note.save
      redirect_to adam_notes_path, notice: "Note created successfully"
    end
  end

  def show
    set_note
  end

  def publish
    set_note
    @note.published_at = Time.now
    if @note.save
      redirect_to note_path(@note.params), notice: "Note created successfully"
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
