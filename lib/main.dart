import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'animated_card.dart';
import 'animated_contact_info_card.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Scaffold(body: MyHomePage()),
    );
  }
}


class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen,
      height: 400,
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List myList = ['IMG_4899', 'Kitchen', 'Kitchen-3', 'Kitchen-4', 'Kitchen-5', 'Laundry Room', 'Pantry'];
  //var _originalDescriptionText = "Thisv very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very  very very very very very very very very very very very very very very very very very very very  very very very very very very very very very very very very very very very very very very very  very very very very very very very very very very very very very very very very very very very  very very  very very very very very very very very very very very very very very very very very very very  very very very very very very very very very very very very very very very very very  go overboard with a lot of exatra crap long";
  var _originalDescriptionText = "Thisv very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very  very very very very very very very very very very very very very very very very very very very  very very very very very very very very very very very very very go overboard with a lot of exatra crap long";
  //var _originalDescriptionText = " very very  very very very very very very very very very very very very very very very very very very very  very very very very very very very very very very very very very very very very very  go overboard with a lot of exatra crap long";
  late String _descriptionText ;

  bool upDirection = true, flag = false;
  late ScrollController _controller;


  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    _descriptionText = _originalDescriptionText;
    _controller = ScrollController()
      ..addListener(() {
        upDirection = _controller.position.userScrollDirection == ScrollDirection.forward;
        // print("upDirection $upDirection");
        // makes sure we don't call setState too much, but only when it is needed
        if (upDirection == flag)
          setState(() { print("is going up");});


        flag = !upDirection;
      });
  }
  @override
  Widget build(BuildContext context) {
    var _isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final ScrollController scrollController = ScrollController();
    return SafeArea(
      child: Column(
        children: [
          !_isPortrait ? Container() : Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: AnimatedContactInfoCard(shrinkDown: flag, originalDescriptionText: "very long text but only 25", title: "Joes Tavern", subTitle: "A great place to do nothing but this text is", contactInfoList: {"phone": "872-3333", "email": "this is email"}),
          ),
          !_isPortrait ? Container() : AnimatedCard(shrinkDown: flag, originalDescriptionText: _originalDescriptionText, title: "1302 Dartmouth dr NE", subTitle: "4 bedrooms of luxury",virtualTourText: "Virtual Tour",),
          SizedBox(height: 8.0,),
          Expanded(
            child: ListView.builder(
                controller: _controller,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: myList.length,
                itemBuilder: (BuildContext context, int index) {
                  var name = 'assets/' + myList[index] + '.jpg';
                  return Image.asset(name, fit: BoxFit.contain,);
                }
            ),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}


