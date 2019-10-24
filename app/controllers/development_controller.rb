class DevelopmentController < ApplicationController
  # rubocop:disable Metrics/MethodLength
  def randomword
    words = %w[terrify immune clerk council capital separate mountain squash
               dictate blast statement weakness sphere reception demand diamond
               control judgment director continuation recovery abandon video
               freedom patent exaggerate honor gas pedal order scramble linear
               penalty admit resist singer battle still point buttocks twitch
               habitat discrimination thought charter moving anger false collar
               source shareholder waste coalition genetic grimace undermine
               basin desire queue costume relative disability commission
               implicit variation spectrum characteristic modernize
               conglomerate field relationship cultural bishop sensitive
               happen deport mainstream manage explicit belly domestic tolerant
               clarify prospect voyage opposition channel ditch aware style
               investment gesture brown preoccupation attraction daughter floor
               participate forward exact]

    respond_to do |format|
      format.json { render json: { word: words.sample } }
    end
  end
  # rubocop:enable Metrics/MethodLength
end
