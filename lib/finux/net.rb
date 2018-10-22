module Finux::Net
  BASE_URL = 'https://app.dev.finux.ai'

  def self.get(path, access_token: nil, params: {})
    uri = URI(BASE_URL + '/api' + path)
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Get.new uri
      request['Authorization : Bearer'] = access_token if access_token
      http.request request
    end

    json_response = JSON.parse(response.body)
    raise Finux::RequestException.new(json_response['status']['message']) unless response.code == '200'

    json_response
  end

  def self.post(path, access_token: nil, params: {})
    uri = URI(BASE_URL + '/api' + path)
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Post.new uri
      request['Authorization : Bearer'] = access_token if access_token
      request.set_form_data params
      http.request request
    end

    json_response = JSON.parse(response.body)
    raise Finux::RequestException.new(json_response['status']['message']) unless response.code == '200'

    json_response
  end

  def self.put(path, access_token: nil, params: {})
    uri = URI(BASE_URL + '/api' + path)
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Put.new uri
      request['Authorization : Bearer'] = access_token if access_token
      request.set_form_data params
      http.request request
    end

    json_response = JSON.parse(response.body)
    raise Finux::RequestException.new(json_response['status']['message']) unless response.code == '200'

    json_response
  end

  def self.delete(path, access_token: nil)
    uri = URI(BASE_URL + '/api' + path)
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Delete.new uri
      request['Authorization : Bearer'] = access_token if access_token
      http.request request
    end

    json_response = JSON.parse(response.body)
    raise Finux::RequestException.new(json_response['status']['message']) unless response.code == '200'

    json_response
  end
end
