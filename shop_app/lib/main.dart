import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/order.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/splash_screen.dart';
import 'package:shop_app/screens/usr_products_screen.dart';
import 'providers/auth.dart';
import 'screens/product_overview_screen.dart';
import 'screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/edit_product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousData) => Products(auth.token,
              previousData == null ? [] : previousData.items, auth.userID),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousData) => Orders(auth.token,
              previousData == null ? [] : previousData.orders, auth.userID),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          title: 'Myshop',
          theme: ThemeData(
            primarySwatch: Colors.lightBlue,
            accentColor: Colors.amber,
            fontFamily: 'Lato',
          ),
          // home: ProductsOverviewScreen(),
          home: authData.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: authData.tryAutoLog(),
                  builder: (ctx, authResultSnap) =>
                      authResultSnap.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthCard(),
                ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrderScreen.routeName: (ctx) => OrderScreen(),
            UsrProductsScreen.routeName: (ctx) => UsrProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
