import 'dart:io';

import 'package:document_solution/Pages/main_page.dart';
import 'package:document_solution/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Models/request_model.dart';
import '../helper.dart';

class RentPage extends StatefulWidget {
  const RentPage({Key? key, required this.service}) : super(key: key);
  final Map<String, dynamic> service;

  @override
  State<RentPage> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  String selectedArticle = 'Select Article';
  List<String> selectedArticleList = [
    'Select Article',
    'Lease upto 5 years [35(ii)]',
    'Lease with security upto 5 years [35(ii)]',
    'Lease Rent deed upto 1 year [35(i)]'
  ];

  TextEditingController ownerController = TextEditingController();
  TextEditingController propertyController = TextEditingController();
  TextEditingController tenautController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController securityController = TextEditingController();
  TextEditingController electricityController = TextEditingController();
  TextEditingController startingController = TextEditingController();
  TextEditingController extraController = TextEditingController();
  bool isOwnerEmpty = false;
  bool isPropertyEmpty = false;
  bool isTenautEmpty = false;
  bool isRentEmpty = false;
  bool isSecurityEmpty = false;
  bool isElectricityEmpty = false;
  bool isStartingEmpty = false;
  bool isExtraEmpty = false;

  String selectedImagePath = '';
  bool isImageSelected = false;
  XFile? file;

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              //select article
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Helper.bgColor,
                ),
                child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedArticle,
                    items: selectedArticleList
                        .map(
                          (String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              softWrap: true,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (d) {
                      setState(() {
                        selectedArticle = d!;
                      });
                    }),
              ),
              //owner detail
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
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
                        'Owner Detail: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: ownerController,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Enter Owner Detail',
                        errorText:
                            (isOwnerEmpty) ? "Field can't be Empty" : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          if (ownerController.text.isNotEmpty) {
                            isOwnerEmpty = false;
                          } else {
                            isOwnerEmpty = true;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              //rental property
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
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
                        'Rental Property Detail:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: propertyController,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(fontSize: 18),
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Enter rental property details',
                        errorText:
                            (isPropertyEmpty) ? "Field can't be Empty" : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          if (propertyController.text.isNotEmpty) {
                            isPropertyEmpty = false;
                          } else {
                            isPropertyEmpty = true;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              //tenant
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
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
                        'Tenant Detail: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: tenautController,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Enter Tenant Detail',
                        errorText:
                            (isTenautEmpty) ? "Field can't be Empty" : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          if (tenautController.text.isNotEmpty) {
                            isTenautEmpty = false;
                          } else {
                            isTenautEmpty = true;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              //rent
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
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
                        'Rent: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: rentController,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Enter Rent',
                        errorText:
                            (isRentEmpty) ? "Field can't be Empty" : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          if (rentController.text.isNotEmpty) {
                            isRentEmpty = false;
                          } else {
                            isRentEmpty = true;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              //security
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
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
                        'Security: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: securityController,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Enter Security',
                        errorText:
                            (isSecurityEmpty) ? "Field can't be Empty" : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          if (securityController.text.isNotEmpty) {
                            isSecurityEmpty = false;
                          } else {
                            isSecurityEmpty = true;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              //amount
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
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
                        'Electricity/Water: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: electricityController,
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Enter Electricity/Water',
                        errorText: (isElectricityEmpty)
                            ? "Field can't be Empty"
                            : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          if (electricityController.text.isNotEmpty) {
                            isElectricityEmpty = false;
                          } else {
                            isElectricityEmpty = true;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              //starting
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
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
                        'Starting From: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: startingController,
                      keyboardType: TextInputType.datetime,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Enter Starting From',
                        errorText:
                            (isStartingEmpty) ? "Field can't be Empty" : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          if (startingController.text.isNotEmpty) {
                            isStartingEmpty = false;
                          } else {
                            isStartingEmpty = true;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              //your submission
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
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
                        'Your submission: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: extraController,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(fontSize: 18),
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Enter Submission details',
                        errorText:
                            (isExtraEmpty) ? "Field can't be Empty" : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          if (extraController.text.isNotEmpty) {
                            isExtraEmpty = false;
                          } else {
                            isExtraEmpty = true;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              //or
              const Text(
                'Or',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              //select image
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
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
                        'Select Image:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (isImageSelected)
                      //selected image
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Image.file(File(selectedImagePath),
                              fit: BoxFit.fitHeight,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Positioned(
                              right: -3,
                              top: -3,
                              child: CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Container(
                                  color: Colors.white,
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedImagePath = '';
                                    isImageSelected = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (!isImageSelected)
                      //upload btn
                      ElevatedButton(
                        child: const Text(
                          'Upload Image',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          selectImage();
                        },
                      ),
                  ],
                ),
              ),
              //note
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Note: If you have all details you can upload image',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              //tnc
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  '\nCourier Charges will be applicable below 1000/-\n'
                      '(Same day Delivery)\n'
                      'T&C apply',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  child: const Text(
                    'SUBMIT REQUEST',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    setState(() {
                      if(!isImageSelected){
                        if (selectedArticle == 'Select Article') {
                          print('no');
                        } else if (ownerController.text.isEmpty) {
                          isOwnerEmpty = true;
                        } else if (propertyController.text.isEmpty) {
                          isPropertyEmpty = true;
                        } else if (tenautController.text.isEmpty) {
                          isTenautEmpty = true;
                        } else if (rentController.text.isEmpty) {
                          isRentEmpty = true;
                        } else if (securityController.text.isEmpty) {
                          isSecurityEmpty = true;
                        } else if (electricityController.text.isEmpty) {
                          isElectricityEmpty = true;
                        } else if (startingController.text.isEmpty) {
                          isStartingEmpty = true;
                        } else if (extraController.text.isEmpty) {
                          isExtraEmpty = true;
                        } else {
                          submitRequest(context,
                              article: selectedArticle,
                              owner: ownerController.text,
                              property: propertyController.text,
                              tenaut: tenautController.text,
                              rent: rentController.text,
                              security: securityController.text,
                              electricity: electricityController.text,
                              starting: startingController.text,
                              extra: extraController.text);
                        }
                      }else{
                        submitImageRequest();
                      }

                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void selectImage() async {
    //selecting image
    file = await Helper.picker.pickImage(source: ImageSource.camera);
    if (file != null) {
      setState(() {
        selectedImagePath = file!.path;
        isImageSelected = true;
      });
    } else {
      isImageSelected = false;
    }
  }

  void submitImageRequest() async {
    if (file != null) {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      var f = File(file!.path);
      var uploadTask = Helper.storage
          .child(widget.service['title'])
          .child(imageName)
          .putFile(f);
      Helper.showUploadingDialog(context, uploadTask);

      var url = await uploadTask.then((p0) {
        return p0.ref.getDownloadURL();
      });
      Navigator.pop(context);

      Helper.showLoadingDialog(context, 'Sending Request...');

      String id = DateTime.now().millisecondsSinceEpoch.toString();
      String title = widget.service['title'];
      int time = DateTime.now().millisecondsSinceEpoch;
      String status = 'Pending';
      Url u = Url(url: url);
      var detail = u;

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
      /*//store to fire store
      Helper.db.doc(id).set(request.toJson()).then((value) {
        Navigator.pop(context);
        showSuccessDialog(context);
      });*/
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            ('image not selected'),
          ),
        ),
      );
    }
  }

  void submitRequest(context,
      {required String article,
      required String owner,
      required String property,
      required String tenaut,
      required String rent,
      required String security,
      required String electricity,
      required String starting,
      required String extra}) {
    Helper.showLoadingDialog(context, 'Sending Request...');
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    String title = widget.service['title'];
    int time = DateTime.now().millisecondsSinceEpoch;
    RentDetails detail = RentDetails(
        article: article,
        owner: owner,
        property: property,
        tenaut: tenaut,
        rent: rent,
        security: security,
        electricity: electricity,
        starting: starting,
        extra: extra);
    String status = 'Pending';

    RequestModel request = RequestModel(
        id: id,
        title: title,
        submittedTime: time,
        completedTime: 0,
        detail: detail,
        status: status);

    //store to fire store
    Helper.dbRealtime.child(id).set(request.toJson()).then((value) {
      String message =
          'Service Requested\nUser = ${MyApp.auth.currentUser?.phoneNumber}\nService : $title\nService ID:$id';
      Helper.sendTelegramMessage(
          token: Helper.token, chatId: Helper.chatId, message: message);
      Navigator.pop(context);
     showSuccessDialog(context);
    });
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
              width: MediaQuery.of(context).size.width,
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
