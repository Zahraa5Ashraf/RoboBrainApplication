// ignore_for_file: camel_case_types, must_be_immutable, use_build_context_synchronously, unnecessary_brace_in_string_interps
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../global.dart';
import '../login/components/body.dart';
import '/models/notifications.dart';

class notifcard extends StatefulWidget {
  const notifcard(
    this.notificationlabel, {
    super.key,
  });
  final Notificationcard notificationlabel;

  @override
  State<notifcard> createState() => _notifcardState();
}

int selectedIndex = -1; // Index of the selected item

class _notifcardState extends State<notifcard> {
  double textsize = 20;

  @override
  Widget build(BuildContext context) {
    Color? color = Colors.grey[100];

    var date = DateTime.parse(widget.notificationlabel.datetime);

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 20,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              prefixIcon(),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: '${widget.notificationlabel.sensorname}: ',
                          style: TextStyle(
                            fontSize: textsize,
                            color: Colors.grey[600],
                          ),
                          children: [
                            TextSpan(
                              text:
                                  ' Emergency detected,\n the sensor value is ${widget.notificationlabel.value.toString()} ',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${date.day}-${date.month}-${date.year}',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${date.hour}:${date.minute}',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 17,
          child: IconButton(
            icon: const Icon(
              Icons.highlight_remove_sharp,
              color: Color.fromARGB(255, 187, 187, 187),
            ),
            onPressed: () {
              delete(widget.notificationlabel.notificationid);
            },
          ),
        ),
      ],
    );
  }

  Widget prefixIcon() {
    return Container(
      height: 50,
      width: 50,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          '${widget.notificationlabel.chairid}',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.blue[200]),
        ),
      ),
      // Icon(
      //   Icons.notification_add,
      //   size: 25,
      //   color: Colors.blue[200],
      // ),
    );
  }

  void delete(int id) async {
    try {
      var url =
          Uri.parse("${Token.server}caregiver/notification/${id.toString()}");
      var response = await http.delete(
        url,
        headers: {
          'content-Type': 'application/json',
          "Authorization": "Token ${token}",
        },
      );
      print(response.body);
      print(response.statusCode);

      if (response.statusCode < 400) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Deleted Successfully')));
      } else {
        showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Text("Failed to Delete"),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
