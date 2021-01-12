import 'package:carmoa/config/assist_util.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/config/provider/model.dart';
import 'package:carmoa/data/car_data_model.dart';
import 'package:carmoa/data/db_create.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DataListView extends StatefulWidget {
  final int dataIndex;
  final String titleName;

  DataListView({@required this.titleName, @required this.dataIndex});

  @override
  _DataListViewState createState() => _DataListViewState();
}

class _DataListViewState extends State<DataListView> {
  @override
  Widget build(BuildContext context) {
    final db = CreateDB();
    final item = Provider.of<Model>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Hero(tag: 'listIcon', child: titleImage()),
            SizedBox(width: 6),
            Text('${widget.titleName} 교환일지'),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                child: totalPriceText(context),
              ),
              Divider(thickness: 1),
              Flexible(
                child: ListView.builder(
                  itemCount: item.getIndex(),
                  itemBuilder: (context, _index) {
                    return InkWell(
                      onLongPress: () {
                        Scaffold.of(context).hideCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '${changeUnit(item.selectData[(item.getIndex() - _index) - 1].exchange)} km 데이터 삭제'),
                            action: SnackBarAction(
                              label: '삭제',
                              onPressed: () {
                                db.deleteData(item
                                    .getData((item.getIndex() - _index) - 1));
                                item.itemDelete(item
                                    .getData((item.getIndex() - _index) - 1));
                                if (item.getIndex() == 0)
                                  Navigator.of(context).pop();
                              },
                            ),
                          ),
                        );
                      },
                      child: listViewItem(
                          context,
                          item.getData((item.getIndex() - _index) - 1),
                          (item.getIndex() - _index) - 1),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text totalPriceText(BuildContext context) {
    final _item = Provider.of<Model>(context);
    int _totalPrice = 0;

    for (int i = 0; i < _item.getIndex(); i++) {
      _totalPrice += _item.selectData[i].price;
    }
    _item.setTotalPrice(_totalPrice);
    return Text('총 지출 비용 : ${changeUnit(_item.getTotalPrice())} 원',
        style: mainText16);
  }

  Image titleImage() {
    String iconImage = carIcons[widget.dataIndex];

    return Image.asset(
      'assets/icons/$iconImage',
      width: 24,
      height: 24,
    );
  }

  Widget listViewItem(BuildContext context, CarModel _item, int _index) {
    var _date = _item.dateTime.split(' ');
    _date = _date[0].split('-');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(CupertinoIcons.calendar_circle, size: 18),
                  SizedBox(width: 6),
                  Text('교환날짜 : ${_date[0]}년 ${_date[1]}월 ${_date[2]}일',
                      style: mainText16),
                ],
              ),
              Divider(thickness: 1),
              Row(
                children: [
                  Text('교환거리 : ${changeUnit(_item.exchange)} km',
                      style: mainText),
                  Expanded(
                      child: Container(
                    child: Icon(FontAwesomeIcons.ellipsisH, size: 12),
                  )),
                  Text('교환비용 : ${changeUnit(_item.price)} 원',
                      style: mainText),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}