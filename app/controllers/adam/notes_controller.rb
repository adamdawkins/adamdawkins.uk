class Adam::NotesController < AdamController
  def index
    @notes = Note.all
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)

    @note.publish if params[:publish]

    if @note.save
      redirect_to adam_notes_path, notice: "Note created successfully"
    end
  end

  def show
    set_note
  end

  def publish
    set_note
    if @note.publish!
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
