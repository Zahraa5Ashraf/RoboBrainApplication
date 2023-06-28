import 'package:flutter/material.dart';
import 'package:healthcare/views/login_screen.dart';

class successful extends StatelessWidget {
  const successful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //Background
          Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            "assets/images/background-gradient.png"))),
              )),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Regestration Successful',
              style: TextStyle(fontSize: 30, color: Colors.grey[600]),
            ),
          ),
          //BUTTON
          Align(
            alignment: Alignment.bottomCenter,
            heightFactor: 5,
            child: Container(
                margin: EdgeInsets.all(70),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200.0),
                    )),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => login_screen(),
                      ),
                    );
                  },
                  child: Ink(
                    width: 200,
                    decoration: BoxDecoration(

                        //   gradient: LinearGradient(
                        //       colors: [Colors.deepPurple, Colors.orange]),
                        ),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: const Text('Login', textAlign: TextAlign.center),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
