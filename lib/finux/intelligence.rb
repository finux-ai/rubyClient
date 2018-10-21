module Finux::Intelligence
  def self.forecast(access_token)
    result = Finux::Net.get('/user/intelligence/forecast',
                            access_token: access_token)
    {
      date:   result['data']['date'],
      max:    result['data']['max'],
      min:    result['data']['min'],
      scaled: result['data']['scaled'],
      value:  result['data']['value']
    }
  end

  def self.smartalerts(access_token)
    result = Finux::Net.get('/user/intelligence/smartalerts',
                            access_token: access_token)
    {
      name:  result['data']['name'],
      value: result['data']['value'],
      sum:   result['data']['sum']
    }
  end
end
