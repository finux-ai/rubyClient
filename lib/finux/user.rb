module Finux::User
  def self.store(access_token, business_id, company, firstname, surename)
    Finux::Net.put('/user/profile',
                   access_token: access_token,
                   params: { businessID: business_id, company: company, firstname: firstname, surename: surename })
  end
  
  def self.fetch(access_token)
    result = Finux::Net.get('/user/profile',
                            access_token: access_token)
    {
      business_id: result['data']['businessID'],
      company:     result['data']['company'],
      firstname:   result['data']['firstname'],
      surename:    result['data']['surename']
    }
  end

  def self.change_password(access_token, old, new, repeat)
    Finux::Net.put('/user/changepw',
                   access_token: access_token,
                   params: { oldPassword: old, newPassword: new, repeatPassword: repeat })
  end
end
