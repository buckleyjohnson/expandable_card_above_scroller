import 'package:flutter/material.dart';
import 'clickable_text.dart';


const maxChars = 100;
class AnimatedContactInfoCard extends StatefulWidget {
  const AnimatedContactInfoCard({Key? key, required this.shrinkDown, required this.originalDescriptionText, required this.title, required this.subTitle, this.contactInfoList}) : super(key: key);
  final originalDescriptionText;
  final String title;
  final String subTitle;
  final Map<String, String>? contactInfoList;
  final bool shrinkDown;


  @override
  State<AnimatedContactInfoCard> createState() => _AnimatedContactInfoCardState();
}

class _AnimatedContactInfoCardState extends State<AnimatedContactInfoCard> {
  var _expand = false;
  var _descriptionText;
  var _myHeight = 100.0;
  var title = "";
  var subtitle = "";

  clickedMore(){
    setState(() {
      _expand = !_expand;
    });
  }

  @override
  Widget build(BuildContext context) {

    bool _shouldShowContactInfoList = false;
    if (widget.contactInfoList != null){
      if (widget.contactInfoList!.length > 0){
        _shouldShowContactInfoList = true;
      }
    }
      var _subtitle = widget.subTitle;
    if (widget.subTitle.length >= 40) {
      _subtitle = widget.subTitle.substring(0, 40);
    }
    var _title = widget.title;
    if (widget.title.length >= 22){
      _title = widget.title.substring(0, 22);
    }
    var heightNotExpanded = 90.0;

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;


    var _heightExpanded = 150.0;


    if (_expand)
    {
      _myHeight = _heightExpanded;
    }
    else {
      _myHeight = heightNotExpanded;

    }
    if (widget.shrinkDown){
      _myHeight = 0;
    }
    var _textWidth = _width * .5;

    return GestureDetector(
      onTap: (){setState(() {
        _expand = false;
      });},
      child: Center(
        child: AnimatedContainer(
          // onEnd: _animeEnded,
          clipBehavior: Clip.antiAlias,
          width: _width * .98,
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
          duration: const Duration(seconds: 2),
          // Provide an optional curve to make the animation feel smoother.
          curve: Curves.fastOutSlowIn,
          child: Wrap(
            children: <Widget>[
              ListTile(
                // tileColor: Colors.white,
                leading: Icon(Icons.album),
                title: Text(_title),
                subtitle: Text(_subtitle),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  // const SizedBox(width: 8),
                  (!_shouldShowContactInfoList)  ? Container() : TextButton(      //todo: don't show if there's not a virtual tour
                  style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size.zero, // <-- Add this
                    padding: EdgeInsets.zero, // <-- and this
                  ),
                    child:  Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text("Contact"),
                    ),
                    onPressed: () {setState(() {
                       _expand = !_expand;
                    });},
                        ),
                ],
              ),
              (!_shouldShowContactInfoList)
                  ? Container()
                  : Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 12.0),
                    child: Row(children: [
                        Container(
                          height: 333,
                          width: _width * .9,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                String key = widget.contactInfoList!.keys.elementAt(index);
                                final name = key;
                                final value = widget.contactInfoList![key];
                                return Text(name + " " + value!);
                              },
                              separatorBuilder: (BuildContext context, int index) => Divider(
                                color: Colors.black,
                                endIndent: 10,
                                indent: 10,
                              ),
                              itemCount: widget.contactInfoList!.length),
                        )
                      ]),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
