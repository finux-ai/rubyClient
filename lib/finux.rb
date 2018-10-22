require 'finux/version'
require 'finux/net'
require 'finux/user'
require 'finux/feedback'
require 'finux/connector'
require 'finux/intelligence'
require 'finux/request_exception'
require 'net/http'
require 'json'

module Finux
  def self.ping
    response = Finux::Net.get '/ping'
    response['status']
  end

  def self.register(email, password, repeat_password)
    response = Finux::Net.post('/register',
                               params: { email: email, password: password, repeatPassword: repeat_password })
    {
      access_token: response['data']['accessToken'],
      refresh_token: response['data']['refreshToken']
    }
  end

  def self.login(email, password)
    response = Finux::Net.post('/login',
                               params: { email: email, password: password })
    {
      access_token: response['data']['accessToken'],
      refresh_token: response['data']['refreshToken']
    }
  end
end
