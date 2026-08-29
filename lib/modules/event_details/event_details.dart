import 'package:event_app_c17_mon_7pm/core/routes/pages_route_name.dart';
import 'package:event_app_c17_mon_7pm/core/theme/color_pallete.dart';
import 'package:event_app_c17_mon_7pm/model/event_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

import '../../core/utils/firebase_utils.dart';

class EventDetailsScreen extends StatelessWidget {
  EventDetailsScreen({super.key, required this.eventDataModel});
  final EventDataModel eventDataModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: ColorPallete.borderColor, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        title: Text(
          "Event Details",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ColorPallete.mainTextColor,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(
                context,
              ).pushNamed(PagesRouteName.editEvent, arguments: eventDataModel);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorPallete.borderColor, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset('assets/images/edit-2.svg'),
            ),
          ),
          SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              EasyLoading.show();

              FirebaseUtils.deleteEvent(eventDataModel.eventID).then((value) {
                EasyLoading.dismiss();

                if (value) {
                  toastification.show(
                    type: ToastificationType.success,
                    title: Text("Event Deleted Successfully"),
                  );
                  Navigator.pop(context);
                } else {
                  toastification.show(
                    type: ToastificationType.error,
                    title: Text("Something went wrong"),
                  );
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorPallete.borderColor, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset('assets/images/trash.svg'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(eventDataModel.categoryImage),
                ),
              ),
            ),
            Text(
              eventDataModel.eventTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorPallete.mainTextColor,
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                border: Border.all(color: ColorPallete.borderColor),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ColorPallete.borderColor),
                    ),
                    child: SvgPicture.asset("assets/images/calendar-add.svg"),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat("dd MMM").format(eventDataModel.eventDate),
                        style: TextStyle(color: ColorPallete.mainTextColor),
                      ),
                      SizedBox(height: 4),
                      Text(
                        DateFormat("h:mm a").format(eventDataModel.eventDate),
                        style: TextStyle(
                          color: ColorPallete.secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorPallete.mainTextColor,
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                border: Border.all(color: ColorPallete.borderColor),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  eventDataModel.eventDescription,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorPallete.mainTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
