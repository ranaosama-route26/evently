import 'package:event_app_c17_mon_7pm/core/gen/assets.gen.dart';
import 'package:event_app_c17_mon_7pm/core/theme/color_pallete.dart';
import 'package:event_app_c17_mon_7pm/core/utils/firebase_utils.dart';
import 'package:event_app_c17_mon_7pm/model/event_category_data.dart';
import 'package:event_app_c17_mon_7pm/model/event_data_model.dart';
import 'package:event_app_c17_mon_7pm/modules/app_settings_provider/app_settings_provider.dart';
import 'package:event_app_c17_mon_7pm/modules/layout/home/widgets/event_card_item.dart';
import 'package:event_app_c17_mon_7pm/modules/layout/home/widgets/event_category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final categoriesDataList = [
    EventCategoryData(
      id: "sport",
      title: "Sport",
      image: "",
      imageDark: "",
      icon: Icons.sports_soccer_outlined,
    ),
    EventCategoryData(
      id: "birthday",
      title: "Birthday",
      image: "",
      imageDark: "",
      icon: Icons.cake_outlined,
    ),
    EventCategoryData(
      id: "book_club",
      title: "BookClub",
      image: "",
      imageDark: "",
      icon: Icons.menu_book_rounded,
    ),
    EventCategoryData(
      id: "meeting",
      title: "Meeting",
      image: "",
      imageDark: "",
      icon: Icons.meeting_room_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = Provider.of<AppSettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 8,
          children: [
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back ✨",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Hossam Bakry",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Bounceable(
              onTap: () {
                provider.changeTheme(
                  provider.isDark() ? ThemeMode.light : ThemeMode.dark,
                );
              },
              child:
                  provider.isDark()
                      ? Assets.icons.moonIcn.svg(
                        colorFilter: ColorFilter.mode(
                          theme.primaryColor,
                          BlendMode.srcIn,
                        ),
                      )
                      : Assets.icons.sunOutlineIcn.svg(),
            ),
            Bounceable(
              onTap: () {
                provider.changeLanguage(
                  provider.currentLanguage == "en" ? "ar" : "en",
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5.5),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  provider.currentTextLanguage,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 24),
          DefaultTabController(
            length: categoriesDataList.length,
            child: TabBar(
              physics: ClampingScrollPhysics(),
              onTap: provider.changeCurrentCategoryIndex,
              isScrollable: true,
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.symmetric(horizontal: 8),
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
          SizedBox(height: 24),
          StreamBuilder(
            stream: FirebaseUtils.getStreamDataForFirestore(
              categoriesDataList[provider.currentCategoryIndex].id,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              List<EventDataModel> dataList =
                  snapshot.data?.docs.map((element) {
                    return element.data();
                  }).toList() ??
                  [];

              return dataList.isEmpty
                  ? Center(child: Text("No Data"))
                  : Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        return EventCardItem(dataModel: dataList[index]);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 16);
                      },
                      itemCount: dataList.length,
                    ),
                  );
            },
          ),
          /*  FutureBuilder(
            future: FirebaseUtils.getDataForFirestore(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              List<EventDataModel> dataList = snapshot.data ?? [];

              return Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return EventCardItem(dataModel: dataList[index]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16);
                  },
                  itemCount: dataList.length,
                ),
              );
            },
          ),*/
        ],
      ),
    );
  }
}
