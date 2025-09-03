class Currency {
  final String name;       // اسم العملة
  final String countryCode; // الكود (مثال: USD, EGP)

  Currency(this.name, this.countryCode);
}

List<Currency>all_currencies = [
Currency("Australian Dollar", "AUD"),
  Currency("Bahraini Dinar", "BHD"),
  Currency("Brazilian Real", "BRL"),
  Currency("British Pound", "GBP"),
  Currency("Canadian Dollar", "CAD"),
  Currency("Chinese Yuan", "CNY"),
  Currency("Egyptian Pound", "EGP"),
  Currency("Euro", "EUR"),
  Currency("Indian Rupee", "INR"),
  Currency("Indonesian Rupiah", "IDR"),
  Currency("Japanese Yen", "JPY"),
  Currency("Kuwaiti Dinar", "KWD"),
  Currency("Malaysian Ringgit", "MYR"),
  Currency("Mexican Peso", "MXN"),
  Currency("Omani Rial", "OMR"),
  Currency("Pakistani Rupee", "PKR"),
  Currency("Qatari Riyal", "QAR"),
  Currency("Russian Ruble", "RUB"),
  Currency("Saudi Riyal", "SAR"),
  Currency("Singapore Dollar", "SGD"),
  Currency("South African Rand", "ZAR"),
  Currency("Swiss Franc", "CHF"),
  Currency("Turkish Lira", "TRY"),
  Currency("UAE Dirham", "AED"),
  Currency("US Dollar", "USD"),
];
