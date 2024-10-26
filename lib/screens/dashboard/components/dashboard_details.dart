import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../constants.dart';

class DashboardDetails extends StatelessWidget {
  final String title, text;
  final IconData icons;
  const DashboardDetails(
      {Key? key, required this.title, required this.icons, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 70.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: hoverColor,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 75.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        color: hoverColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(icons),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Column(
                      children: [
                        Text(title),
                        SizedBox(height: 5.0),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(text)
                              .orderBy(Constant.KEY_ITEM_TIMESTAMP,
                                  descending: false)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                height: 18.0,
                                width: 18.0,
                                child: CircularProgressIndicator(
                                  color: hoverColor,
                                ),
                              );
                            } else {
                              int itemCount = snapshot.data!.docs.length;
                              return Text(
                                '$itemCount',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
