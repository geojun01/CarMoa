import 'package:carmoa/config/assist_util.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/config/provider/cycle_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:provider/provider.dart';

class CycleSetting extends StatefulWidget {
  @override
  _CycleSettingState createState() => _CycleSettingState();
}

class _CycleSettingState extends State<CycleSetting> {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<Cycle>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('교환주기 설정', style: TextStyle(fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _cycleItem(context, p.getEng(), 0),
                    _cycleItem(context, p.getAir(), 1),
                    _cycleItem(context, p.getWiper(), 2),
                    _cycleItem(context, p.getTire(), 3),
                    _cycleItem(context, p.getBreak(), 4),
                    _cycleItem(context, p.getBreakOil(), 5),
                    _cycleItem(context, p.getBattery(), 6),
                    _cycleItem(context, p.getPlug(), 7),
                    _cycleItem(context, p.getAntifreeze(), 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cycleItem(BuildContext context, var p, int _index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        margin: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 8),
              Image.asset('assets/icons/${carIcons[_index]}',
                  width: 20.0, height: 20.0),
              SizedBox(width: 8),
              Text('${partType[_index]}'),
              SizedBox(width: 8),
              Icon(
                CupertinoIcons.right_chevron,
                size: 16,
                color: Colors.deepOrangeAccent,
              ),
              SizedBox(width: 8),
              _cycleText(context, _index),
              SizedBox(width: 8),
              Expanded(child: Container()),
              FlatButton(
                  height: 40,
                  minWidth: 40,
                  onPressed: () {
                    _changeCycle(context, _index, p);
                  },
                  child: Text(
                    '설정',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )),
              SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }


  Widget _cycleText(BuildContext context, int _index) {
    final p = Provider.of<Cycle>(context, listen: false);

    if (_index == 0)
      return Text('${NumberFormat('###,###,###').format(p.getEng())} km');
    if (_index == 1)
      return Text('${NumberFormat('###,###,###').format(p.getAir())} km');
    if (_index == 2)
      return Text('${NumberFormat('###,###,###').format(p.getWiper())} km');
    if (_index == 3)
      return Text('${NumberFormat('###,###,###').format(p.getTire())} km');
    if (_index == 4)
      return Text('${NumberFormat('###,###,###').format(p.getBreak())} km');
    if (_index == 5)
      return Text('${NumberFormat('###,###,###').format(p.getBreakOil())} km');
    if (_index == 6)
      return Text('${NumberFormat('###,###,###').format(p.getBattery())} km');
    if (_index == 7)
      return Text('${NumberFormat('###,###,###').format(p.getPlug())} km');
    if (_index == 8)
      return Text(
          '${NumberFormat('###,###,###').format(p.getAntifreeze())} km');

    // return 경고 방지용
    return Text('');
  }

  Future<void> _changeCycle(BuildContext context, int _index, var p) {
    int value;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Image.asset('assets/icons/${carIcons[_index]}',
                  width: 24.0, height: 24.0),
              SizedBox(width: 8),
              Text('${partType[_index]}'),
            ],
          ),
          content: TextField(
            onChanged: (String _value) {
              value = int.parse(_value.replaceAll(',', ''));
            },
            keyboardType: TextInputType.number,
            textAlign: TextAlign.end,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              ThousandsFormatter()
            ],
            maxLength: 7,
            decoration: InputDecoration(
              hintText: '${NumberFormat('###,###,###').format(p)}',
              counterText: '',
              suffixText: ' km',
            ),
          ),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('취소')),
            FlatButton(
                onPressed: () {
                  if (value != null && value > 0) {
                    _savePreference(context, _index, value);
                    Future.delayed(Duration(milliseconds: 200), () {
                      Navigator.of(context).pop();
                      return value;
                    });
                  }
                },
                child: Text('저장'))
          ],
        );
      },
    );
  }

  void _savePreference(BuildContext context, int _index, int _value) async {
    final _provider = Provider.of<Cycle>(context, listen: false);
    await savePreferenceInt(saveTitle: partType[_index], value: _value);

    switch (_index) {
      case 0:
        _provider.setEng(_value);
        break;
      case 1:
        _provider.setAir(_value);
        break;
      case 2:
        _provider.setWiper(_value);
        break;
      case 3:
        _provider.setTire(_value);
        break;
      case 4:
        _provider.setBreak(_value);
        break;
      case 5:
        _provider.setBreakOil(_value);
        break;
      case 6:
        _provider.setBattery(_value);
        break;
      case 7:
        _provider.setPlug(_value);
        break;
      case 8:
        _provider.setAntifreeze(_value);
        break;
    }
  }
}
