import 'package:crypto_mart/net/flutterfire.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  List<String> coins = [
    "bitcoin",
    "tether",
    "ethereum",
  ];

  String? dropdownValue = "bitcoin";
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xff2b2b2b),
              Color(0xffc66901),
              Color(0xffdea01c),
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white38),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "COIN",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),
                DropdownButton(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  dropdownColor: Color(0xff2b2b2b),
                  value: dropdownValue,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value;
                    });
                  },
                  items: coins.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ).toList(),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "COIN AMOUNT",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.0,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _amountController,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  //alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width / 1.9,
                  height: 45,
                  /*decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),

              ),*/
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Color(0xff2b2b2b),
                    elevation: 20,
                    onPressed: () async {
                      await AddCoin(dropdownValue!, _amountController.text);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "ADD",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
