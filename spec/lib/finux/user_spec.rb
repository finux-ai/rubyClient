RSpec.describe Finux::User do
  before do
    result = Finux.login('finux-test@example.com', 'Foobar123!')
    @access_token = result[:access_token]
  end

  describe 'store data' do
    it 'should be successful' do
      Finux::User.store(@access_token, '1', 'My Company', 'Mickey', 'Mouse')
    end
  end

  describe 'fetch data' do
    it 'should return users data' do
      Finux::User.store(@access_token, '1', 'My Company', 'Mickey', 'Mouse')

      result = Finux::User.fetch(@access_token)

      expect(result[:business_id]).to eql '1'
      expect(result[:company]).to eql 'My Company'
      expect(result[:firstname]).to eql 'Mickey'
      expect(result[:surename]).to eql 'Mouse'
    end
  end

  describe 'change password' do
    it 'should be successful' do
      Finux::User.change_password(@access_token, 'foobar123!', 'foobar123!', 'foobar123!')
    end
  end
end
