import 'package:flutter/cupertino.dart';

class FooterImage extends StatelessWidget{

  final String imagePath;


  const FooterImage(this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: 35,
      height: 35,
    );
  }


}