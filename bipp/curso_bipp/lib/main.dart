import 'package:curso_bipp/providers/cursos.dart';
import 'package:curso_bipp/screens/curso_detalhe_screen.dart';
import 'package:curso_bipp/screens/curso_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Cursos(),
        ),
      ],
      child: MaterialApp(
        title: 'Cursos',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              ),
        ),
        home: CursoScreen(),
        routes: {
          CursoDetalheScreen.routeName: (context) => CursoDetalheScreen(),
          // MealDetailScreen.routeName: (context) => MealDetailScreen(_toogleFavorite,isMealFav),
          // FiltersScreen.routeName: (context) =>
          //     FiltersScreen(_filters, _setFilters),
        },
      ),
    );
  }
}
