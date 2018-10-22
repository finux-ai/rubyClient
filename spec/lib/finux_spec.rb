RSpec.describe Finux do
  describe 'using ping' do
    it 'a request results in pong' do
      result = Finux.ping

      expect(result).to eql 'pong'
    end
  end

  describe 'using register' do
    it 'gets an accessToken and an refreshToken' do
      result = Finux.register('finux-test@example.com', 'Foobar123!', 'Foobar123!')

      expect(result[:access_token]).to_not be_nil
      expect(result[:refresh_token]).to_not be_nil
    end
  end

  describe 'using login' do
    it 'gets an accessToken and an refreshToken' do
      result = Finux.login('finux-test@example.com', 'Foobar123!')

      expect(result[:access_token]).to_not be_nil
      expect(result[:refresh_token]).to_not be_nil
    end
  end
end
