import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  createState() => MyAppState();
}

List<String> listItems = [
  "One",
  "Two",
  "Three",
  "Four",
  "Five"
]; //dummy list of items

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Swipe List"),
          ),
          body: Container(
              child: ListView.builder(
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              return Dismissible(
                  background: stackBehindDismiss(),
                  secondaryBackground: secondarystackBehindDismiss(),
                  key: ObjectKey(listItems[index]),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Text(listItems[index]),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      print("Add to favorite");
                    } else {
                      print('Remove item');
                    }
                  },
                  confirmDismiss: (DismissDirection direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm"),
                          content: direction == DismissDirection.startToEnd
                              ? Text(
                                  "Are you sure you wish add to favorite this item?")
                              : Text(
                                  "Are you sure you wish to delete this item?"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: direction == DismissDirection.startToEnd
                                  ? Text("FAVORITE")
                                  : Text("DELETE"),
                            ),
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("CANCEL"),
                            ),
                          ],
                        );
                      },
                    );
                  });
            },
          )),
        ));
  }

  void deleteItem(index) {
    setState(() {
      listItems.removeAt(index);
    });
  }

  void undoDeletion(index, item) {
    setState(() {
      listItems.insert(index, item);
    });
  }

  Widget secondarystackBehindDismiss() {
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: Colors.white),
            Text('Move to trash', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget stackBehindDismiss() {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Icon(Icons.favorite, color: Colors.white),
            Text('Move to favorites', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

//undo implementation ,,

// <---add this to onDismissed property--->

// var item = listItems.elementAt(index);
// Scaffold.of(context).showSnackBar(SnackBar(
//    content: Text("Item deleted"),
//     action: SnackBarAction(
//       label: "UNDO",
//         onPressed: () {
//       undoDeletion(index, item);//undo deletion
//  })));
// <---add this to onDismissed property--->




//----------------------------------Full code to implementation to vertical swiping---------------------

// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   createState() => MyAppState();
// }

// List<String> listItems = ["One", "Two", "Three", "Four"]; //dummy list of items

// class MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//           appBar: AppBar(
//             title: Text("Swipe List"),
//           ),
//           body: Container(
//             alignment: Alignment.center,
//             height: 100,
//             child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: listItems.length,
//                 padding: const EdgeInsets.all(5.0),
//                 separatorBuilder: (context, index) => VerticalDivider(
//                       color: Colors.black,
//                     ),
//                 itemBuilder: (context, index) {
//                   return Dismissible(
//                     direction: DismissDirection.vertical,
//                     key: Key('item ${listItems[index]}'),
//                     background: Container(
//                       color: Colors.blue,
//                       child: Padding(
//                         padding: const EdgeInsets.all(15),
//                         child: Icon(Icons.favorite, color: Colors.white),
//                       ),
//                     ),
//                     secondaryBackground: Container(
//                       color: Colors.red,
//                       child: Padding(
//                         padding: const EdgeInsets.all(15),
//                         child: Icon(Icons.delete, color: Colors.white),
//                       ),
//                     ),
//                     onDismissed: (DismissDirection direction) {
//                       if (direction == DismissDirection.down) {
//                         print("Add to favorite");
//                       } else {
//                         print('Remove item');
//                       }

//                       setState(() {
//                         listItems.removeAt(index);
//                       });
//                     },
//                     child: Container(
//                       width: 100,
//                       child: Center(
//                         child: Column(
//                           children: [
//                             Icon(Icons.phone_android, size: 50),
//                             Text(listItems[index]),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//           )),
//     );
//   }
// }
