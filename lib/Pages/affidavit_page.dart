import 'dart:io';

import 'package:document_solution/Pages/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Models/request_model.dart';
import '../helper.dart';
import '../main.dart';

class AffidavitPage extends StatefulWidget {
  const AffidavitPage({Key? key,required this.service}) : super(key: key);
  final Map<String,dynamic> service;

  @override
  State<AffidavitPage> createState() => _AffidavitPageState();
}

class _AffidavitPageState extends State<AffidavitPage> {

  String selectedArticle = 'Select Article';

  TextEditingController nameController = TextEditingController();
  TextEditingController sonController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController extraController = TextEditingController();

  bool isNameEmpty = false;
  bool isSonEmpty = false;
  bool isAddressEmpty = false;
  bool isNumberEmpty = false;
  bool isEmailEmpty = false;
  bool isExtraEmpty = false;
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
          child: Consumer<Helper>(
            builder: (BuildContext context, value, Widget? child) {
              return Column(
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
                              style: const TextStyle(color: Colors.black,),
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
                  // name
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
                            'Enter Name: ',
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
                            errorText: (isNameEmpty)?"Field can't be Empty":null,
                          ),
                          onChanged: (t) {
                            setState(() {
                              if (nameController.text.isEmpty) {
                                isNameEmpty = true;
                              }else{
                                isNameEmpty = false;
                              }
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  //son/daughter
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
                            'Son/Daughter of: ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextField(
                          controller: sonController,
                          keyboardType: TextInputType.name,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            hintText: 'Enter Son/Daughter of',
                            errorText: (isSonEmpty)?"Field can't be Empty":null,
                          ),
                          onChanged: (t) {
                            setState(() {
                              if (sonController.text.isEmpty) {
                                isSonEmpty = true;
                              }else{
                                isSonEmpty = false;
                              }
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  //Address
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
                            'Address: ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextField(
                          controller: addressController,
                          keyboardType: TextInputType.name,
                          maxLines: 4,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            hintText: 'Enter Address.',
                            errorText: (isAddressEmpty)?"Field can't be Empty":null,
                          ),
                          onChanged: (t) {
                            setState(() {
                              if (addressController.text.isEmpty) {
                                isAddressEmpty = true;
                              }else{
                                isAddressEmpty = false;
                              }
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  //contact
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
                            'Contact No.: ',
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
                            hintText: 'Enter Contact No.',
                            errorText: (isNumberEmpty)?"Field can't be Empty":null,

                          ),
                          onChanged: (t) {
                            setState(() {
                              if (numberController.text.isEmpty) {
                                isNumberEmpty = true;
                              }else{
                                isNumberEmpty = false;
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
                            'Email: ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            hintText: 'Enter Email',
                            errorText: (isEmailEmpty)?"Field can't be Empty":null,

                          ),
                          onChanged: (t) {
                            setState(() {
                              if (emailController.text.isEmpty) {
                                isEmailEmpty = true;
                              }else{
                                isEmailEmpty = false;
                              }
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  //submission
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
                            'Your Submission: ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextField(
                          controller: extraController,
                          keyboardType: TextInputType.name,
                          maxLines: 4,
                          style: const TextStyle(fontSize: 18),
                          decoration:  InputDecoration(
                            hintText: 'Enter Submission Details',
                            errorText: (isExtraEmpty)?"Field can't be Empty":null,
                          ),
                          onChanged: (t) {
                            setState(() {
                              if (extraController.text.isEmpty) {
                                isExtraEmpty = true;
                              }else{
                                isExtraEmpty = false;
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
                  //submit button
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
                        if(!isImageSelected){
                          if(selectedArticle == 'Select Article'){

                          } else if (nameController.text.isEmpty) {
                            setState(() {
                              isNameEmpty = true;
                            });
                          } else if (sonController.text.isEmpty) {
                            setState(() {
                              isSonEmpty = true;
                            });
                          } else if (addressController.text.isEmpty) {
                            setState(() {
                              isAddressEmpty = true;
                            });
                          }else if (numberController.text.isEmpty) {
                            setState(() {
                              isNumberEmpty = true;
                            });
                          } else if (emailController.text.isEmpty) {
                            setState(() {
                              isEmailEmpty = true;
                            });
                          }else if (extraController.text.isEmpty) {
                            setState(() {
                              isExtraEmpty = true;
                            });
                          }else {
                            submitRequest(context,
                              article: selectedArticle,
                              name: nameController.text,
                              sonOf: sonController.text,
                              address: addressController.text,
                              number: numberController.text,
                              email: emailController.text,
                              extra: extraController.text,

                            );
                          }
                        }else{
                          submitImageRequest(value);
                        }

                      },
                    ),
                  )
                ],
              );
            },

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
  String percent='0';

  void submitImageRequest(Helper helper) async {
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

      //store to fire store
      Helper.dbRealtime.child(id).set(request.toJson()).then((value) {
        String message =
            'Service Requested\nUser = ${MyApp.auth.currentUser?.phoneNumber}\nService : $title\nService ID:$id';
        Helper.sendTelegramMessage(
            token: Helper.token, chatId: Helper.chatId, message: message);
        Navigator.pop(context);
        showSuccessDialog(context);
      });
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
        required String name,
        required String sonOf,
        required String address,
        required String number,
        required String email,
        required String extra,}) {
    Helper.showLoadingDialog(context,'Sending Request...');
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    String title = widget.service['title'];
    int time = DateTime.now().millisecondsSinceEpoch;
    AffidavitDetails detail =  AffidavitDetails(name: name, sonOf: sonOf, address: address, number: number, email: email, extra: extra);
    String status = 'Pending';

    RequestModel request = RequestModel(
        id: id, title: title, submittedTime: time,completedTime: 0, detail: detail, status: status);

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
