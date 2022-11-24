import 'package:document_solution/Pages/advertise_page.dart';
import 'package:flutter/material.dart';

class AdvertiseDetailPage extends StatefulWidget {
  const AdvertiseDetailPage({Key? key}) : super(key: key);

  @override
  State<AdvertiseDetailPage> createState() => _AdvertiseDetailPageState();
}

class _AdvertiseDetailPageState extends State<AdvertiseDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Advertising Details',
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
              child: InteractiveViewer(
                maxScale: 5,
                  child: Image.asset(
                'assets/images/ads_detail.jpeg',
                fit: BoxFit.fitWidth,
              ),),
            ),
            const SizedBox(
              height: 30,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdvertisePage(),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
