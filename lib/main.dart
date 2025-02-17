import 'package:biblereels/collections/api/collection_api.dart';
import 'package:biblereels/facts/facts_api.dart';
import 'package:biblereels/facts/facts_repo.dart';
import 'package:biblereels/initialization_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(const App());
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => FactsApi()),
        Provider(create: (context) => CollectionApi()),
        ChangeNotifierProvider(create: (context) => FactsRepo(  
          factsApi: context.read(), 
          collectionApi: context.read(),
        )),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bible Reels',
        theme: ThemeData(
          textTheme: GoogleFonts.mulishTextTheme(
            Theme.of(context).textTheme
          ).apply(
            bodyColor: Colors.white
          ),
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
        ),
        routes: {
          '/' : (context) => InitializationScreen(),
          
        },
      ),
    );
  }
}