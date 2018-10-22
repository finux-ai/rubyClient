RSpec.describe Finux::Connector do
  ACCOUNT = '90090042'
  USER = 'demo'
  PASS = 'demo'

  before do
    result = Finux.login('finux-test@example.com', 'Foobar123!')
    @access_token = result[:access_token]
  end

  describe 'connect bank account' do
    it 'should be successful' do
      Finux::Connector.connect_bank_account(@access_token, ACCOUNT, USER, PASS, nil)
    end
  end

  describe 'bank accounts' do
    it 'should return useful data' do
      Finux::Connector.connect_bank_account(@access_token, ACCOUNT, USER, PASS, nil)

      result = Finux::Connector::bank_accounts(@access_token)

      expect(result.count).to eql 1
    end
  end

  describe 'disconnect bank account' do
    it 'should be successful' do
      Finux::Connector.connect_bank_account(@access_token, ACCOUNT, USER, PASS, nil)

      result = Finux::Connector::bank_accounts(@access_token)

      Finux::Connector.disconnect_bank_account(@access_token, result.first[:bank_login_id])
    end
  end

  describe 'connect invoice account' do
    it 'should be successful' do
      Finux::Connector.connect_invoice_account(@access_token)
    end
  end

  describe 'invoices' do
    it 'should return stuff' do
      Finux::Connector.connect_invoice_account(@access_token)

      Finux::Connector.invoices(@access_token)
    end
  end
end
