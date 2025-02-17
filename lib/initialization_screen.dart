import 'package:biblereels/collections/api/collection_api.dart';
import 'package:biblereels/widgets/future_widget.dart';
import 'package:biblereels/home_screen.dart';
import 'package:biblereels/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class InitializationScreen extends StatefulWidget {
  const InitializationScreen({super.key});

  @override
  State<InitializationScreen> createState() => _InitializationScreenState();
}

class _InitializationScreenState extends State<InitializationScreen> {
  late Future<void> initCollApi;

  @override
  void initState() {
    initCollApi = context.read<CollectionApi>().initalize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureWidget(
        future: initCollApi,
        loading: LoadingScreen(),
        onComplete: (facts) => HomeScreen()
      ),
    );
  }
}