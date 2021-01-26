import 'package:auto_size_text/auto_size_text.dart';
import 'package:fiboeda/constants.dart';
import 'package:fiboeda/models/cart.dart';
import 'package:fiboeda/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:provider/provider.dart';

class FiboDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _drawerHeader(context),
          ListTile(
            leading: Icon(
              Icons.storefront_outlined,
              color: Theme.of(context).primaryColor,
            ),
            minLeadingWidth: 20.0,
            title: Text(
              'Фибо Меню',
              style: Theme.of(context).textTheme.subtitle1,
              maxLines: 1,
            ),
            dense: true,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_bag_outlined,
              color: Theme.of(context).primaryColor,
            ),
            minLeadingWidth: 20.0,
            title: Text(
              'Мой заказ',
              style: Theme.of(context).textTheme.subtitle1,
              maxLines: 1,
            ),
            trailing: Consumer<CartModel>(builder: (context, cart, child) {
              return cart.totalItems > 0
                  ? Text(
                      '${cart.totalPrice}₽',
                      style: Theme.of(context).textTheme.headline6,
                    )
                  : Text('');
            }),
            dense: true,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/cart');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.verified_user_outlined,
              color: Theme.of(context).primaryColor,
            ),
            minLeadingWidth: 20.0,
            title: Text(
              'Бронь столиков',
              style: Theme.of(context).textTheme.subtitle1,
              maxLines: 1,
            ),
            dense: true,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/order');
            },
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Информация',
              maxLines: 1,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.grey[400],
                  ),
            ),
          ),
          ListTile(
            title: Text(
              'Про Фибоначчи',
              style: Theme.of(context).textTheme.subtitle1,
              maxLines: 1,
            ),
            dense: true,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about');
            },
          ),
          ListTile(
            title: Text(
              'Доставка и оплата',
              style: Theme.of(context).textTheme.subtitle1,
              maxLines: 1,
            ),
            dense: true,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/delivery');
            },
          ),
          ListTile(
            title: Text(
              'Политика конфиденциальности',
              style: Theme.of(context).textTheme.subtitle1,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
            dense: true,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/privacy');
            },
          ),
          ListTile(
            title: Text(
              'О приложении',
              style: Theme.of(context).textTheme.subtitle1,
              maxLines: 1,
            ),
            dense: true,
            onTap: () {
              showAboutDialog(
                  context: context,
                  applicationIcon: Image.asset(
                    'assets/logo_vertical.png',
                    width: 60.0,
                  ),
                  applicationName: kAppTitle,
                  applicationVersion: kAppVersion,
                  applicationLegalese: kAppLegal,
                  children: [
                    SizedBox(height: 16.0),
                    Text(
                      kAppAdditionalInfo,
                      style: Theme.of(context).textTheme.caption,
                    )
                  ]);
            },
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Контакты',
              maxLines: 1,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.grey[400],
                  ),
            ),
          ),
          ..._itemsBuilder(context, socialItems),
        ],
      ),
    );
  }
}

Widget _drawerHeader(BuildContext context) {
  return DrawerHeader(
    padding: EdgeInsets.symmetric(vertical: 20.0),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Image.asset(
            'assets/logo_vertical.png',
            fit: BoxFit.contain,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    'Фибоначчи',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.white),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  AutoSizeText(
                    'кухня • бар',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.white),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

List<Widget> _itemsBuilder(BuildContext context, List<_FiboDrawerItem> items) {
  List<Widget> result = [];
  result = items.map((item) => _itemBuilder(context, item)).toList();
  return result;
}

Widget _itemBuilder(BuildContext context, _FiboDrawerItem item) {
  return ListTile(
    leading: Icon(
      item.icon,
      color: Theme.of(context).primaryColor,
    ),
    minLeadingWidth: 20.0,
    title: Text(
      item.title,
      style: Theme.of(context).textTheme.subtitle1,
      maxLines: 1,
    ),
    dense: true,
    onTap: () async {
      Navigator.pop(context);
      if (item.url.startsWith('http')) {
        await launchURL(item.url);
      } else {
        Navigator.pushNamed(context, item.url);
      }
    },
  );
}

class _FiboDrawerItem {
  const _FiboDrawerItem({this.icon, this.title, this.url, this.badge});
  final IconData icon;
  final String title;
  final String url;
  final Widget badge;
}

List<_FiboDrawerItem> socialItems = [
  _FiboDrawerItem(
    title: 'Instagram',
    icon: BrandIcons.instagram,
    url: 'https://www.instagram.com/fibonacci_rest/',
  ),
  _FiboDrawerItem(
    title: 'fiboeda.ru',
    icon: Icons.smartphone,
    url: 'https://fiboeda.ru/',
  ),
];
