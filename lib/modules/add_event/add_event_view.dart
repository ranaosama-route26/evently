import 'package:event_app_c17_mon_7pm/core/gen/assets.gen.dart';
import 'package:event_app_c17_mon_7pm/core/theme/color_pallete.dart';
import 'package:event_app_c17_mon_7pm/core/utils/firebase_utils.dart';
import 'package:event_app_c17_mon_7pm/core/widgets/custom_elevated_button.dart';
import 'package:event_app_c17_mon_7pm/core/widgets/custom_text_form_filed.dart';
import 'package:event_app_c17_mon_7pm/model/event_category_data.dart';
import 'package:event_app_c17_mon_7pm/model/event_data_model.dart';
import 'package:event_app_c17_mon_7pm/modules/app_settings_provider/app_settings_provider.dart';
import 'package:event_app_c17_mon_7pm/modules/layout/home/widgets/event_category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class AddEventView extends StatefulWidget {
  const AddEventView({super.key});

  @override
  State<AddEventView> createState() => _AddEventViewState();
}

class _AddEventViewState extends State<AddEventView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime? selectedDate;

  final categoriesDataList = [
    EventCategoryData(
      id: "sport",
      title: "Sport",
      image: Assets.images.sportImg.path,
      imageDark: Assets.images.sportDarkImg.path,
      icon: Icons.sports_soccer_outlined,
    ),
    EventCategoryData(
      id: "birthday",
      title: "Birthday",
      image: Assets.images.birthdayImg.path,
      imageDark: Assets.images.birthdayDarkImg.path,
      icon: Icons.cake_outlined,
    ),
    EventCategoryData(
      id: "book_club",
      title: "BookClub",
      image: Assets.images.bookClubImg.path,
      imageDark: Assets.images.bookClubDarkImg.path,
      icon: Icons.menu_book_rounded,
    ),
    EventCategoryData(
      id: "meeting",
      title: "Meeting",
      image: Assets.images.meetingImg.path,
      imageDark: Assets.images.meetingDarkImg.path,
      icon: Icons.meeting_room_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = Provider.of<AppSettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Event"),
        leading: Bounceable(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ColorPallete.strokeBorder),
            ),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: theme.primaryColor,
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 196,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorPallete.strokeBorder),
                image: DecorationImage(
                  image: AssetImage(
                    provider.isDark()
                        ? categoriesDataList[provider.currentCategoryIndex]
                            .imageDark
                        : categoriesDataList[provider.currentCategoryIndex]
                            .image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            DefaultTabController(
              length: categoriesDataList.length,
              child: TabBar(
                physics: ClampingScrollPhysics(),
                onTap: provider.changeCurrentCategoryIndex,
                isScrollable: true,
                padding: EdgeInsets.symmetric(horizontal: 16),
                labelPadding: EdgeInsets.symmetric(horizontal: 4),
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(),
                tabs:
                    categoriesDataList.map((data) {
                      // print(provider.currentCategoryIndex);
                      return EventCategoryItem(
                        isSelected:
                            provider.currentCategoryIndex ==
                            categoriesDataList.indexOf(data),
                        eventCategoryData: data,
                      );
                    }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    "Title",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextFormFiled(
                    controller: _titleController,
                    hintText: "Enter Event Title",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Title is required";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    "Description ",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextFormFiled(
                    controller: _descriptionController,
                    hintText: "Event Description....",
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Description is required";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                spacing: 8,
                children: [
                  Assets.icons.calendarIcn.svg(),
                  Expanded(
                    child: Text(
                      "Event Date",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Bounceable(
                    onTap: () {
                      getSelectedDate();
                    },
                    child: Text(
                      selectedDate == null
                          ? "Choose date"
                          : DateFormat("dd MMM yyy").format(selectedDate!),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomElevatedButton(
                buttonText: "Add event",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (selectedDate == null) {
                      toastification.show(
                        alignment: AlignmentGeometry.bottomCenter,
                        type: ToastificationType.error,
                        title: Text('you must select date time'),
                        autoCloseDuration: const Duration(seconds: 5),
                      );
                      return;
                    }

                    var data = EventDataModel(
                      eventTitle: _titleController.text,
                      eventDescription: _descriptionController.text,
                      eventDate: selectedDate!,
                      categoryImage:
                          categoriesDataList[provider.currentCategoryIndex]
                              .image,
                      categoryId:
                          categoriesDataList[provider.currentCategoryIndex].id,
                    );

                    /// Show Loading
                    /// create event || send to firebase
                    /// Hide Loading
                    /// show toast

                    EasyLoading.show();
                    Future.delayed(Duration(milliseconds: 500), () {
                      FirebaseUtils.addEvent(data).then((value) {
                        EasyLoading.dismiss();
                        if (value) {
                          /// Toast Message [Event Created Successfully]
                          toastification.show(
                            type: ToastificationType.success,
                            title: Text('Event Created Successfully'),
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                          Navigator.pop(context);
                        } else {
                          /// Toast Message [Something went wrong]
                          toastification.show(
                            type: ToastificationType.error,
                            title: Text('Something went wrong'),
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                        }
                      });
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getSelectedDate() async {
    var currentDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (currentDate != null) {
      selectedDate = currentDate;
      setState(() {});
    }
  }
}
