import 'package:fiboeda/constants.dart';
import 'package:fiboeda/models/cart.dart';
import 'package:fiboeda/models/catalog.dart';
import 'package:fiboeda/pages/about.dart';
import 'package:fiboeda/pages/cart.dart';
import 'package:fiboeda/pages/index.dart';
import 'package:fiboeda/pages/not_found.dart';
import 'package:fiboeda/pages/order.dart';
import 'package:fiboeda/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Observe Cart
        ChangeNotifierProvider(create: (context) => CartModel()),
        // Observe Catalog
        Provider(create: (context) => CatalogModel()),
      ],
      builder: (context, child) {
        return FutureBuilder(
            // Fill catalog data once on launch
            future: Provider.of<CatalogModel>(context).init(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return MaterialApp(
                  title: kAppTitle,
                  theme: fiboTheme,
                  // Basic routing
                  initialRoute: IndexPage.route,
                  routes: <String, WidgetBuilder>{
                    IndexPage.route: (context) => IndexPage(),
                    AboutPage.route: (context) => AboutPage(),
                    OrderPage.route: (context) => OrderPage(),
                    CartPage.route: (context) => CartPage(),
                  },
                  // Unknown page handler
                  onUnknownRoute: (RouteSettings settings) {
                    return MaterialPageRoute<void>(
                      settings: settings,
                      builder: (context) => NotFoundPage(),
                    );
                  },
                  // Localization
                  localizationsDelegates: GlobalMaterialLocalizations.delegates,
                  supportedLocales: [
                    Locale('ru'),
                  ],
                  locale: Locale('ru'),
                );
              }
              return Container(color: Colors.black);
            });
      },
    );
  }
}
