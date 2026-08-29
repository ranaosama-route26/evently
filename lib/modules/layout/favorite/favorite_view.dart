import 'package:event_app_c17_mon_7pm/core/gen/assets.gen.dart';
import 'package:event_app_c17_mon_7pm/core/utils/firebase_utils.dart';
import 'package:event_app_c17_mon_7pm/core/widgets/custom_text_form_filed.dart';
import 'package:event_app_c17_mon_7pm/model/event_data_model.dart';
import 'package:flutter/material.dart';

import '../home/widgets/event_card_item.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CustomTextFormFiled(
              hintText: "Search for event",
              suffixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Assets.icons.searchIcn.svg(),
              ),
            ),
          ),
          SizedBox(height: 16),
          StreamBuilder(
            stream: FirebaseUtils.getStreamFavoriteDataForFirestore(),
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
        ],
      ),
    );
  }
}
