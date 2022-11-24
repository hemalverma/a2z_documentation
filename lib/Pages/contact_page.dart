import 'package:document_solution/Models/request_model.dart';
import 'package:document_solution/Pages/main_page.dart';
import 'package:document_solution/helper.dart';
import 'package:document_solution/main.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key, required this.service}) : super(key: key);
  final Map<String, dynamic> service;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController numberController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController detailController = TextEditingController();

  bool isNameEmpty = false;

  bool isNumEmpty = false;

  bool isEmailEmpty = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.service['title'],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/appbar.png'),
            fit: BoxFit.cover,
          ),
        ),
        //appbar
        body: SingleChildScrollView(
          child: Column(
            children: [
              //name
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Helper.bgColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: const Text(
                        'Your Name: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Enter Name',
                        errorText: (isNameEmpty) ? "Name can't be Empty" : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          isNameEmpty = false;
                          if (nameController.text.isEmpty) {
                            isNameEmpty = true;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              //number
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Helper.bgColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: const Text(
                        'Contact Number: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: numberController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Enter Contact No.',
                        errorText:
                        (isNumEmpty) ? "Number can't be Empty" : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          isNumEmpty = false;
                          if (numberController.text.isEmpty) {
                            isNumEmpty = true;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              //mail
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Helper.bgColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: const Text(
                        'Your Email: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Enter Email.',
                        errorText:
                        (isEmailEmpty) ? "Email can't be Empty" : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          isEmailEmpty = false;
                          if (emailController.text.isEmpty) {
                            isEmailEmpty = true;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Helper.bgColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: const Text(
                        'Your Submission: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: detailController,
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 4,
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                        hintText: 'Submission details.',
                      ),
                      onChanged: (t) {},
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 50,
                child: ElevatedButton(
                  child: const Text(
                    'SUBMIT REQUEST',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (nameController.text.isEmpty) {
                      setState(() {
                        isNameEmpty = true;
                      });
                    } else if (numberController.text.isEmpty) {
                      setState(() {
                        isNumEmpty = true;
                      });
                    } else if (emailController.text.isEmpty) {
                      setState(() {
                        isEmailEmpty = true;
                      });
                    } else {
                      submitRequest(context,
                          name: nameController.text,
                          number: numberController.text,
                          email: emailController.text,
                          extra: detailController.text);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void submitRequest(context,
      {required String name,
        required String number,
        required String email,
        required String extra}) {
    Helper.showLoadingDialog(context, 'Sending Request...');
    String id = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    String title = widget.service['title'];
    int time = DateTime
        .now()
        .millisecondsSinceEpoch;
    Details detail =
    Details(name: name, number: number, email: email, extra: extra);
    String status = 'Pending';

    RequestModel request = RequestModel(
        id: id,
        title: title,
        submittedTime: time,
        completedTime: 0,
        detail: detail,
        status: status);

    //store to db
    Helper.dbRealtime.child(id).set(request.toJson()).then((value) {
      String message =
          'Service Requested\nUser = ${MyApp.auth.currentUser?.phoneNumber}\nService : $title\nService ID:$id';
      Helper.sendTelegramMessage(
          token: Helper.token, chatId: Helper.chatId, message: message);
      Navigator.pop(context);
      showSuccessDialog(context);
    });

    //store to fire store
    /*Helper.db
        .doc(id)
        .set(request.toJson())
        .then((value) {
      Navigator.pop(context);
      showSuccessDialog(context);
    });*/
  }

  void showSuccessDialog(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(15),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(15),
                  color: Helper.bgColor),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Your Details has been submitted successfully',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: const Text(
                      'Service Provider will call you shortly',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainPage(),
                            ),
                                (r) => false);
                      }),
                ],
              ),
            ),
          );
        });
  }
}
