import 'dart:math';

import 'package:flutter/material.dart';

class DropCapText extends StatelessWidget {
  final Widget dropCap;
  final String text;
  final TextStyle textStyle;
  final EdgeInsets dropCapPadding;

  const DropCapText({
    super.key,
    required this.dropCap,
    required this.text,
    required this.textStyle,
    this.dropCapPadding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //get the drop cap size
        // final dropCapSpan = WidgetSpan(child: dropCap);
        // final dropCapPainter = TextPainter(
        //     text: dropCapSpan, textDirection: Directionality.of(context));

        // dropCapPainter.layout(maxWidth: constraints.maxWidth);

        //get the position of the last bit of text next to the dropcap
        final textSpan = TextSpan(text: text, style: textStyle);
        final textPainter = TextPainter(
            text: textSpan, textDirection: Directionality.of(context));
        textPainter.layout(
            maxWidth: max(constraints.minWidth,
                constraints.maxWidth - dropCapPadding.horizontal - 120));
        final lastPosition =
            textPainter.getPositionForOffset(Offset(textPainter.width, 100));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: dropCapPadding,
                  child: dropCap,
                ),
                Expanded(
                  child: Text(
                    text.substring(0, lastPosition.offset),
                    style: textStyle,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
            Text(
              text.substring(lastPosition.offset),
              style: textStyle,
              overflow: TextOverflow.clip,
            ),
          ],
        );
      },
    );
  }
}
// TODO: understand more of the functionality of the code
