import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_mart/net/api_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double bitcoin = 0.0;
  double tether = 0.0;
  double ethereum = 0.0;

  @override
  void initState() {
    getValues();
  }

  getValues() async {
    bitcoin = await getPrice("bitcoin");
    tether = await getPrice("tether");
    ethereum = await getPrice("ethereum");
  }

  @override
  Widget build(BuildContext context) {
    getValue(String id, double amount) {
      if (id == "bitcoin") {
        return bitcoin * amount;
      } else if (id == "tether") {
        return tether * amount;
      } else {
        return ethereum * amount;
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        title: Text("CRYPTO MART"),
        backgroundColor: Color(0xffdea01c),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xff2b2b2b),
              Color(0xffc66901),
              Color(0xffdea01c),
            ],
          ),
          //color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .collection('Coins')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      children: snapshot.data!.docs.map((document) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 15.0,
                            bottom: 15.0,
                            left: 15.0,
                            right: 15.0,
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white70,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xffad6800),
                                  offset: Offset(
                                    1.0,
                                    2.0,
                                  ),
                                  blurRadius: 20.0,
                                  spreadRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const SizedBox(
                                    width: 2.0,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "COIN        : ${document.id}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                          color: Color(0xffc66901),
                                        ),
                                      ),
                                      Text(
                                        "AMOUNT : \$ ${getValue(document.id, document.data()['Amount']).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                          color: Color(0xffc66901),
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await removeCoin(document.id);
                                    },
                                    icon: const Icon(
                                      Icons.remove_circle,
                                      size: 35,
                                      color: Color(0xffdfa31c),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 20, bottom: 20, right: 90, left: 90),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  elevation: 15,
                  backgroundColor: Colors.white38,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  side: BorderSide(
                    color: Colors.white24,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddPage()));
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.add_circle_rounded,
                        color: Colors.orange,
                        size: 30,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "ADD COIN",
                        style:
                            TextStyle(color: Color(0xff2b2b2b), fontSize: 25),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(0xff2b2b2b),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      //   floatingActionButton: FloatingActionButton.extended(
      //     // child: Row(
      //     //   children: <Widget>[
      //     //     Icon(Icons.add_circle_rounded,color: Color(0xffc66901),),
      //     //     Text("Add Coin"),
      //     //     Icon(Icons.arrow_forward_ios_rounded),
      //     //   ],
      //     // ),
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => AddPage()));
      //   },
      //   // child: Icon(
      //   //   Icons.add,
      //   //   size: 50,
      //   // ),
      //   backgroundColor: Colors.transparent,
      //   icon: Icon(
      //     Icons.add,
      //     size: 30,
      //   ),
      //   label: Text(
      //     "Add Coin  ",
      //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Future<bool> removeCoin(String id) async {
  String uid = FirebaseAuth.instance.currentUser.uid;
  FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .collection('Coins')
      .doc(id)
      .delete();
  return true;
}
