import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:tcc/components/menu_item.dart';
import 'package:tcc/screens/app_drawer/logout_button.dart';

class MenuItems {
  static const MenuItem home = MenuItem('Início', Icons.home_outlined);
  static const MenuItem profile = MenuItem('Perfil', Icons.person_outlined);
  static const MenuItem security = MenuItem('Segurança', Icons.lock_outline);
  static const MenuItem about = MenuItem('Sobre', Icons.info_outline);

  static List<MenuItem> getAll() {
    return <MenuItem>[
      home,
      profile,
      security,
      about,
    ];
  }
}

class MenuScreen extends StatelessWidget {
  final MenuItem currentPage;
  final ValueChanged<MenuItem> onSelectItem;

  const MenuScreen({
    Key? key,
    required this.currentPage,
    required this.onSelectItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => ZoomDrawer.of(context)?.close(),
          color: Theme.of(context).textTheme.bodyMedium?.color ??
              Colors.transparent,
        ),
      ),
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Spacer(
              flex: 2,
            ),
            ...MenuItems.getAll().map(buildMenuItem),
            const SizedBox(height: 100),
            const LogoutButton(),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
      primary: false,
    );
  }

  Widget buildMenuItem(MenuItem item) {
    return ListTile(
      selected: item == currentPage,
      minLeadingWidth: 20,
      leading: Icon(item.icon),
      title: Text(item.title),
      onTap: () => onSelectItem(item),
    );
  }
}
