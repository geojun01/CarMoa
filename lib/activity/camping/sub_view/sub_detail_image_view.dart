import 'package:carmoa/data/sub_image_model/sub_image_data.dart';
import 'package:carmoa/widgets/image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class DetailImageView extends StatelessWidget {
  final SubImageData subImage;
  final String title;

  DetailImageView({@required this.subImage, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      backgroundColor: Color.fromRGBO(40, 40, 40, 1),
      body: Container(
        alignment: Alignment.center,
        child: Swiper(
          curve: Curves.easeIn,
          itemCount: subImage.response.body.items.item.length,
          itemBuilder: (context, index) {
            return Center(
              child: ClipRect(
                child: ImageNetwork(
                  url: subImage.response.body.items.item[index].originimgurl,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          // viewportFraction: 0.8,
          // scale: 0.9,
          pagination: SwiperPagination(),
          layout: SwiperLayout.DEFAULT,
        ),
      ),
    );
  }
}
