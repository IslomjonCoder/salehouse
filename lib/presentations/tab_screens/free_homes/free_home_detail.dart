import 'package:crm/data/models/free_home_model.dart';
import 'package:crm/utils/constants/colors.dart';
import 'package:crm/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:ticket_widget/ticket_widget.dart';

class DetailScreen extends StatelessWidget {
  final FreeHomeModel homeModel;

  const DetailScreen({Key? key, required this.homeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: const Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                image: homeModel.image != null
                    ? DecorationImage(
                  image: NetworkImage(homeModel.image!),
                  fit: BoxFit.cover,
                )
                    : const DecorationImage(
                  image: AssetImage(TImages.home),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const Gap(20),
            Center(
              child: TicketWidget(
                color: TColors.tPrimaryColor,
                width: 350,
                height: 500,
                isCornerRounded: true,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Uy raqami', homeModel.number),
                    const Gap(16),
                    _buildInfoRow('Joylashuv', homeModel.blocks.name),
                    const Gap(16),
                    _buildInfoRow('Qavat', homeModel.stage),
                    const Gap(16),
                    _buildInfoRow('Xonalar soni', '${homeModel.rooms}'),
                    const Gap(16),
                    _buildInfoRow('Maydoni', '${homeModel.square} m²'),
                    const Gap(16),
                    const Divider(color: Colors.grey),
                    const Gap(16),
                    _buildInfoRow('Obyekt ID', homeModel.blocks.objectsId),
                    const Gap(16),
                    _buildInfoRow('Xolati', homeModel.islive == '1' ? 'Faol' : 'Faol emas'),
                    const Gap(16),
                    _buildInfoRow(
                      'Tamir Xolati',
                      homeModel.repaired == '1' ? 'Tamirlangan' : 'Tamirlanmagan',
                      color: homeModel.repaired == '1' ? Colors.green : Colors.red,
                    ),
                    const Gap(16),
                    Center(
                      child: SvgPicture.asset(
                        TImages.barCode,
                        height: 70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.white,
          ),
        ),
      ],
    );
  }
}
