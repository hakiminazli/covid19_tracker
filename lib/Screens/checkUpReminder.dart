import 'package:flutter/material.dart';

class Remainder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          actions: <Widget>[
            Container(
              width: 50,
              margin: EdgeInsets.only(right: 9.0),
              //child: CircleAvatar(
              //  backgroundImage: NetworkImage(""),
              //),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[300],
                  ),
                ),
                color: Colors.white,
              ),
              padding: EdgeInsets.only(left: 15.0, bottom: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Hi, ",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                  ),
                  Text(
                    "Tuesday, Dec 20",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 21,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "UPCOMING APOINTMENTS",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Container(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          AppointmentCard(),
                          //AppointmentCard(),
                          //AppointmentCard(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Text(
                      "REMAINDERS",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          RemainderCard(
                            color: Colors.blue,
                            icon: Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                          ),
                          //RemainderCard(
                          //  color: Colors.blue,
                          //  icon: Icon(
                          //    Icons.calendar_today,
                          //    color: Colors.white,
                          //  ),
                          //),
                          //RemainderCard(
                          //  color: Colors.blue,
                          //  icon: Icon(
                          //    Icons.calendar_today,
                          //    color: Colors.white,
                          //  ),
                          //),
                          //RemainderCard(
                          //  color: Colors.blue,
                          //  icon: Icon(
                          //    Icons.calendar_today,
                          //    color: Colors.white,
                          //  ),
                          //),
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
    );
  }
}

class AppointmentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(11.0),
      padding: EdgeInsets.all(15.0),
      width: 250,
      height: 190,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Doctor",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 21,
          ),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    " ",
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Dr.David",
                      style: TextStyle(fontSize: 23, color: Colors.blueAccent),
                    ),
                    Text(
                      "Clinical Medicine",
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Tomorrow",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                "03:00PM",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RemainderCard extends StatelessWidget {
  final Color color;
  final Icon icon;
  const RemainderCard({Key key, this.color, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey[300], blurRadius: 3.0, offset: Offset(0, 1))
      ]),
      margin: EdgeInsets.symmetric(vertical: 11.0, horizontal: 5.0),
      padding: EdgeInsets.all(11.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: icon,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Checkup Remainder",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    Spacer(),
                    Text(
                      "10:00PM",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "You have a checkup appointment with Dr.David",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      //overflow: TextOverflow.ellipsis,
                      // softWrap: false,
                    ),
                    Spacer(),
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
