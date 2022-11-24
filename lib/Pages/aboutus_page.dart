import 'package:document_solution/Pages/contact_page.dart';
import 'package:document_solution/helper.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  static const  Map<String,dynamic> service = {
  'id':0,
  'title':'Contact Us',
  'content':'contact us'
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.19,
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.height * 0.09,
                backgroundImage: const AssetImage('assets/images/logo.png'),
              ),
            ),
            const Text(
              'A2Z DOCUMENTATION',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Helper.bgColor,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      //welcome
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text(
                          'WELCOME',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //text
                      const Text(
                        'With great pleasure, We would '
                        'like to introduce ourselves as one of the '
                        'reputed legal documentation firm in the South '
                        'and New Delhi region of Delhi.',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                      //disclaimer
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text(
                          'DISCLAIMER',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //disclaimer text
                      const Text(
                        Helper.disclaimerText,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                      //get in touch
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          'If you Need Any Kind of Consulting Services then '
                              'Fell Free to Contact With us.\n\n'
                              'Email :- a2zdocumentation07@gmail.com\n',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          child: const Text(
                            'CONTACT US',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ContactPage(service: service),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
