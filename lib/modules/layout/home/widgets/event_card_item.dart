import 'package:event_app_c17_mon_7pm/core/gen/assets.gen.dart';
import 'package:event_app_c17_mon_7pm/core/routes/pages_route_name.dart';
import 'package:event_app_c17_mon_7pm/core/theme/color_pallete.dart';
import 'package:event_app_c17_mon_7pm/core/utils/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';

import '../../../../model/event_data_model.dart' show EventDataModel;

class EventCardItem extends StatelessWidget {
  final EventDataModel dataModel;

  const EventCardItem({super.key, required this.dataModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).pushNamed(PagesRouteName.eventDetails, arguments: dataModel);
      },
      child: Container(
        height: 195,
        width: double.infinity,

        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorPallete.strokeBorder),
          image: DecorationImage(
            image: AssetImage(dataModel.categoryImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFFF4F7FF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorPallete.strokeBorder),
              ),
              child: Text(
                DateFormat("dd MMM").format(dataModel.eventDate),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFFF4F7FF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorPallete.strokeBorder),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      dataModel.eventTitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: ColorPallete.mainTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Bounceable(
                    onTap: () {
                      dataModel.isFavorite = !dataModel.isFavorite;

                      FirebaseUtils.updateEvent(dataModel);
                    },
                    child:
                        dataModel.isFavorite
                            ? Assets.icons.activeHeartIcn.svg()
                            : Assets.icons.favoriteIcn.svg(
                              colorFilter: ColorFilter.mode(
                                theme.primaryColor,
                                BlendMode.srcIn,
                              ),
                            ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
