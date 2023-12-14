import 'package:crm/data/models/contract_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentGraphic extends StatelessWidget {
  const PaymentGraphic({super.key, required this.data});
  final List<ListElement> data ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To`lov grafik'),
      ),
      body: SingleChildScrollView(
        child: PaginatedDataTable(
          header: const Text('To`lov grafik'),
          columns: const [
            DataColumn(label: Text('Sana')),
            DataColumn(label: Text('Summasi')),
            // DataColumn(label: Text("Qoldiq")),
            DataColumn(label: Text("Status")),
          ],
          source: _MyDataTableSource(data),
        ),
      ),
    );
  }
}

final dateFormat = DateFormat('yyyy/MM/dd');
final moneyFormat = NumberFormat.simpleCurrency(locale: 'uz_UZ',decimalDigits: 0);
class _MyDataTableSource extends DataTableSource {
  final List<ListElement> data;

  _MyDataTableSource(this.data);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }
    final ListElement element = data[index];

    return DataRow(cells: [
      DataCell(Text(dateFormat.format(element.paymentDate))),
      DataCell(Text(moneyFormat.format(double.parse(element.sum)))),
      // DataCell(Text(moneyFormat.format(double.parse(element.left)))),
      DataCell(Text(element.listDefault)),
    ]);
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}