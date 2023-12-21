import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:crm/data/models/contract_model.dart';
import 'package:crm/presentations/routes/routes.dart';
import 'package:crm/presentations/tab_screens/contracts/card_widget.dart';
import 'package:crm/utils/constants/colors.dart';
import 'package:crm/utils/constants/sizes.dart';
import 'package:crm/utils/theme/custom_themes/payment_graphic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ContractDetailScreen extends StatefulWidget {
  const ContractDetailScreen({super.key, required this.contract});

  final ContractUser contract;

  @override
  State<ContractDetailScreen> createState() => _ContractDetailScreenState();
}

class _ContractDetailScreenState extends State<ContractDetailScreen> {
  String formatDate(DateTime date) {
    return DateFormat('yyyy/MM/dd').format(date);
  }

  late List<ReportCardDataModel> reportCardData;

  @override
  void initState() {
    super.initState();
    reportCardData = [
      ReportCardDataModel(
        title: 'Jami to\'lov',
        price:
            (double.parse(widget.contract.sum) - double.parse(widget.contract.discount)).toString(),
        cardColor: TColors.tPrimaryColor,
      ),
      ReportCardDataModel(
        title: "Boshlang'ich to'lov",
        price: widget.contract.startPrice.toString(),
        cardColor: TColors.tPrimaryColor,
      ),
      ReportCardDataModel(
        title: ''
            "1m² uchun to'lov",
        price: widget.contract.price.toString(),
        cardColor: TColors.tPrimaryColor,
      ),
      ReportCardDataModel(
        title: "Qolgan to'lov",
        price: widget.contract.left.toString(),
        cardColor: TColors.tPrimaryColor,
      ),
      // ReportCardDataModel(
      //   title: "Qilingan to'lovlar",
      //   price: widget.contract.price.toString(),
      //   cardColor: TColors.tPrimaryColor,
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed(RouteNames.paymentGraphic, arguments: widget.contract.list);
          },
          enableFeedback: true,
          child: const Icon(Icons.list)),
      appBar: AppBar(title: Text(widget.contract.custom.fullName)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.2,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  crossAxisSpacing: 8,
                ),
                itemCount: reportCardData.length,
                itemBuilder: (context, index) {
                  return ReportCard(
                    title: reportCardData[index].title,
                    price: reportCardData[index].price.toString(),
                    cardColor: reportCardData[index].cardColor,
                  );
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(3),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(),
                children: [
                  buildTableRow("Passport berilgan sana",
                      formatDate(widget.contract.detail.issue).toString()),
                  buildTableRow(
                      "Tug'ulgan sanasi", formatDate(widget.contract.detail.birthday).toString()),
                  buildTableRow("Passport seriyasi", widget.contract.detail.passportSeries),
                  buildTableRow("\nViloyat\n", widget.contract.detail.authority),
                  buildTableRow(
                    "\nTelefon raqami\n",
                    "${widget.contract.custom.phone}\n${widget.contract.custom.phone2}",
                  ),
                  buildTableRow("\nYashash manzili\n\n", widget.contract.detail.home),
                  buildTableRow("Ish joyi", widget.contract.detail.workPlace),
                ],
              ),
            ),
            const Divider(),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 15,
                  columns: const [
                    DataColumn(label: Text("№")),
                    DataColumn(label: Text("Sana")),
                    DataColumn(label: Text("Summasi")),
                    DataColumn(label: Text("To'lov turi")),
                  ],
                  rows: widget.contract.payments
                      .map((e) => DataRow(cells: [
                            DataCell(Text((widget.contract.payments.indexOf(e) + 1).toString())),
                            DataCell(Text(dateFormat.format(e.date))),
                            DataCell(Text(moneyFormat.format(double.parse(e.sum)))),
                            DataCell(calculatePaymentState(e.typeId)),
                          ]))
                      .toList()),
            ),
            const Gap(50),
          ],
        ),
      ),
    );
  }
}

Widget calculatePaymentState(String paymentState) {
  switch (paymentState) {
    case '1':
      return buildContainer('Naqd', Colors.green[800]!);
    case "6":
      return buildContainer('Karta(HUMO)', Colors.purple[800]!);
    case "3":
      return buildContainer('Bank', Colors.orange[800]!);
    case "4":
      return buildContainer('Karta(UzCard)', Colors.purple[800]!);
    case "2":
      return buildContainer('P2P', Colors.blue[800]!);
    case "5":
      return buildContainer('AKT', Colors.red[800]!);
  }
  return Text('Nomalum$paymentState');
}

TableRow buildTableRow(String field, String value) {
  return TableRow(
    children: [
      TableCell(
        child: Container(
          color: Colors.grey[300],
          padding: const EdgeInsets.all(8),
          child: Text(field, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      TableCell(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Text(value),
        ),
      ),
    ],
  );
}

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
