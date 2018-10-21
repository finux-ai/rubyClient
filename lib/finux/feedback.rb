class Finux::Feedback
  def self.send(access_token, message)
    result = Finux::Net.post('/user/feedback',
                             access_token: access_token,
                             params: { message: message })
  end
end
