def login_as_adam
  post sessions_url, params: { password: Rails.application.credentials.adam[:password] }
end
