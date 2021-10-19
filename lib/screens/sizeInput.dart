import 'package:flutter/material.dart';

class InputScreen extends StatefulWidget {

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {

  int sizeAr = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none
                      ),
                      hintText: 'Size of Array (Integer Only)',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600
                      )
                  ),
                  onChanged: (value){
                    sizeAr = int.parse(value);
                    print(sizeAr);
                    setState(() {
                      sizeAr = sizeAr;
                    });
                  },
                  // onSubmitted: (value){
                  // },
                ),
                SizedBox(
                  height: 40
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white10
                      )
                    ]
                  ),
                  child: TextButton(onPressed: (){},
                      child: Text("Visualize" , style: TextStyle(
                        fontSize: 30
                      ),)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
