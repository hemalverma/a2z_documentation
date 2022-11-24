import 'package:card_swiper/card_swiper.dart';
import 'package:document_solution/Pages/aboutus_page.dart';
import 'package:document_solution/Pages/advertise_detail_page.dart';
import 'package:document_solution/Pages/affidavit_page.dart';
import 'package:document_solution/Pages/contact_page.dart';
import 'package:document_solution/Pages/rent_page.dart';
import 'package:document_solution/Pages/service_detail_page.dart';
import 'package:document_solution/Pages/service_page.dart';
import 'package:document_solution/Pages/stampduty_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Map<String, dynamic> service = {
    'id': 123453,
    'title': 'Query',
    'content': 'You can contact Contact us'
  };

  Future getImageList() async {
    Helper.imageList.clear();
    await Helper.dbImage.get().then((value) {
      for (var element in value.children) {
        Helper.imageList.add(element.value.toString());
      }
    });
    if(Helper.imageList.isNotEmpty){
      return Helper.imageList;
    }else{
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            //appbar
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.17,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.09,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/images/appbar.png',
                          ),
                          fit: BoxFit.fill),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'NO WON',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          'NO FEES',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.height * 0.067,
                          backgroundImage:
                              const AssetImage('assets/images/logo.png'),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutUsPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //highlights
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Helper.bgColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    child: const Text(
                      'Highlights',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.177,
                    child: FutureBuilder(
                      future: getImageList(),
                      builder: (BuildContext context, snapshot) {
                      if(snapshot.hasData){
                        return Swiper(
                          autoplay: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  Helper.imageList[index],
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ContactPage(service: service),
                                  ),
                                );
                              },
                            );
                          },
                          itemCount: Helper.imageList.length,
                          pagination: const SwiperPagination(),
                          layout: SwiperLayout.DEFAULT,
                        );
                      }else if(snapshot.connectionState==ConnectionState.waiting){
                        return const Center(child: CircularProgressIndicator(),);
                      }else{
                        return const Center(child: Text('No Highlights Available'),);
                      }
                    },
                    ),
                  ),
                ],
              ),
            ),
            //button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                child: const Text(
                  'STAMP DUTY IN DELHI',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StampDutyPage(),
                    ),
                  );
                },
              ),
            ),
            //services
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.279,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Helper.bgColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Services',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        child: const Text(
                          'See All',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServicePage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.22,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CupertinoButton(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width:
                                    MediaQuery.of(context).size.width * 0.422,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/estamp.png'),
                                      fit: BoxFit.cover),
                                ),
                                child: const Text(
                                  'E-Stamp',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                        service: Helper.homeServiceList[0]),
                                  ),
                                );
                              },
                            ),
                            CupertinoButton(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width:
                                    MediaQuery.of(context).size.width * 0.422,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/rentagreement.png'),
                                      fit: BoxFit.cover),
                                ),
                                child: const Text(
                                  'Rent Agreement',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RentPage(
                                        service: Helper.homeServiceList[1]),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CupertinoButton(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width:
                                    MediaQuery.of(context).size.width * 0.422,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/affidavit.png'),
                                      fit: BoxFit.cover),
                                ),
                                child: const Text(
                                  'Affidavit/Agreements',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AffidavitPage(
                                        service: Helper.homeServiceList[2]),
                                  ),
                                );
                              },
                            ),
                            CupertinoButton(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width:
                                    MediaQuery.of(context).size.width * 0.422,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/marrige.png'),
                                      fit: BoxFit.cover),
                                ),
                                child: const Text(
                                  'Marriage Registration',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                        service: Helper.homeServiceList[3]),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //advertise button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                child: const Text(
                  'NEWSPAPER ADVERTISING',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdvertiseDetailPage(),
                    ),
                  );
                },
              ),
            ),
            //share button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'SHARE',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Icon(Icons.share),
                    )
                  ],
                ),
                onPressed: () async{
                  String url = 'https://play.google.com/store/apps/details?id=com.hvx.documentsolution';
                  await Share.share('You can download A2Z Documentation by the link below \n\n$url',subject: 'Share A2Z Documentation');

                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
