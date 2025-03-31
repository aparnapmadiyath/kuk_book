import 'package:flutter/material.dart';

import '../../../core/common/widgets/custom_text_widget.dart';
import '../../../main.dart';

class ProfileTile extends StatefulWidget {
  final String title;
  final String subTitle;
  final Color color;
  final Widget page;

  const ProfileTile(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.page,
      this.color = Colors.white});

  @override
  State<ProfileTile> createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget.page,
          ),
        );
      },
      shape: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)),
      title: CustomTextWidget(
        text: widget.title,
        color: widget.color,
        fontSizeMultiplier: 0.042,
        weight: FontWeight.bold,
      ),
      subtitle: CustomTextWidget(
        text: widget.subTitle,
        color: widget.color,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: widget.color,
        size: w * 0.04,
      ),
    );
  }
}
