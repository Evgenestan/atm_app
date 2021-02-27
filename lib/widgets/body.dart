import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yalo_assets/lib.dart';

class Body extends StatelessWidget {
  const Body({Key key, this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: 200,
              width: screenWidth,
              child: OverflowBox(
                maxWidth: screenWidth * 1.21,
                alignment: Alignment.bottomLeft,
                child: SvgPicture.asset(
                  Assets.upBackgroundS,
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                  allowDrawingOutsideViewBox: true,
                  height: double.infinity,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 130,
              width: screenWidth,
              child: OverflowBox(
                maxWidth: screenWidth * 1.21,
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(
                  Assets.bottomBackgroundS,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  allowDrawingOutsideViewBox: true,
                  height: double.infinity,
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
