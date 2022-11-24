import 'package:document_solution/Pages/contact_page.dart';
import 'package:document_solution/Pages/estamp_page.dart';
import 'package:document_solution/Pages/rent_page.dart';
import 'package:document_solution/helper.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key, required this.service}) : super(key: key);
  Map<String, dynamic> service;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            service['title'],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/appbar.png'),
            fit: BoxFit.cover,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Helper.bgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    service['content'],
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  child: const Text(
                    'SUBMIT REQUEST',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if(service['id']==Helper.homeServiceList[0]['id']){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EstampPage(service: service),
                        ),
                      );
                    }else if(service['id']==Helper.homeServiceList[1]['id']){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RentPage(service: service),
                        ),
                      );
                    }else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactPage(service: service),
                        ),
                      );
                    }

                  }),
            ),
          ],
        ),
      ),
    );
  }
}
