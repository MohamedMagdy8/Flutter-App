import 'package:flutter/material.dart';
import 'api_service.dart';
import 'country_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController amountController = TextEditingController();
  final ApiService api = ApiService();

  String? fromCurrency = "USD"; // الافتراضي
  String? toCurrency = "EGP";   // الافتراضي
  String convertedResult = "";
  String unitLine = "";         // للسطر الخامس (سعر الوحدة)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exchange Know your Money"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // مربع إدخال المبلغ
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter Amount",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Dropdown لاختيار العملة الأساسية (From)
            DropdownButtonFormField<String>(
              initialValue: fromCurrency,
              items: all_currencies.map((currency) {
                return DropdownMenuItem(
                  value: currency.countryCode,
                  child: Text("${currency.name} (${currency.countryCode})"),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  fromCurrency = val;
                });
              },
              decoration: const InputDecoration(
                labelText: "From",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Dropdown لاختيار العملة الهدف (To)
            DropdownButtonFormField<String>(
              initialValue: toCurrency,
              items: all_currencies.map((currency) {
                return DropdownMenuItem(
                  value: currency.countryCode,
                  child: Text("${currency.name} (${currency.countryCode})"),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  toCurrency = val;
                });
              },
              decoration: const InputDecoration(
                labelText: "To",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // زرار التحويل
            ElevatedButton(
              onPressed: () async {
                if (amountController.text.isEmpty) return;

                double amount = double.parse(amountController.text);
                var result = await api.convertWithRate(
                    fromCurrency!, toCurrency!, amount);

                if (result != null) {
                  setState(() {
                    convertedResult =
                        "$amount $fromCurrency = ${result["converted"]!.toStringAsFixed(2)} $toCurrency";
                    unitLine =
                        "1 $fromCurrency = ${result["rate"]!.toStringAsFixed(4)} $toCurrency";
                  });
                } else {
                  setState(() {
                    convertedResult = "Error fetching data!";
                    unitLine = "";
                  });
                }
              },
              child: const Text("Convert"),
            ),
            const SizedBox(height: 30),

            // عرض النتيجة
            Center(
              child: Column(
                children: [
                  Text(
                    convertedResult,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    unitLine,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(210, 118, 100, 79),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
