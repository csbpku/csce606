Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'S62K0c26t1ADWOZ3TuCrTsPDt', 'xJhwIsz8xjjcggVuCdcBuNo2ZUkbK9Ebj0yiJB1HNWy97d9sZp'
  provider :google_oauth2, '1085946968742-5da5f998m0glstltqgjo3p1a3iau0e27.apps.googleusercontent.com', 'C5egbBfZPjkHnF8pK9X5jnzb', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end