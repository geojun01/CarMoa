import 'package:carmoa/config/provider/model.dart';
import 'package:carmoa/data/db_create.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputData extends StatefulWidget {
  final titleName;

  InputData({Key key, @required this.titleName}): super(key: key);

  @override
  _InputDataState createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  @override
  Widget build(BuildContext context) {
    final itemView = Provider.of<Model>(context);
    final db = CreateDB();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        centerTitle: true,
        elevation: 4,
        title: Text('${widget.titleName}',style: TextStyle(color: Theme.of(context).primaryColor),),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
