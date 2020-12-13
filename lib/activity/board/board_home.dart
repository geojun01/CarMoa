import 'package:flutter/material.dart';

class BoardHome extends StatefulWidget {
  @override
  _BoardHomeState createState() => _BoardHomeState();
}

class _BoardHomeState extends State<BoardHome> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned(
          height: height,
          width: width,
          child: Image.asset('assets/images/board_image.jpg', fit: BoxFit.none),
        ),
        Scaffold(
          backgroundColor: Colors.black54,
          appBar: AppBar(
            title: Text('게시판'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: BoardList(),
        )
      ],
    );
  }
}

final List<int> items = List.generate(100, (index) => index + 1);

class BoardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: items
            .map((i) => ListTile(
                  title: itemList(context, i),
                  onTap: () {
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('클릭 확인 리스트 No $i')));
                  },
                ))
            .toList(),
      ),
    );
  }
}

Widget itemList(BuildContext context, int i) {
  return Card(
    color: Colors.white70,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('게시판 목록 ', style: TextStyle(color: Colors.limeAccent)),
              SizedBox(width: 8),
              Icon(Icons.chevron_right),
              SizedBox(width: 8),
              Text('카운트 $i')
            ],
          ),
          Divider(thickness: 1, color: Colors.white54),
          Text('게시판 테스트 Studio Jungle', style: TextStyle(fontSize: 12))
        ],
      ),
    ),
  );
}
