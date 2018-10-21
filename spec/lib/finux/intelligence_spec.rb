RSpec.describe Finux::Intelligence do
  before do
    result = Finux.login('finux-test@example.com', 'foobar123!')
    @access_token = result[:access_token]
  end

  describe 'forecast' do
    it 'should be successful' do
      Finux::Intelligence.forecast(@access_token)
    end
  end

  describe 'smartalerts' do
    it 'should be successful' do
      Finux::Intelligence.smartalerts(@access_token)
    end
  end
end
