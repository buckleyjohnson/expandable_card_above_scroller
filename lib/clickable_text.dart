import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';


class clickableText extends StatelessWidget {
  const clickableText({Key? key, required this.theText, required this.clickedMore,required this.shouldShowMore}) : super(key: key);

  final Function clickedMore;
  final String theText;
  final bool shouldShowMore;



  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = TextStyle(color: Colors.black, fontSize: 14.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    return shouldShowMore ? RichText(
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          TextSpan(text: theText),
          TextSpan(
              text: ' more ',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () => clickedMore()),
        ],
      ),
    ) : RichText(
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          TextSpan(text: theText),
        ],
      ),
    );
  }
}