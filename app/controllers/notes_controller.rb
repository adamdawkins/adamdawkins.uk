class NotesController < ApplicationController
  def index
    @notes = Note.published
  end
end
