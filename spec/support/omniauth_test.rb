OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
                  'provider' => 'google_oauth2',
                  'uid' => '12345',
                  'info' => {
                  'email' => 'john@turing.io'
                            },
                    'credentials' => {
                      'access_token' => '29384u9askfj',
                      'refresh_token' => 'laskdj987adsf'
                                  }
                  })
