import 'package:crm/data/models/contract_model.dart';
import 'package:crm/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentGraphic extends StatelessWidget {
  const PaymentGraphic({super.key, required this.data});

  final List<ListElement> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To`lov grafik'),
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text("№")),
              DataColumn(label: Text('Sana')),
              DataColumn(label: Text('Summasi')),
              DataColumn(label: Text("To'langan")),
              // Uncomment the line below if you want to display 'Qoldiq'
              // DataColumn(label: Text("Qoldiq")),
              DataColumn(label: Text("Status")),
            ],
            rows: data.map((element) {

              return DataRow(cells: [
                DataCell(Text((data.indexOf(element) + 1).toString())),
                DataCell(Text(dateFormat.format(element.paymentDate))),
                DataCell(Text(moneyFormat.format(double.parse(element.sum)))),
                DataCell(Text(calculateDifference(element))),
                // Uncomment the line below if you want to display 'Qoldiq'
                // DataCell(Text(moneyFormat.format(double.parse(element.left)))),
                DataCell(Container(child: calculatePaymentState(element))),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// Your existing widget functions...

final dateFormat = DateFormat('dd/MM/yyyy');
final moneyFormat = NumberFormat.simpleCurrency(locale: 'uz_UZ', decimalDigits: 0);

String calculateDifference(ListElement element) {
  try {
    double sum = double.parse(element.sum);
    double left = double.parse(element.left);

    // Perform your arithmetic operations here
    double difference = sum - left.round();

    return moneyFormat.format(double.parse(difference.toString()));
  } catch (e) {
    // print(e);
    // Handle parsing errors or other exceptions
    return 'Invalid Data';
  }
}
Widget calculatePaymentState(ListElement element) {
  BoxDecoration getDecoration(Color color) {
    return BoxDecoration(color: color, borderRadius: BorderRadius.circular(TSizes.sm));
  }

  TextStyle getTextStyle() {
    return const TextStyle(color: Colors.white, fontWeight: FontWeight.w600);
  }

  Widget buildContainer(String text, Color color) {
    return Container(
      decoration: getDecoration(color),
      padding: const EdgeInsets.all(TSizes.sm),
      child: Text(
        text,
        style: getTextStyle(),
      ),
    );
  }

  switch (element.left) {
    case "0.0":
      return buildContainer("To'landi", Colors.green[800]!);
    case "0": // Add a case for the numeric value
      return buildContainer("To'landi", Colors.green[800]!);
    case "":
    // Add a case for an empty string if needed
      return buildContainer("Invalid State", Colors.grey);
    case var leftAmount when leftAmount == element.sum:
      return buildContainer("To'lanmagan", Colors.red[900]!);
    default:
      return buildContainer("Chala to'langan", Colors.orange[800]!);
  }
}
