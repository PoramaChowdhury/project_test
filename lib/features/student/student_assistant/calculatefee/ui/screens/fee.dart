import 'package:flutter/material.dart';
import 'package:project/features/common/ui/widgets/custom_app_bar.dart';

class SemesterFeeCalculator extends StatefulWidget {
  const SemesterFeeCalculator({super.key});

  @override
  State<SemesterFeeCalculator> createState() => _SemesterFeeCalculatorState();
}

class _SemesterFeeCalculatorState extends State<SemesterFeeCalculator> {
  final TextEditingController _totalCreditsController = TextEditingController();
  final TextEditingController _perCreditFeeController = TextEditingController();
  final TextEditingController _waiverPercentageController = TextEditingController();
  final TextEditingController _otherFeesController = TextEditingController();

  double totalFee = 0.0;

  void _calculateFee() {
    setState(() {
      // Get the input values and calculate the total fee
      double totalCredits = double.tryParse(_totalCreditsController.text) ?? 0.0;
      double perCreditFee = double.tryParse(_perCreditFeeController.text) ?? 0.0;
      double waiverPercentage = double.tryParse(_waiverPercentageController.text) ?? 0.0;
      double otherFees = double.tryParse(_otherFeesController.text) ?? 0.0;

      // Calculate the semester fee
      totalFee = (totalCredits * perCreditFee) - (waiverPercentage / 100 * (totalCredits * perCreditFee)) + otherFees;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Fee Calculator'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Input fields for Total Credits, Per Credit Fee, Waiver Percentage, Other Fees
              TextFormField(
                controller: _totalCreditsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Total Credits for Regular Courses',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _perCreditFeeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Per Credit Fee',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _waiverPercentageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Waiver Percentage',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _otherFeesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Other Fees',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
        
              // Button to calculate the fee
              ElevatedButton(
                onPressed: _calculateFee,
                child: const Text('Calculate Fee'),
              ),
        
              const SizedBox(height: 16),
        
              // Display the calculated total fee
              Text(
                'Total Semester Fee: ৳ ${totalFee.toStringAsFixed(2)} Taka',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

