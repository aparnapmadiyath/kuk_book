import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kukbook/core/common/widgets/custom_text_widget.dart';

import '../../../main.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({super.key});

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  Map<String, String> bankDetails = {
    "Account Holder": "John Doe",
    "Account Number": "123456789012",
    "IFSC Code": "SBIN0001234",
    "Branch Name": "Main Branch",
    "Bank Name": "State Bank of India",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const CustomTextWidget(
          text: "Bank Details",
          color: Colors.white,
          weight: FontWeight.w700,
          fontSizeMultiplier: 0.05,
        ),
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            for (var entry in bankDetails.entries)
              Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  title: Text(entry.key,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(entry.value),
                  trailing: IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: entry.value));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("${entry.key} copied to clipboard")),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
