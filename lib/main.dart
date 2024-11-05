import 'package:flutter/material.dart';

void main() {
  runApp(CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CurrencyConverterScreen(),
    );
  }
}

class CurrencyConverterScreen extends StatefulWidget {
  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _mdlController = TextEditingController();
  final TextEditingController _usdController = TextEditingController();
  final double exchangeRate = 17.65;

  void _convertFromMDL(String value) {
    double mdlAmount = double.tryParse(value) ?? 0.0;
    double usdAmount = mdlAmount / exchangeRate;
    setState(() {
      _usdController.text = usdAmount.toStringAsFixed(2);
    });
  }

  void _convertFromUSD(String value) {
    double usdAmount = double.tryParse(value) ?? 0.0;
    double mdlAmount = usdAmount * exchangeRate;
    setState(() {
      _mdlController.text = mdlAmount.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // MDL Input Section
            _buildCurrencyInput(
              controller: _mdlController,
              label: 'MDL',
              hint: 'Amount in MDL',
              onChanged: _convertFromMDL,
            ),

            SizedBox(height: 20),

            // Exchange Arrow Icon
            Icon(Icons.swap_vert, size: 40, color: Colors.blue),

            SizedBox(height: 20),

            // USD Input Section
            _buildCurrencyInput(
              controller: _usdController,
              label: 'USD',
              hint: 'Amount in USD',
              onChanged: _convertFromUSD,
            ),

            SizedBox(height: 40),

            // Exchange Rate Info
            _buildExchangeRate(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyInput({
    required TextEditingController controller,
    required String label,
    required String hint,
    required Function(String) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildExchangeRate() {
    return Column(
      children: [
        Text(
          'Indicative Exchange Rate',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 5),
        Text(
          '1 USD = $exchangeRate MDL',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue[900],
          ),
        ),
      ],
    );
  }
}
