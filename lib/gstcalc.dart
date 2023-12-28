import 'package:flutter/material.dart';

class GSTCalculatorApp extends StatefulWidget {
  @override
  _GSTCalculatorAppState createState() => _GSTCalculatorAppState();
}

class _GSTCalculatorAppState extends State<GSTCalculatorApp> {
  bool isActualAmountSelected = true; // Indicates whether Actual Amount is selected (true) or Total Amount (false)
  double actualAmount = 0.0; // Stores the actual amount input by the user
  double gstPercentage = 0.0; // Stores the GST percentage input by the user
  double igst = 0.0; // Stores the IGST calculated
  double cgst = 0.0; // Stores the CGST calculated
  double sgst = 0.0; // Stores the SGST calculated
  double totalAmount = 0.0; // Stores the total amount calculated

  void calculateGST() {
    setState(() {
      if (isActualAmountSelected) {
        // If Actual Amount is selected, calculate IGST, CGST, and SGST based on actualAmount and gstPercentage
        igst = (actualAmount * gstPercentage) / 100;
        cgst = igst / 2;
        sgst = igst / 2;
        totalAmount = actualAmount + igst;
      } else {
        // If Total Amount is selected, calculate Actual Amount based on totalAmount and gstPercentage
        actualAmount = totalAmount - (totalAmount * gstPercentage) / 100;
        igst = (actualAmount * gstPercentage) / 100;
        cgst = igst / 2;
        sgst = igst / 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('GST Calculator'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('Total Amount'),
                  SizedBox(width: 16.0),
                  Switch(
                    value: isActualAmountSelected,
                    onChanged: (newValue) {
                      setState(() {
                        // Toggle between Actual Amount and Total Amount when the switch is changed
                        isActualAmountSelected = newValue;
                      });
                    },
                  ),
                  Text('Actual Amount'),
                ],
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    if (isActualAmountSelected) {
                      // Update actualAmount if Actual Amount is selected
                      actualAmount = double.tryParse(value) ?? 0.0;
                    } else {
                      // Update totalAmount if Total Amount is selected
                      totalAmount = double.tryParse(value) ?? 0.0;
                    }
                  });
                },
                decoration: InputDecoration(
                  labelText: isActualAmountSelected
                      ? 'Actual Amount'
                      : 'Total Amount',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    // Update gstPercentage based on user input
                    gstPercentage = double.tryParse(value) ?? 0.0;
                  });
                },
                decoration: InputDecoration(labelText: 'GST Percentage'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: calculateGST,
                child: Text('Calculate'),
              ),
              SizedBox(height: 20.0),
              Text('IGST: $igst'),
              Text('CGST: $cgst'),
              Text('SGST: $sgst'),
              Text('Actual Amount: $actualAmount'),
              Text('Total Amount: $totalAmount'),

              // Text(
              //     '${isActualAmountSelected ? 'Actual Amount' : 'Total Amount'}: ${isActualAmountSelected ? actualAmount : totalAmount}'),
            ],
          ),
        ),
      ),
    );
  }
}
