class IndiemarksController < ApplicationController
  def index
    @levels = IndieMarkLevel.all
  end
end
