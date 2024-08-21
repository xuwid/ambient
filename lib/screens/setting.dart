import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff161616),
            Color(0xffA427CA),
          ],
          stops: [0.6, 2.7],
          begin: Alignment.bottomCenter, // Start at the bottom
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 150, bottom: 20),
            width: 370,
            height: 51,
            decoration: BoxDecoration(
              //color: Colors.blue,
              color: Color(0x40000000),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              //width: 200,
              //height: 51,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 25,
                        color: Colors.white,
                      )),
                  const Text('AmbientLights Accounts',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      )),
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            width: 370,
            height: 51,
            decoration: BoxDecoration(
              //color: Colors.blue,
              color: Color(0x40000000),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              //width: 200,
              //height: 51,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 25,
                        color: Colors.white,
                      )),
                  const Text('Controllers Setup',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      )),
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            width: 370,
            height: 51,
            decoration: BoxDecoration(
              //color: Colors.blue,
              color: Color(0x40000000),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              //width: 200,
              //height: 51,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 25,
                        color: Colors.white,
                      )),
                  const Text('Zones Setup',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      )),
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            width: 370,
            height: 51,
            decoration: BoxDecoration(
              //color: Colors.blue,
              color: Color(0x40000000),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              //width: 200,
              //height: 51,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 25,
                        color: Colors.white,
                      )),
                  const Text('Time Zone and Location',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      )),
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
