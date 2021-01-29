import 'package:flutter/material.dart';
import 'package:covid19_tracker/Screens/Signup/components/bodySignUp.dart';
import 'package:covid19_tracker/Screens/Welcome/components/background.dart';
import 'package:covid19_tracker/components/rounded_button.dart';
import 'package:covid19_tracker/constants.dart';
import 'package:covid19_tracker/pages/newsListPage.dart';
import 'package:covid19_tracker/viewmodels/newsArticlesListViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';



class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "COVID-19 TRACKER",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            Image.asset(
              "assets/images/photo6170027057271122818-removebg-preview.png",

              height: size.height * 0.4,
            ),
            SizedBox(height: size.height * 0.05),

            RoundedButton(
              text: "Live News",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChangeNotifierProvider(
                        //  create: (context) {},
                          builder: (_) => NewsArticleListViewModel(),
                          child: NewsListPage());;
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "Update COVID-19 News",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MyNews();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  getMethod() async {
    String theUrl = 'https://covid19trackerdb.000webhostapp.com/get.php';
    var res = await http
        .get(Uri.encodeFull(theUrl), headers: {"Accept": "application/json"});
    var responsBody = json.decode(res.body);
    print(responsBody);
    return responsBody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Update News"),
      ),
      body: FutureBuilder(
        future: getMethod(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List snap = snapshot.data;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error fetching Data"),
            );
          }

          return ListView.builder(
            itemCount: snap.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text("Title: ${snap[index]['newsTitle']}"),
                  subtitle: Text("Content: ${snap[index]['newsContent']}"),
                  onTap: () => print("ListTile"));
            },
          );
        },
      ),
      //body: ListView.builder(
      //    itemCount: data.length,
      //    itemBuilder: (BuildContext context, int index) => ListTile(
      //          title: Text(data[index]['title']),
      //        )),
    );
  }
}


