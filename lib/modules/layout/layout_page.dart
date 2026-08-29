import 'package:event_app_c17_mon_7pm/core/routes/pages_route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:event_app_c17_mon_7pm/core/gen/assets.gen.dart';
import 'package:event_app_c17_mon_7pm/modules/app_settings_provider/app_settings_provider.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppSettingsProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PagesRouteName.addEvent);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(64)),
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: provider.pages[provider.currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: provider.currentIndex,
          onTap: provider.changeCurrentIndex,
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Assets.icons.homeIcn.svg(),
              activeIcon: Assets.icons.activeHomeIcn.svg(),
            ),
            BottomNavigationBarItem(
              label: "Favorite",
              icon: Assets.icons.favoriteIcn.svg(),
              activeIcon: Assets.icons.activeHeartIcn.svg(),
            ),
            BottomNavigationBarItem(
              label: "profile",
              icon: Assets.icons.userIcn.svg(),
              activeIcon: Assets.icons.activeUserIcn.svg(),
            ),
          ],
        ),
      ),
    );
  }
}
