import 'package:biblereels/collections/models/update_collection_model.dart';
import 'package:biblereels/collections/models/collection.dart';
import 'package:biblereels/widgets/rect_button.dart';
import 'package:biblereels/collections/widgets/collection_check.dart';
import 'package:biblereels/facts/fact.dart';
import 'package:biblereels/facts/facts_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CreateCollecitonDialog extends StatefulWidget {
  final Fact fact;
  const CreateCollecitonDialog({super.key, required this.fact});

  @override
  State<CreateCollecitonDialog> createState() => _CreateCollecitonDialogState();
}

class _CreateCollecitonDialogState extends State<CreateCollecitonDialog> {
  
  String groupName = '';
  late UpdateCollectionModel updateCollectionModel;

  @override
  void initState() {
    updateCollectionModel = UpdateCollectionModel(
      widget.fact,
      context.read<FactsRepo>()
    );
    super.initState();
  }


  void onChecked(bool value, Collection collection) =>
    setState(() => updateCollectionModel.update(value, collection));

  void submit() async {
    await updateCollectionModel.save(groupName);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    List<Collection> collections = updateCollectionModel.collections;
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),  
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView(
                shrinkWrap: true,
                children: collections.map<Widget>(
                  (collection) => CollectionCheck(
                    onTap: onChecked,
                    isSelected: updateCollectionModel.hasFact(collection),
                    collection: collection,
                  )).toList(),
                ),
              )]+ <Widget>[
                TextField(
                  style: const TextStyle(color: Colors.black),
                  onChanged: (value) => groupName = value,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'New collection name',
                  ),
                ),
                SizedBox(height: 10),
                RectButton(
                  text: 'Save',
                  onTap: submit
                )
              ],
            ),
          ),
        ),
      );
  }
}

Future<void> showCreateCollectionDialog(
  BuildContext context, Fact fact) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return CreateCollecitonDialog(
        fact: fact,
      );
    },
  );
}