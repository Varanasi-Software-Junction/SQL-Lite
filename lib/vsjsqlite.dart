import 'package:flutter/material.dart';
import 'dart:async';

import 'package:sqlite/databasehandler.dart';
import 'book.dart';

class VsjSqlite extends StatefulWidget {
  final String title = "VSJ Sqlite Database";

  @override
  _VsjSqliteState createState() => _VsjSqliteState();
}

class _VsjSqliteState extends State<VsjSqlite> {
  String bookid = "", bookname = "", bookprice = "", message = "";

  TextEditingController idcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              backgroundColor: Colors.teal,
              centerTitle: true,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: Text(message)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(children: [
                        Text("Id"),
                        SizedBox(
                          width: 60,
                          child: TextField(
                            onChanged: (value) {
                              bookid = value;
                            },
                            controller: idcontroller,
                          ),
                        ),
                      ]),
                      Column(children: [
                        Text("Name"),
                        SizedBox(
                          width: 60,
                          child: TextField(
                            controller: namecontroller,
                            onChanged: (value) {
                              bookname = value;
                            },
                          ),
                        ),
                      ]),
                      Column(children: [
                        Text("Price"),
                        SizedBox(
                          width: 60,
                          child: TextField(
                            controller: pricecontroller,
                            onChanged: (value) {
                              bookprice = value;
                            },
                          ),
                        ),
                      ]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          child: Text("Add"),
                          onPressed: () {
                            () async {
                              print("bn" + bookname);
                              var javabook = Book(int.parse(idcontroller.text), namecontroller.text,
                                  int.parse(pricecontroller.text));

                              await DatabaseHandler.insertBook(javabook);
                              print("Add");
                              setState(() {
                                message="Add";
                              });
                            }();
                          }),
                      ElevatedButton(
                          child: Text("Del"),
                          onPressed: () {
                            () async {
                              DatabaseHandler.deleteBook(int.parse(idcontroller.text));
                              print("Del");
                              setState(() {
                                message="Add";
                              });
                            }();
                          }),
                      ElevatedButton(
                          child: Text("Update"),
                          onPressed: () {
                            () async {
                              var javabook = Book(int.parse(idcontroller.text), namecontroller.text,
                                  int.parse(pricecontroller.text));
                              await DatabaseHandler.updateBook(javabook);

                              // Print the updated results.
                              print(await DatabaseHandler.books());
                              print("Update");
                            }();
                          }),
                      ElevatedButton(
                          child: Text("Search"),
                          onPressed: () async {
                            print("Search");
                          var list= await DatabaseHandler.books();
                          List<Book> lst=list;
                       lst=   lst.where((element) => element.id==int.parse(bookid)).toList();
                          if(lst.length<=0)
                            message="Not Found";
                          else
                            {
                              print(list);
                              message="Found";
                              Book book=lst.first;
                              namecontroller.text=book.name;
                              pricecontroller.text=book.price.toString();
                            }
                          setState(() {

                          });
                          }),
                    ],
                  ),
                ],
              ),
            ),
            // This trailing comma makes auto-formatting nicer for build methods.
          ),
        ),
      ),
    );
  }
}
