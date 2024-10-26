import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:madina_pos_system/model/res/widget/text_widget.dart';
import 'package:madina_pos_system/screens/sideMenu/main_screen.dart';


class AdminLoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLoginScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserValues();
  }

  var blackColor = Colors.black;
  var button1Color = Colors.amber;
  var button2Color = Colors.grey;

  var myFormkey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  var headText = "Admin Panal Login";

  final collectRef = FirebaseFirestore.instance.collection("AdminAccess");
  final employeeCollectRef =
  FirebaseFirestore.instance.collection("EmployeeAccess");

  var username = "",
      password = "",
      employeeUsername = "",
      employeePassword = "";
  bool editFocus = true, isAdmin = true, isEmployee = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/splash_background.png"),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
                Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.amber.withOpacity(0.6),
                  child: Center(
                    child: Container(
                        padding: EdgeInsets.all(40.0),
                        child: TextWidget(text: "Madina POS Sytem", color: Colors.black, size: 25, isBold: true)
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(21)),
                    ),
                      child: TextWidget(text: "Madina POS Sytem", color: Colors.black, size: 16, isBold: false)
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              button1Color = Colors.amber;
                              button2Color = Colors.grey;
                              editFocus;
                              isAdmin = true;
                              isEmployee = false;
                              headText = "Admin Login panal";
                            });
                          },
                          child: Container(
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: button1Color),
                            padding: EdgeInsets.all(10.0),
                            child: Center(child: Text("Admin")),
                          ),
                        ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //     setState(() {
                        //       button1Color = Colors.grey;
                        //       button2Color = Colors.amber;
                        //       editFocus;
                        //       isAdmin = false;
                        //       isEmployee = true;
                        //       headText = "Employee Login panal";
                        //     });
                        //   },
                        //   child: Container(
                        //     width: 200,
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10.0),
                        //         color: button2Color),
                        //     padding: EdgeInsets.all(10.0),
                        //     child: Center(child: Text("Employee")),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    headText,
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.amber,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      color: Colors.transparent,
                      width: 400,
                      child: Form(
                          key: myFormkey,
                          child: Column(
                            children: <Widget>[
                              //username
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: userNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter Username";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      hintText: "Username",
                                      hintStyle: const TextStyle(
                                        fontSize: 12,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5.0))),
                                ),
                              ),
                              //password
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter Password";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Password",
                                      hintText: "Password",
                                      hintStyle: const TextStyle(
                                        fontSize: 12,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5.0))),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 300,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(21)),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (isAdmin) {
                          if (username == userNameController.text.toString()) {
                            if (password == passwordController.text.toString()) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  MainScreen(),
                                  ));
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Invalid Password",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "invalid Username",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  void getUserValues() {
    collectRef.doc("admindetails").get().then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        username = snapshot.get("username");
        password = snapshot.get("password");
      }
    });
  }
}
