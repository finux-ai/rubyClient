module Finux::Connector
  def self.connect_bank_account(access_token, bank_code, username, secret, extra_secret)
    Finux::Net.post('/user/connector/bank/account',
                    access_token: access_token,
                    params: { bankCode: bank_code, extraSecret: extra_secret, saveSecret: true, secret: secret, username: username })
  end

  def self.disconnect_bank_account(access_token, bank_login_id)
    Finux::Net.delete("user/connector/bank/account/#{bank_login_id}",
                      access_token: access_token,)
  end

  def self.bank_account_ids(access_token)
    result = Finux::Net.get('/user/connector/bank/ids',
                            access_token: access_token)
    result['data']
  end

  def self.account_ids(access_token)
    result = Finux::Net.get('/user/connector/bank/accountids',
                            access_token: access_token)
    result['data'].map do |account|
      {
        account_id: account['id'],
        flag:       account['flag']
      }
    end
  end

  def self.change_account(access_token, accounts)
    result = Finux::Net.patch('/user/connector/bank/accountids',
                              access_token: access_token,
                              params: accounts)
  end

  def self.bank_accounts(access_token)
    result = Finux::Net.get('/user/connector/bank/account',
                            access_token: access_token)
    result['data']['accounts'].map do |account|
      {
        account_id:             account['accountId'],
        account_number:         account['accountNumber'],
        balance:                account['balance'],
        bank_code:              account['bank_code'],
        bank_login_id:          account['bankLoginId'],
        bank_name:              account['bankName'],
        bic:                    account['bic'],
        credit_line:            account['credit_line'],
        currency:               account['currency'],
        iban:                   account['iban'],
        icon:                   account['icon'],
        monthly_spending_limit: account['monthlySpendingLimit'],
        name:                   account['name'],
        owner:                  account['owner'],
        type:                   account['type'],
        transactions:           account['transactions'].map do |transaction|
          {
            account_id:          transaction['accountId'],
            amount:              transaction['amount'],
            booking_text:        transaction['booking_text'],
            creditor_id:         transaction['creditorId'],
            currency:            transaction['currency'],
            date_of_transaction: transaction['dateOfTransaction'],
            mref:                transaction['mref'],
            purpose:             transaction['purpose'],
            sepa_purpose_code:   transaction['sepaPurposeCode'],
            transaction_code:    transaction['transactionCode'],
            transaction_id:      transaction['transactionId'],
            type_of_debit:       transaction['typeOfDebit'],
            type_of_transaction: transaction['typeOfTransaction'],
            payment_partner: {
              bic:         transaction['paymentPartner']['bic'],
              creditor_id: transaction['paymentPartner']['creditorId'],
              iban:        transaction['paymentPartner']['iban'],
              name:        transaction['paymentPartner']['name']
            }
          }
        end
      }
    end
  end

  def self.bank_account(access_token, account_id)
    result = Finux::Net.get("/user/connector/bank/account/#{account_id}")
    account = result['data']['account']
    
    {
      account_id:             account['accountId'],
      account_number:         account['accountNumber'],
      balance:                account['balance'],
      bank_code:              account['bank_code'],
      bank_login_id:          account['bankLoginId'],
      bank_name:              account['bankName'],
      bic:                    account['bic'],
      credit_line:            account['credit_line'],
      currency:               account['currency'],
      iban:                   account['iban'],
      icon:                   account['icon'],
      monthly_spending_limit: account['monthlySpendingLimit'],
      name:                   account['name'],
      owner:                  account['owner'],
      type:                   account['type'],
      transactions:           account['transactions'].map do |transaction|
        {
          account_id:          transaction['accountId'],
          amount:              transaction['amount'],
          booking_text:        transaction['booking_text'],
          creditor_id:         transaction['creditorId'],
          currency:            transaction['currency'],
          date_of_transaction: transaction['dateOfTransaction'],
          mref:                transaction['mref'],
          purpose:             transaction['purpose'],
          sepa_purpose_code:   transaction['sepaPurposeCode'],
          transaction_code:    transaction['transactionCode'],
          transaction_id:      transaction['transactionId'],
          type_of_debit:       transaction['typeOfDebit'],
          type_of_transaction: transaction['typeOfTransaction'],
          payment_partner: {
            bic:         transaction['paymentPartner']['bic'],
            creditor_id: transaction['paymentPartner']['creditorId'],
            iban:        transaction['paymentPartner']['iban'],
            name:        transaction['paymentPartner']['name']
          }
        }
      end
    }
  end

  def self.connect_invoice_account(access_token)
    Finux::Net.post('/user/connector/gmi/account',
                    access_token: access_token)
  end

  def self.invoices(access_token)
    result = Finux::Net.get('/user/connector/gmi/invoices',
                            access_token: access_token)
    {
      total_count: result['data']['total_count'],
      start: result['data']['start'],
      offset: result['data']['offset'],
      records: result['data']['records'].map do |record|
        {
          prim_uid: record['prim_uid'],
          supplier_uid: record['supplier_uid'],
          invoice_number: record['invoice_number'],
          invoice_date: record['invoice_date'],
          invoice_due_date: record['invoice_due_date'],
          net_amount: record['net_amount'],
          vat: record['vat'],
          gross_amount: record['gross_amount'],
          currency: record['currency'],
          is_archived: record['is_archived'],
          is_ocr_completed: record['is_ocr_completed'],
          tags: record['tags'],
          note: record['note'],
          source: record['source'],
          filename: record['filename'],
          file_size: record['file_size'],
          payment_status: record['payment_status'],
          payment_method: record['payment_method'],
          payment_details: {
            iban: record['payment_details']['iban'],
            bic: record['payment_details']['bic'],
            account_holder_name: record['payment_details']['account_holder_name'],
            account_number: record['payment_details']['account_number'],
            bank_name: record['payment_details']['bank_name'],
            bank_address: record['payment_details']['bank_address'],
            sort_code: record['payment_details']['sort_code'],
            routing_number: record['payment_details']['routing_number'],
            ifsc_code: record['payment_details']['ifsc_code'],
            routing_code: record['payment_details']['routing_code']
          }
        }
      end
    }
  end
end
