import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../main.dart';

class GridContainer extends StatefulWidget {
  final Map elements;

  const GridContainer({super.key, required this.elements});

  @override
  State<GridContainer> createState() => _GridContainerState();
}

class _GridContainerState extends State<GridContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(w * 0.04),
          color: widget.elements["text"]=="Get Inspired"||widget.elements["text"]=="Learn to Cook"||widget.elements["text"]=="Quick & Easy"?const Color(0xff565252):const Color(0xffFAFAFA),),
      child: Padding(
        padding: EdgeInsets.all( w * 0.02,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(widget.elements["image"],width: w*0.12,),
            Text(
              widget.elements["text"],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: w * 0.028,color: widget.elements["text"]=="Get Inspired"||widget.elements["text"]=="Learn to Cook"||widget.elements["text"]=="Quick & Easy"?const Color(0xffffffff):const Color(0xff565252),),
            )
          ],
        ),
      ),
    );
  }
}
