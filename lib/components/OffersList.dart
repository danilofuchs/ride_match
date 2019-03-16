import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/CommonTimes.dart';

class ListItemData {
  DateTime time;

  ListItemData(this.time);
}

class OffersList extends StatefulWidget {
  var _ListItems = CommonTimes.map((time) => new ListItemData(time)).toList();

  @override
  State createState() => new _OffersListState(ListItems: _ListItems);
}

class _OffersListState extends State<OffersList> {
  _OffersListState({this.ListItems});

  List<ListItemData> ListItems;

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
        body: new ListView.builder(
      itemCount: ListItems.length,
      itemBuilder: (BuildContext ctx, int index) {
        return new OfferListItem(
          item: ListItems[index],
          itemId: index.toString(),
          callback: (itemId, interaction) =>
              _handleButtonTap(itemId, interaction),
        );
      },
    ));
  }

  void _handleButtonTap(String itemId, OfferInteraction interaction) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text("Você clicou em $itemId"),
              content: new Text(interaction.toString()));
        });
  }
}

enum OfferInteraction { accept, reject }

class OfferListItem extends StatelessWidget {
  OfferListItem(
      {@required this.item, @required this.itemId, @required this.callback});

  final ListItemData item;
  final String itemId;
  final Function(String, OfferInteraction) callback;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(DateFormat.Hm().format(item.time)),
        MaterialButton(
          child: Icon(Icons.check),
          onPressed: () => this.callback(itemId, OfferInteraction.accept),
        ),
        MaterialButton(
            child: Icon(Icons.clear),
            onPressed: () => this.callback(
                  itemId,
                  OfferInteraction.reject,
                )),
      ],
    );
  }
}
