import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:tcc/components/menu_item.dart';
import 'package:tcc/screens/about/about_screen.dart';
import 'package:tcc/screens/home/home_screen.dart';
import 'package:tcc/screens/menu/menu_screen.dart';
import 'package:tcc/screens/password/password_screen.dart';
import 'package:tcc/screens/profile/profile_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  MenuItem currentPage = MenuItems.home;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: Builder(
        builder: (context) {
          return MenuScreen(
            currentPage: currentPage,
            onSelectItem: (menuItem) {
              setState(() {
                currentPage = menuItem;
              });

              ZoomDrawer.of(context)?.close();
            },
          );
        },
      ),
      mainScreen: getScreen(),
      menuBackgroundColor:
          Theme.of(context).drawerTheme.backgroundColor ?? Colors.transparent,
      slideWidth: MediaQuery.of(context).size.width * 0.75,
      angle: 0,
      showShadow: true,
      shadowLayer2Color: Colors.white,
      shadowLayer1Color: const Color(0x64FFFFFF),
      mainScreenTapClose: true,
      androidCloseOnBackTap: true,
      menuScreenWidth: MediaQuery.of(context).size.width * 0.75,
      style: DrawerStyle.defaultStyle,
      isRtl: false,
    );
  }

  Widget getScreen() {
    Map<MenuItem, Widget> screens = {
      MenuItems.profile: const ProfileScreen(),
      MenuItems.security: const PasswordScreen(),
      MenuItems.about: const AboutScreen(),
    };

    return screens[currentPage] ?? HomeScreen();
  }
}
