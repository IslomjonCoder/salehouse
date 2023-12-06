// import 'package:awesome_extensions/awesome_extensions.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:crm/business_logic/blocs/general_bloc/general_bloc.dart';
// import 'package:crm/presentations/common_widgets/rounded_container.dart';
// import 'package:crm/presentations/routes/routes.dart';
// import 'package:crm/utils/constants/api_constants.dart';
// import 'package:crm/utils/constants/colors.dart';
// import 'package:crm/utils/constants/enums.dart';
// import 'package:crm/utils/constants/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:gap/gap.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
//
// String getDateFromDateTimeString(String dateTimeString) {
//   DateTime dateTime = DateTime.parse(dateTimeString);
//   String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
//   return formattedDate;
// }
//
// class BlocsScreen extends StatelessWidget {
//   const BlocsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () => Scaffold.of(context).openDrawer(),
//             icon: const Icon(Icons.menu),
//           ),
//           title: const Text('Bloklar'),
//         ),
//         body: BlocBuilder<GeneralBloc, GeneralState>(
//           builder: (context, state) {
//             if (state.status.isLoading) {
//               return Center(
//                   child: LoadingAnimationWidget.inkDrop(
//                 color: TColors.tPrimaryColor,
//                 size: TSizes.lg,
//               ),);
//             } else if (state.status.isFailure) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       state.error.toString(),
//                       textAlign: TextAlign.center,
//                     ),
//                     const Gap(TSizes.base),
//                     FilledButton(
//                       onPressed: () => context.read<GeneralBloc>().add(GeneralInitialEvent()),
//                       child: const Text('Qayta Urinish'),
//                     ),
//                   ],
//                 ),
//               );
//             }
//             return ListView.separated(
//               padding: const EdgeInsets.all(TSizes.sm),
//               itemCount: state.blocs.length,
//               itemBuilder: (context, index) {
//                 final object = state.blocs[index];
//                 return TRoundedContainer(
//                   padding: const EdgeInsets.all(TSizes.md),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       GestureDetector(
//                           onTap: () {
//                             context.pushNamed(RouteNames.imagePreview,
//                                 arguments: object.objects.image,);
//                           },
//                           child: Card(
//                               child: CachedNetworkImage(
//                                   imageUrl: "$baseUrlForImage/${object.objects.image}",),),),
//                       const Gap(TSizes.base),
//                       Center(
//                         child: Text(object.name,
//                             style: context.titleMedium?.copyWith(
//                                 color: TColors.tPrimaryColor, fontWeight: FontWeight.w600,),),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) => const Gap(TSizes.base),
//             );
//           },
//         ),);
//   }
// }
