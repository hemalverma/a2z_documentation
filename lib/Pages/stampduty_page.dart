import 'package:flutter/material.dart';

class StampDutyPage extends StatelessWidget {
  StampDutyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Stamp Duty in Delhi',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/appbar.png'),
            fit: BoxFit.cover,
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: InteractiveViewer(
            maxScale: 3,
            child: Image.asset(
              'assets/images/stampduty.jpeg',
              fit: BoxFit.fitWidth,
            ),),
        ),
      ),
    );
  }

}
