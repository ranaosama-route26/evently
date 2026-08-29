import 'package:event_app_c17_mon_7pm/model/event_category_data.dart';
import 'package:event_app_c17_mon_7pm/modules/app_settings_provider/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/theme/color_pallete.dart';

class EventCategoryItem extends StatelessWidget {
  final bool isSelected;
  final EventCategoryData eventCategoryData;

  const EventCategoryItem({
    super.key,
    required this.isSelected,
    required this.eventCategoryData,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppSettingsProvider>(context);
    final theme = Theme.of(context);
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color:
            isSelected
                ? theme.primaryColor
                : provider.isDark()
                ? ColorPallete.scaffoldDarkBackgroundColor
                : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              provider.isDark()
                  ? ColorPallete.strokeDarkBorder
                  : ColorPallete.strokeBorder,
        ),
      ),
      child: Row(
        spacing: 8,
        children: [
          Icon(
            eventCategoryData.icon,
            color: isSelected ? Colors.white : theme.primaryColor,
          ),
          Text(
            eventCategoryData.title,
            style: theme.textTheme.bodyLarge?.copyWith(
              color:
                  isSelected
                      ? Colors.white
                      : provider.isDark()
                      ? Colors.white
                      : ColorPallete.mainTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
