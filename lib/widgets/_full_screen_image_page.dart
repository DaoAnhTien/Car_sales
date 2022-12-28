import 'package:flutter/material.dart';
import 'package:oke_car_flutter/widgets/custom/customAppBar/custom_app_bar.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImagePage extends StatelessWidget {
  final String url;
  final String? token;
  FullScreenImagePage({required this.url,  this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        titleColor: Colors.white,

      ),
      body: PhotoView(
        imageProvider: NetworkImage(url,headers: {
          'Authorization': token ?? '',
        },),
      ),
    );
  }
}
