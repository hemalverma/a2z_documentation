import 'package:document_solution/Pages/service_detail_page.dart';
import 'package:document_solution/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicePage extends StatelessWidget {
  ServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Services',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/appbar.png'),
            fit: BoxFit.cover,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: Helper.serviceList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4 / 2,
                  ),
                  itemBuilder: (context, index) {
                    return CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                                image:
                                    AssetImage('assets/images/documents.png'),
                                fit: BoxFit.cover)),
                        child: Text(
                          Helper.serviceList[index]['title'],
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(service: Helper.serviceList[index]),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
