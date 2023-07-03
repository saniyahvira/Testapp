import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/survey_page.dart';
import 'informed_consent_page.dart';

class UserDemographicsPage extends StatefulWidget {
  @override
  UserDemographicsPageState createState() => UserDemographicsPageState();
}

class UserDemographicsPageState extends State<UserDemographicsPage> {
  int? age;
  String? gender;
  String? name;
  String? location;
  final DateTime today = DateTime.now();

  static const title = 'WillPopScope';

  Future<bool?> showMyDialog() => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Do you want to QUIT?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('No')),
            TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Yes')),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          final shouldPop = await showMyDialog();
          return shouldPop ?? false;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text('Cognition Test'),
              centerTitle: true,
              backgroundColor: Color.fromRGBO(186, 52, 52, 1),
              elevation: 35,
            ),
            body: SafeArea(
              child: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus &&
                      currentFocus.focusedChild != null) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(left: 60, right: 60, top: 40),
                          child: Text(
                            'Please enter your details before starting the test',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                            padding:
                                EdgeInsets.only(left: 25, bottom: 10, top: 20),
                            child: Row(children: <Widget>[
                              Text(
                                'Full name',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.left,
                              )
                            ])),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 0),
                            child: TextField(
                              onChanged: (text) {
                                name = text;
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter your name'),
                            )),
                        Padding(
                            padding:
                                EdgeInsets.only(left: 25, bottom: 10, top: 20),
                            child: Row(children: <Widget>[
                              Text(
                                'Age',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.left,
                              )
                            ])),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 0),
                            child: TextField(
                              keyboardType:
                                  TextInputType.numberWithOptions(signed: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (ageNum) {
                                age = int.parse(ageNum);
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter your age'),
                            )),
                        Padding(
                            padding:
                                EdgeInsets.only(left: 25, bottom: 10, top: 20),
                            child: Row(children: <Widget>[
                              Text(
                                'Location',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.left,
                              )
                            ])),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 0),
                            child: TextField(
                              onChanged: (loc) {
                                location = loc;
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter place of survey & city'),
                            )),
                        Container(height: 50),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffC32C39),
                          fixedSize: const Size(300, 60),
                        ),
                        child: Text(
                          'Continue to Survey',
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute<dynamic>(
                              builder: (context) => SurveyPage(
                                  age: age,
                                  name: name,
                                  location: location,
                                  date: today)));
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 25, right: 25),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'By continuing I confirm that I have read and agree to this',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                            Container(height: 5),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffC32C39),
                                fixedSize: const Size(300, 60),
                              ),
                              child: Text(
                                "Informed Consent",
                                style: TextStyle(fontSize: 18),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute<dynamic>(
                                        builder: (context) =>
                                            InformedConsentPage()));
                              },
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            )),
      );
}
