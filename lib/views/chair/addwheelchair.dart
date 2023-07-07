// ignore_for_file: use_build_context_synchronously, constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import '../../constants.dart';
import '../global.dart';
import '../login/components/body.dart';
import '../login/components/roundedbutton.dart';
import '../login/components/roundedinputfield.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Addwheelchair extends StatefulWidget {
  const Addwheelchair({Key? key}) : super(key: key);

  @override
  State<Addwheelchair> createState() => _AddwheelchairState();
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: kPlaceholder3,
  backgroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    side: const BorderSide(color: kPrimaryColor),
  ),
  padding: const EdgeInsets.all(10.0),
);

final ButtonStyle raisedButtonStyle2 = ElevatedButton.styleFrom(
  foregroundColor: kPrimaryLightColor,
  backgroundColor: kPrimaryColor,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    side: const BorderSide(color: kPrimaryColor),
  ),
  padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 10, right: 10),
);

enum SingingCharacter { TrackPatient, AddNewWheelchair }

class _AddwheelchairState extends State<Addwheelchair> {
  String idchair = '';
  String pfirstname = '';
  String plastname = '';
  String ppass = '';
  String page = '';
  String pgender = '';
  String dropdownValue = 'Male';
  SingingCharacter? _character = SingingCharacter.TrackPatient;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ButtonStyle flatbuttonstyle = TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 40,
      ),
      backgroundColor: kPrimaryColor,
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          'Track Wheelchairs',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/animatedbackground.gif'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Column(
                children: <Widget>[
                  ListTile(
                    title: const Text(
                      'Track Patient',
                      style: TextStyle(fontSize: 19, color: ktextcolor1),
                    ),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.TrackPatient,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Add New Wheelchair',
                      style: TextStyle(fontSize: 19, color: ktextcolor1),
                    ),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.AddNewWheelchair,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (_character == SingingCharacter.TrackPatient)
                Column(
                  children: [
                    RoundedInputField(
                      action: TextInputAction.go,
                      onchanged: ((value) {
                        setState(() {
                          idchair = value;
                        });
                      }),
                      controller: null,
                      hinttext: 'Chair ID',
                      icon: Icons.wheelchair_pickup,
                      validateStatus: (value) {
                        return null;
                      },
                      type: TextInputType.number,
                    ),
                    RoundedInputField(
                      action: TextInputAction.go,
                      onchanged: ((value) {
                        setState(() {
                          ppass = value;
                        });
                      }),
                      controller: null,
                      hinttext: 'Password',
                      icon: Icons.lock,
                      validateStatus: (value) {
                        return null;
                      },
                      type: TextInputType.text,
                    ),
                    const SizedBox(height: 10),
                    roundedbutton(
                        size: size,
                        flatbuttonstyle: flatbuttonstyle,
                        text: 'Save',
                        textcolor: Colors.white,
                        press: () {
                          _save2();
                        }),
                  ],
                ),
              if (_character == SingingCharacter.AddNewWheelchair)
                Column(
                  children: [
                    RoundedInputField(
                      action: TextInputAction.go,
                      onchanged: ((value) {
                        setState(() {
                          idchair = value;
                        });
                      }),
                      controller: null,
                      hinttext: 'Chair ID',
                      icon: Icons.wheelchair_pickup,
                      validateStatus: (value) {
                        return null;
                      },
                      type: TextInputType.number,
                    ),
                    RoundedInputField(
                      action: TextInputAction.go,
                      onchanged: ((value) {
                        setState(() {
                          ppass = value;
                        });
                      }),
                      controller: null,
                      hinttext: 'Password',
                      icon: Icons.lock,
                      validateStatus: (value) {
                        return null;
                      },
                      type: TextInputType.text,
                    ),
                    RoundedInputField(
                      action: TextInputAction.go,
                      onchanged: ((value) {
                        setState(() {
                          pfirstname = value;
                        });
                      }),
                      controller: null,
                      hinttext: 'First name',
                      icon: Icons.person,
                      validateStatus: (value) {
                        return null;
                      },
                      type: TextInputType.text,
                    ),
                    RoundedInputField(
                      action: TextInputAction.go,
                      onchanged: ((value) {
                        setState(() {
                          plastname = value;
                        });
                      }),
                      controller: null,
                      hinttext: 'Last name',
                      icon: Icons.person,
                      validateStatus: (value) {
                        return null;
                      },
                      type: TextInputType.text,
                    ),
                    RoundedInputField(
                      action: TextInputAction.go,
                      onchanged: ((value) {
                        setState(() {
                          page = value;
                        });
                      }),
                      controller: null,
                      hinttext: 'Age',
                      icon: Icons.app_registration_sharp,
                      validateStatus: (value) {
                        return null;
                      },
                      type: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 315,
                      height: 60,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                const BorderSide(color: Colors.white, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                const BorderSide(color: Colors.white, width: 1),
                          ),
                          filled: true,
                          fillColor: kPrimaryLightColor,
                        ),
                        dropdownColor: kPrimaryLightColor,
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                            pgender = newValue;
                            //      print(pgender);
                          });
                        },
                        items: <String>['Male', 'Female']
                            .map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    fontSize: 15, color: ktextcolor2),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    roundedbutton(
                        size: size,
                        flatbuttonstyle: flatbuttonstyle,
                        text: 'Save',
                        textcolor: Colors.white,
                        press: () {
                          _save();
                          // setState(() {
                          //   //  items[index].title = idchair;
                          // });
                        }),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _save() async {
    /* UNCOMMENT WHEN SERVER ONLINE */
    Map<String, dynamic> body = {
      "chair_id": idchair,
      "password": ppass,
      "first_name": pfirstname,
      "last_name": plastname,
      "age": page,
      "gender": pgender,
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    var url = Uri.parse("${Token.server}patient/info");

    var response = await http.post(url,
        headers: {
          'content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
        body: jsonBody,
        encoding: encoding);
    print(response.body);
    if (response.statusCode == 201) {
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text(
                  "patient is added successfully",
                  style: TextStyle(color: Colors.greenAccent),
                ),
              ));
      setState(() {
        Navigator.pop(context);
      });
    } else if (response.statusCode == 400) {
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text(
                  "this chair is already in use",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ));
    } else {
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text(
                  "Chair ID or Password is Invalid",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ));
    }
    // print(data);
    // print(response.statusCode);
  }

  void _save2() async {
    /* UNCOMMENT WHEN SERVER ONLINE */
    Map<String, dynamic> body = {
      "chair_id": idchair,
      "password": ppass,
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    var url = Uri.parse("${Token.server}patient/track");

    var response = await http.post(url,
        headers: {
          'content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
        body: jsonBody,
        encoding: encoding);

    print(response.body);
    //  print(response.statusCode);
    if (response.statusCode == 404) {
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text(
                  "No Patient currently use this chair.",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ));
    } else if (response.statusCode == 400) {
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text(
                  "Chair ID or Password Invalid",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ));
    } else {
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text(
                  "patient is added successfully",
                  style: TextStyle(color: Colors.greenAccent),
                ),
              ));
      setState(() {
        Navigator.pop(context);
      });
    }
  }
}

Future<dynamic> ShowDialogChair(
    BuildContext context, Size size, ButtonStyle flatbuttonstyle) {
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Center(
                  child: Text(
                'Fill in patient\'s data',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              )),
              roundedbutton(
                  size: size,
                  flatbuttonstyle: flatbuttonstyle,
                  text: 'Save',
                  textcolor: Colors.white,
                  press: () {
                    // _save();
                    // setState(() {
                    //   //  items[index].title = idchair;
                    // });
                  })
            ],
          ),
        ),
      ],
    ),
  );
}
