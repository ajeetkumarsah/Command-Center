import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_gp_controller.dart';

class GPDeepDiveScreen extends StatelessWidget {
  const GPDeepDiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreGPController>(
      init: StoreGPController(storeGPRepo: Get.find()),
      builder: (ctlr) {
        return !ctlr.isLoading && ctlr.storeGPTrendsModel != null
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    // Container(
                    //   padding: const EdgeInsets.all(10.0),
                    //   decoration: BoxDecoration(
                    //     borderRadius: const BorderRadius.only(
                    //       bottomLeft: Radius.circular(30.0),
                    //       bottomRight: Radius.circular(30.0),
                    //     ),
                    //     color: Colors.white,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         offset: const Offset(0, 4),
                    //         blurRadius: 15,
                    //         color: AppColors.black.withOpacity(.25),
                    //       ),
                    //     ],
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       Image.asset("assets/png/Group 35.png", height: 31),
                    //       const SizedBox(height: 15),
                    //       Image.asset("assets/png/Rectangle 426.png"),
                    //       const SizedBox(height: 15),
                    //       Text(
                    //         ctlr.getStore(),
                    //         maxLines: 2,
                    //         overflow: TextOverflow.ellipsis,
                    //         style: GoogleFonts.inter(
                    //           color: const Color(0xff0B4983),
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   margin:
                    //       const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(5.0),
                    //   color: Colors.white,
                    //   boxShadow: [
                    //     BoxShadow(
                    //       offset: const Offset(0, 4),
                    //       blurRadius: 15,
                    //       color: AppColors.black.withOpacity(.25),
                    //     ),
                    //   ],
                    // ),
                    //   child:
                    //   GridView.builder(
                    //     itemCount: 2,
                    //     shrinkWrap: true,
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     itemBuilder: (context, index) => Column(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           index == 0 ? 'SRN%' : 'Scheme Earning',
                    //           style: GoogleFonts.inter(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w500,
                    //             color: AppColors.storeTextColor,
                    //           ),
                    //         ),
                    //         const SizedBox(height: 8),
                    //         InnerShadow(
                    //           blur: 4,
                    //           offset: const Offset(4, 4),
                    //           color: AppColors.black.withOpacity(.25),
                    //           child: Container(
                    //             height: 30,
                    //             width: 160,
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(100),
                    //               color: const Color(0xff7CA0DF),
                    //               // boxShadow: [
                    //               //   BoxShadow(
                    //               //     offset: const Offset(4, 4),
                    //               //     blurRadius: 4,
                    //               //     spreadRadius: -4,
                    //               //     color: AppColors.black.withOpacity(.25),
                    //               //   ),
                    //               // ],
                    //             ),
                    //             child: Center(
                    //               child: Text(
                    //                 index == 0
                    //                     ? '${ctlr.getFBTarget()}%'
                    //                     : '${ctlr.getFBAchieved()}%',
                    //                 style: GoogleFonts.inter(
                    //                   color: AppColors.white,
                    //                   fontSize: 18,
                    //                   fontWeight: FontWeight.w600,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //       crossAxisCount: 2,
                    //       childAspectRatio: 1.8,
                    //     ),
                    //   ),
                    // ),

                    Container(
                      margin: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 15,
                            color: AppColors.black.withOpacity(.25),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 12, top: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                ctlr.storeGPBaseModel?.dgpCompliance
                                        ?.gpTarget ??
                                    '',
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              subtitle: Text(
                                'GP Target',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.greyTextColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    width: 1,
                                    color: AppColors.greyTextColor,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                title: Text(
                                  ctlr.storeGPBaseModel?.dgpCompliance?.gpP1M ??
                                      '',
                                  style: GoogleFonts.inter(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                subtitle: Text(
                                  'P1M GP',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.greyTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    width: 1,
                                    color: AppColors.greyTextColor,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                title: Text(
                                  ctlr.storeGPBaseModel?.dgpCompliance?.gpP3M ??
                                      '',
                                  style: GoogleFonts.inter(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                subtitle: Text(
                                  'P3M GP',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.greyTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // height: 400,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 15,
                            color: AppColors.black.withOpacity(.25),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 12, top: 4),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Sales Value Trends',
                                  style: GoogleFonts.inter(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.lightGrey,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                    left: 1, top: 1, bottom: 1),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                  child: Container(
                                    // width: 120,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 6),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5)),
                                      color: AppColors.white,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.filter_alt_outlined,
                                          color: AppColors.primary,
                                          size: 18,
                                        ),
                                        Text(
                                          'Category',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 12),
                              Text(
                                'in thousands',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2.0, vertical: 12),
                            child: Row(
                              children: [
                                const SizedBox(width: 12),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: AppColors.borderColor),
                                  height: 10,
                                  width: 10,
                                  margin: const EdgeInsets.only(right: 8),
                                ),
                                Flexible(
                                  child: Text(
                                    'Target',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.greyTextColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: AppColors.sfPrimary),
                                  height: 10,
                                  width: 10,
                                  margin: const EdgeInsets.only(
                                    right: 8,
                                    left: 16,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    'Achieved',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.greyTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ...ctlr.storeGPTrendsModel!.data
                              .map(
                                (trend) => Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width * .54,
                                    animation: true,

                                    animationDuration: 1000,
                                    lineHeight: 8.0,
                                    barRadius: const Radius.circular(10),
                                    // backgroundColor:
                                    //     const Color.fromARGB(255, 2, 74, 133),
                                    leading: Text("${trend.monthYear}"),
                                    trailing: Text(
                                        "${trend.goldenPointsGapFilledP3M}/${trend.goldenPointsTarget}"),
                                    percent: double.tryParse(
                                            trend.barPer ?? '0.0') ??
                                        0.0,
                                    // ignore: deprecated_member_use
                                    linearStrokeCap: LinearStrokeCap.butt,
                                    progressColor: AppColors.sfPrimary,
                                    backgroundColor: AppColors.bgLight,
                                  ),
                                ),
                              )
                              .toList()
                        ],
                      ),
                    ),

                    Container(
                      // height: 400,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 15,
                            color: AppColors.black.withOpacity(.25),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 12, top: 4),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Salioence / GP Ach.',
                                  style: GoogleFonts.inter(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.arrow_forward_ios_outlined))
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 12),
                              Text(
                                'in thousands',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 12, 4, 12),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Sub Brand Form',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.greyTextColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'P1M',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.greyTextColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'P3M',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.greyTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ...ctlr.storeGPCategoryModel
                              .map(
                                (category) => Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12.0, 3, 4, 3),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          category.categoryName ?? '',
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.greyTextColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: category.gpP1M ?? '',
                                                style: GoogleFonts.inter(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.greyTextColor,
                                                ),
                                              ),
                                              WidgetSpan(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Icon(
                                                    category.targetAchievedP1M ??
                                                            false
                                                        ? Icons.check
                                                        : Icons.close,
                                                    color:
                                                        category.targetAchievedP1M ??
                                                                false
                                                            ? AppColors.green
                                                            : AppColors.red,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: category.gpP1M ?? '',
                                                style: GoogleFonts.inter(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.greyTextColor,
                                                ),
                                              ),
                                              WidgetSpan(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Icon(
                                                    category.targetAchievedP3M ??
                                                            false
                                                        ? Icons.check
                                                        : Icons.close,
                                                    color:
                                                        category.targetAchievedP3M ??
                                                                false
                                                            ? AppColors.green
                                                            : AppColors.red,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 12),

                    const SizedBox(height: 20),
                  ],
                ),
              )
            : const Center(
                child: CustomLoader(),
              );
      },
    );
  }
}

class GPDummyData {
  final String? name;
  final bool? p3mAch;
  final String? p3mSal;
  final bool? p1mAch;
  final String? p1mSal;

  GPDummyData({this.name, this.p3mAch, this.p3mSal, this.p1mAch, this.p1mSal});
}
