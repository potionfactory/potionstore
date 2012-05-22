Rails.application.config.middleware.use ExceptionNotifier,
  :email_prefix => "[STORE]",
  :sender_address => %{"Potion Store" <store@domain.com>},
  :exception_recipients => %{storecrash@domain.com}

