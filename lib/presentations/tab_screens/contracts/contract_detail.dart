import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:crm/data/models/contract_model.dart';
import 'package:crm/presentations/tab_screens/contracts/card_widget.dart';
import 'package:crm/utils/constants/colors.dart';
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
        price: (double.parse(widget.contract.sum) - double.parse(widget.contract.discount)).toString(),
        cardColor: TColors.tPrimaryColor,
      ),
      ReportCardDataModel(
        title: "Boshlang'ich to'lov",
        price: widget.contract.price.toString(),
        cardColor: Colors.green,
      ),
      ReportCardDataModel(
        title: ''
            "1m² uchun to'lov",
        price: widget.contract.square.toString(),
        cardColor: Colors.orange,
      ),
      ReportCardDataModel(
        title: "Qolgan to'lov",
        price: widget.contract.left.toString(),
        cardColor: Colors.red,
      ),
    ];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: double.infinity,
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: TColors.tPrimaryColor,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                ),
              ),
              const Gap(20),
              Flexible(
                child: Text(
                  "${widget.contract.custom.name} ${widget.contract.custom.surname} ${widget.contract.custom.middlename}",
                  style: context.labelMedium?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
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
                  buildTableRow("Passport berilgan sana", formatDate(widget.contract.detail.issue).toString()),
                  buildTableRow("Tug'ulgan sanasi", formatDate(widget.contract.detail.birthday).toString()),
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
            const Gap(50),
          ],
        ),
      ),
    );
  }
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
