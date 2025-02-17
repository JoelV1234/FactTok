import 'package:biblereels/collections/dialogs/create_colleciton_dialog.dart';
import 'package:biblereels/facts/fact.dart';
import 'package:biblereels/facts/facts_repo.dart';
import 'package:biblereels/widgets/future_widget.dart';
import 'package:biblereels/reel/reel_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllFactsScreen extends StatefulWidget {
  const AllFactsScreen({super.key});

  @override
  State<AllFactsScreen> createState() => _AllFactsScreenState();
}

class _AllFactsScreenState extends State<AllFactsScreen> {

  late Future<List<Fact>> facts;
  Fact? selectedFact;
  
  @override
  void initState() {
    super.initState();
    facts = Provider.of<FactsRepo>(context, listen: false).getAllReels();
  }

  @override
  Widget build(BuildContext context) {
    return FutureWidget(
      loading: const Center(
        child: CircularProgressIndicator(),
      ),
      future: facts,
      onComplete: (facts) => Stack(
        children: [
          ReelScreen(
            facts: facts,
            onNewFact: (fact, index) =>
              setState(() => selectedFact = fact)
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
              child: IconButton(
                icon: const Icon(
                  size: 40,
                  Icons.bookmark_outline,
                  color: Colors.white,
                ),
                onPressed: () => showCreateCollectionDialog(
                  context, selectedFact ?? facts.first),
              ),
            ),
          ),
        ],
      ),
    );
  }
}