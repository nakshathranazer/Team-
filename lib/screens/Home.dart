import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Item> items = List();
  Item item;
  DatabaseReference itemRef;


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    item = Item("", "","","");
    final FirebaseDatabase database = FirebaseDatabase.instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('items');
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(Event event) {
    setState(() {
      items.add(Item.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = items.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      items[items.indexOf(old)] = Item.fromSnapshot(event.snapshot);
    });
  }
  getCurrentDate(String a,String b){
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    setState(() {

     a   = formattedTime.toString() ;
     b  = formattedDate.toString() ;

    });

  }
  void handleSubmit() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      form.reset();
      itemRef.push().set(item.toJson());
    }
  }
  alert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
    return AlertDialog(
      title: Text("Use Sanitizer"),

      actions: <Widget>[
        FlatButton(
            child: Text("Proceed"),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () {
              alert2(context);
            }
        )
      ],
    );
  }
    );}
  alert2(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Thermal Scanning"),

            actions: <Widget>[
              FlatButton(
                  child: Text("Proceed"),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Home()));
                  }
              )
            ],
          );
        }
    );}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Members'
            ''),
      ),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 0,
            child: Center(
              child: Form(
                key: formKey,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.info),
                      title: TextFormField(
                        initialValue: "",
                        onSaved: (val) => item.title = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: TextFormField(
                        initialValue: '',
                        onSaved: (val) => item.body = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                                DateTime now = DateTime.now();
                                String formattedTime = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
                                var date = new DateTime.now().toString();

                                var dateParse = DateTime.parse(date);

                                var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

                                setState(() {

                                   item.finalTime   = formattedTime.toString() ;
                                   item.finalDate = formattedDate.toString() ;
                                   });
                                handleSubmit();
                                alert(context);
                                }

                    )
                  ],
                ),
              ),
            ),
          ),

          Flexible(
            child: FirebaseAnimatedList(
              query: itemRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return new ListTile(
                  leading: Icon(Icons.message),
                  title: Text(items[index].title),

                  subtitle: Text(items[index].body),
                );

              },
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  String key;
  String title;
  String body;
  String finalTime ;
  String finalDate ;

  Item(this.title, this.body,this.finalTime,this.finalDate);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value["title"],
        body = snapshot.value["body"],
        finalTime =snapshot.value['finalTime'],
        finalDate =snapshot.value['finalDate'];


  toJson() {
    return {
      "title": title,
      "body": body,
       "finalTime":finalTime,
       "finalDate":finalDate
    };
  }
}


