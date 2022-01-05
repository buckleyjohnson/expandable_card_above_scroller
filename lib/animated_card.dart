import 'package:flutter/material.dart';
import 'clickable_text.dart';


const maxChars = 100;
class AnimatedCard extends StatefulWidget {
  const AnimatedCard({Key? key, required this.originalDescriptionText, required this.title, required this.subTitle, this.virtualTourText}) : super(key: key);
  final originalDescriptionText;
  final String title;
  final String subTitle;
  final String? virtualTourText;


  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  var _expand = false;
  var _descriptionText;
  var _myHeight = 50.0;
  var title = "";
  var subtitle = "";


  clickedMore(){
    setState(() {
      _expand = !_expand;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    var heightNotExpanded = 180.0;

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    //for every 100 chars, slide down by X for narrow, y for wide
    //Narrow: 236 = 200
    //Narrow: 300 = 300
    //Narrow: 400 = 350
    //Narrow: 500 = 400//up 50 for every 400
    var heightExpanded = (widget.originalDescriptionText.length / 3) + 230;
    if (_width > 400){
      heightExpanded = (widget.originalDescriptionText.length / 3) + 130;
    }

    print("expand = $_expand");
    if (_expand)
    {
      print("_originalDescriptionText=${widget.originalDescriptionText}");
      print("myht = ${widget.originalDescriptionText}");
      print("maxChars = ${maxChars}");
      print("widget.originalDescriptionText.length = ${widget.originalDescriptionText.length}");
      if (widget.originalDescriptionText.length > maxChars){
        _descriptionText = widget.originalDescriptionText;
        _myHeight = heightExpanded;
      }
      else {
        _myHeight = heightNotExpanded;   //if its too short to need to expand, don't
      }
    }
    else {
      _myHeight = heightNotExpanded;

      if (widget.originalDescriptionText.length > maxChars){print("stripping");
        _descriptionText = widget.originalDescriptionText.substring(0, maxChars);
      }
      else {
        _descriptionText = widget.originalDescriptionText;
      }
    }

    var _textWidth = _width * .5;
    print("myht = ${_myHeight}");
    // print("_descriptionText = ${_des}");
    return GestureDetector(
      onTap: clickedMore,
      child: Center(
        child: AnimatedContainer(
          // onEnd: _animeEnded,
          clipBehavior: Clip.antiAlias,
          width: _width * .9,
          height: _myHeight,
          decoration: BoxDecoration(
            color: Colors.white, // added
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(4, 8), // Shadow position
              ),
            ],
          ),
          // Define how long the animation should take.
          duration: const Duration(seconds: 2),
          // Provide an optional curve to make the animation feel smoother.
          curve: Curves.fastOutSlowIn,
          child: Wrap(
            children: <Widget>[
               ListTile(
                leading: Icon(Icons.album),
                title: Text(widget.title),
                subtitle: Text(widget.subTitle),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                    child: SizedBox(
                      width: _textWidth,
                      child:   clickableText(theText: _descriptionText, clickedMore: clickedMore, shouldShowMore: (_descriptionText.length != widget.originalDescriptionText.length)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  (widget.virtualTourText == null)  ? Container() : TextButton(      //todo: don't show if there's not a virtual tour
                    child:  Text(widget.virtualTourText!),
                    onPressed: () {setState(() {print ("tapped vt");
                     // _expand = !_expand;
                    });},
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
