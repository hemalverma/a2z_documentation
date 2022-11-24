import 'dart:io';

import 'package:document_solution/Models/request_model.dart';
import 'package:document_solution/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../helper.dart';
import 'main_page.dart';

class EstampPage extends StatefulWidget {
  const EstampPage({Key? key, required this.service}) : super(key: key);
  final Map<String, dynamic> service;

  @override
  State<EstampPage> createState() => _EstampPageState();
}

class _EstampPageState extends State<EstampPage> {
  String selectedArticle = 'Select Article';
  TextEditingController purchaseController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  TextEditingController dutyPaidController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController dutyAmountController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  bool isPurchaseEmpty = false;
  bool isDescEmpty = false;
  bool isFirstEmpty = false;
  bool isSecondEmpty = false;
  bool isDutyPaidEmpty = false;
  bool isQuantityEmpty = false;
  bool isDutyAmountEmpty = false;
  bool isNumberEmpty = false;

  bool isImageSelected = false;
  bool imageUploaded = false;
  String selectedImagePath = 'Selected Image';

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
                    items: Helper.estampList
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
              //purchased by
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
                        'Purchased By: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: purchaseController,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Enter Purchased by',
                        errorText:
                            (isPurchaseEmpty) ? "Field can't be Empty" : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          if (purchaseController.text.isNotEmpty) {
                            isPurchaseEmpty = false;
                          } else {
                            isPurchaseEmpty = true;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              //desc
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
                        'Description of  Document: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: descController,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(fontSize: 18),
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Enter Description',
                        errorText:
                            (isDescEmpty) ? "Field can't be Empty" : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          if (descController.text.isNotEmpty) {
                            isDescEmpty = false;
                          } else {
                            isDescEmpty = true;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              //first party
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
                        'First Party: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: firstController,
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Enter First Party.',
                        errorText:
                            (isFirstEmpty) ? "Field can't be Empty" : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          if (firstController.text.isNotEmpty) {
                            isFirstEmpty = false;
                          } else {
                            isFirstEmpty = true;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              //second party
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
                        'Second Party: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: secondController,
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Enter Second Party',
                        errorText:
                            (isSecondEmpty) ? "Field can't be Empty" : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          if (secondController.text.isNotEmpty) {
                            isSecondEmpty = false;
                          } else {
                            isSecondEmpty = true;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              //stamp duty paid by
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
                        'Stamp Duty Paid By: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: dutyPaidController,
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Enter Stamp Duty Paid by',
                        errorText:
                            (isDutyPaidEmpty) ? "Field can't be Empty" : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          if (dutyPaidController.text.isNotEmpty) {
                            isDutyPaidEmpty = false;
                          } else {
                            isDutyAmountEmpty = true;
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
                        'Stamp Duty Amount(Rs): ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: dutyAmountController,
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Enter Amount',
                        errorText:
                            (isDutyAmountEmpty) ? "Field can't be Empty" : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          if (dutyAmountController.text.isNotEmpty) {
                            isDutyAmountEmpty = false;
                          } else {
                            isDutyAmountEmpty = true;
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
                        'Quantity: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Enter Quantity',
                        errorText:
                        (isQuantityEmpty) ? "Field can't be Empty" : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          if (quantityController.text.isNotEmpty) {
                            isQuantityEmpty = false;
                          } else {
                            isQuantityEmpty = true;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              //mobile
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
                        'Mobile No.: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: numberController,
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Enter Mobile No.',
                        errorText:
                            (isNumberEmpty) ? "Field can't be Empty" : null,
                      ),
                      onChanged: (t) {
                        setState(() {
                          if (numberController.text.isNotEmpty) {
                            isNumberEmpty = false;
                          } else {
                            isNumberEmpty = true;
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
              //submit
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
                      if (!isImageSelected) {
                        if (selectedArticle == 'Select Article') {
                          print('no');
                        } else if (purchaseController.text.isEmpty) {
                          isPurchaseEmpty = true;
                        } else if (descController.text.isEmpty) {
                          isDescEmpty = true;
                        } else if (firstController.text.isEmpty) {
                          isFirstEmpty = true;
                        } else if (secondController.text.isEmpty) {
                          isSecondEmpty = true;
                        } else if (dutyPaidController.text.isEmpty) {
                          isDutyPaidEmpty = true;
                        } else if (dutyAmountController.text.isEmpty) {
                          isDutyAmountEmpty = true;
                        } else if (quantityController.text.isEmpty) {
                          isQuantityEmpty = true;
                        }else if (numberController.text.isEmpty) {
                          isNumberEmpty = true;
                        } else {
                          submitRequest(context,
                              article: selectedArticle,
                              purchasedBy: purchaseController.text,
                              desc: descController.text,
                              firstParty: firstController.text,
                              secondParty: secondController.text,
                              dutyPaid: dutyPaidController.text,
                              dutyAmount: dutyAmountController.text,
                              quantity: quantityController.text,
                              number: numberController.text);
                        }
                      } else {
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
      required String purchasedBy,
      required String desc,
      required String firstParty,
      required String secondParty,
      required String dutyPaid,
      required String dutyAmount,
      required String quantity,
      required String number}) {
    Helper.showLoadingDialog(context, 'Sending Request...');
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    String title = widget.service['title'];
    int time = DateTime.now().millisecondsSinceEpoch;
    EstampDetails detail = EstampDetails(
        article: article,
        purchaseBy: purchasedBy,
        desc: desc,
        firstParty: firstParty,
        secondParty: secondParty,
        dutyPaid: dutyPaid,
        dutyAmount: dutyAmount,
        quantity: quantity,
        number: number);
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
