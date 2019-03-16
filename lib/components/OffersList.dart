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
        body: new ListView.separated(
      separatorBuilder: (context, index) => Divider(
            color: Colors.black,
          ),
      itemCount: ListItems.length,
      itemBuilder: (BuildContext context, int index) {
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: 100,
            alignment: Alignment.center,
            child: Text(
              DateFormat.Hm().format(item.time),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
            ),
          ),
          Container(
            width: 30,
            height: 30,
            child: FlatButton(
                textColor: Colors.red[500],
                child: Icon(Icons.clear),
                onPressed: () => this.callback(
                      itemId,
                      OfferInteraction.reject,
                    )),
          ),
          MaterialButton(
            color: Colors.green[900],
            textColor: Colors.white,
            child: Icon(Icons.check),
            onPressed: () => this.callback(itemId, OfferInteraction.accept),
          ),
        ],
      ),
    );
  }
}
