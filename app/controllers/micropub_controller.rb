class MicropubController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :authorize_request

  def create
    if request.content_type == 'application/json'
      create_note_from_json_params
    else
      @note = Note.create(content: params[:content])
    end
    redirect_to long_post_path(@note.params), status: :created if @note.publish!
  end

  private

  def create_note_from_json_params
    @note = Note.create(content: params[:properties][:content])
  end

  def set_token
    @token = request.headers['Authorization']
  end

  def render_401
    render plain: '401 Not authorized', status: :unauthorized
  end

  def authorize_request
    logger.info '~> Authorizing micropub request'
    set_token

    render_401 and return if @token.nil?

    response = HTTParty.get('https://tokens.indieauth.com/token',
                            headers: { 'Authorization' => @token })
    indieauth_params = Rack::Utils.parse_nested_query(
      CGI.unescape(response.body)
    )

    return if URI.parse(indieauth_params['me']).host == ENV['FULL_URL']

    render_401
  end
end
