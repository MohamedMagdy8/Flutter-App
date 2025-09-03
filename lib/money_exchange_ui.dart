import 'package:flutter/material.dart';

class MoneyExchangeUI extends StatefulWidget {
  const MoneyExchangeUI({super.key});

  @override
  _MoneyExchangeUIState createState() => _MoneyExchangeUIState();
}

class _MoneyExchangeUIState extends State<MoneyExchangeUI>
    with SingleTickerProviderStateMixin {
  String fromCurrency = "USD";
  String toCurrency = "EGP";
  final TextEditingController amountController = TextEditingController();
  String result = "";

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _slideAnimation =
        Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo));
    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _convert() {
    setState(() {
      result =
          "${amountController.text} $fromCurrency = 500 $toCurrency"; // Mock Result
    });
    _controller.forward(from: 0); // play animation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.shade900,
              Colors.indigo.shade600,
              Colors.cyan.shade400
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  "💸 Exchange Your Money",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                          color: Colors.black45,
                          blurRadius: 6,
                          offset: Offset(2, 3))
                    ],
                  ),
                ),
                SizedBox(height: 40),

                // Dropdowns Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDropdown("From", fromCurrency, (value) {
                      setState(() => fromCurrency = value!);
                    }, width: 150),
                    SizedBox(width: 40), // 👈 هنا زودت المسافة (كانت 25)
                    Text(
                      "⇆",
                      style: TextStyle(
                          fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(width: 40), // 👈 برضه خليت المسافة أكبر
                    _buildDropdown("To", toCurrency, (value) {
                      setState(() => toCurrency = value!);
                    }, width: 150),
                  ],
                ),
                SizedBox(height: 30),

                // Amount Input
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Enter Amount",
                    labelStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.cyanAccent, width: 2),
                    ),
                    prefixIcon:
                        Icon(Icons.attach_money, color: Colors.cyanAccent),
                  ),
                ),
                SizedBox(height: 40),

                // Convert Button (3D Gradient)
                Center(
                  child: GestureDetector(
                    onTap: _convert,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      width: 250, // قللت العرض
                      padding: EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purpleAccent, Colors.blueAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 10,
                            offset: Offset(3, 6),
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "🚀 Convert",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.2),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),

                // Result Animated Box
                if (result.isNotEmpty)
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        padding: EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.blue.shade50,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 15,
                              spreadRadius: 2,
                              offset: Offset(2, 8),
                            )
                          ],
                        ),
                        child: Text(
                          result,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label, String currentValue, ValueChanged<String?> onChanged,
    {double width = 120}) {
  return Column(
    children: [
      Text(label,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
      SizedBox(height: 10),
      Container(
        width: width, // خليتها أعرض
        padding: EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white30, width: 1),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 8, offset: Offset(2, 4))
          ],
        ),
        child: DropdownButton<String>(
          dropdownColor: Colors.indigo.shade400,
          value: currentValue,
          underline: SizedBox(),
          iconEnabledColor: Colors.cyanAccent,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
          items: ["USD", "EGP", "EUR", "SAR", "AED"]
              .map((currency) => DropdownMenuItem(
                    value: currency,
                    child: Text(currency, style: TextStyle(color: Colors.white)),
                  ))
              .toList(),
          onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
