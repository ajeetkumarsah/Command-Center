import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_slider/reviews_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String selected_valueoftxt = "";
  List<String> list = ['Terrible', 'Bad', 'Okay', 'Good', 'Great'];
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      builder: (ctlr) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.black,
                size: 18,
              ),
            ),
            title: Text(
              'Feedback',
              style: GoogleFonts.ptSansCaption(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Lottie.asset(
                  'assets/json/feedback.json',
                  width: MediaQuery.of(context).size.width * .7,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Share Your Feedback',
                    style: GoogleFonts.ptSansCaption(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
                  child: Text(
                    'Please select a topic below and let us know about your concern',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ptSansCaption(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ReviewSlider(
                    initialValue: 3,
                    options: list,
                    onChange: (int value) {
                      selected_valueoftxt = list[value];
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: controller,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Comments',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: .5, color: AppColors.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: .5, color: AppColors.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: .5, color: AppColors.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (controller.text.isNotEmpty &&
                        selected_valueoftxt != '') {
                      isLoading = true;
                      SharedPreferences session =
                          await SharedPreferences.getInstance();
                      await ctlr.postFeedbackReport(
                          userName: '${session.getString(AppConstants.NAME)}',
                          rating: selected_valueoftxt,
                          feedback: controller.text);
                      isLoading = false;
                      Get.back();
                    } else {
                      isLoading = true;
                      Fluttertoast.showToast(
                          msg: "Something went wrong",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 10,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      isLoading = false;
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primary,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                        : Center(
                            child: Text(
                              'Submit',
                              style: GoogleFonts.ptSansCaption(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
