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
    @note = Note.find(params[:id])
  end

  private
    
    def note_params
      params.require(:note).permit(:content)
    end
end
