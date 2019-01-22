module NotesHelper
  def note_content(note)
    auto_link(note.content)
  end
end
