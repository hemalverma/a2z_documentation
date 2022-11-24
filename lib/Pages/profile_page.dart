import 'package:document_solution/Models/request_model.dart';
import 'package:document_solution/Pages/login_page.dart';
import 'package:document_solution/helper.dart';
import 'package:document_solution/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isRequestCompleted = false;
  Query query = Helper.dbRealtime;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'MY PROFILE',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      '${MyApp.auth.currentUser?.phoneNumber}',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: const Text(
                'My Requests',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
            ),

            //show requests
            Expanded(
              child: Card(
                  color: Helper.bgColor,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: FirebaseAnimatedList(
                    query: query,
                    defaultChild: const Center(child: CircularProgressIndicator(),),
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      if (!snapshot.exists) {
                        return const Center(child: Text('No requests'));
                      } else {
                        Map requests = snapshot.value as Map;
                        final r = RequestModel.fromJson(requests);
                        return buildRequest(r);
                      }
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRequest(RequestModel request) {
    final date = DateTime.fromMillisecondsSinceEpoch(request.submittedTime);
    final day = date.day;
    final month = date.month;
    final year = date.year;
    if (request.status == 'Completed') {
      isRequestCompleted = true;
    } else {
      isRequestCompleted = false;
    }
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: ListTile(
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            )),
        tileColor: Colors.white,
        title: Text(request.title),
        subtitle: Text('Date: $day-$month-$year'),
        trailing: statusImage(request.status),
      ),
    );
  }



  Widget statusImage(status) {
    if (status == 'Accepted') {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/icons/accepted.png',
            height: 35,
            width: 35,
          ),
          Text(status)
        ],
      );
    } else if (status == 'Rejected') {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/icons/rejected.png',
            height: 35,
            width: 35,
          ),
          Text(status)
        ],
      );
    } else if (status == 'Completed') {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/icons/completed.png',
            height: 35,
            width: 35,
          ),
          Text(status)
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/icons/pending.png',
            height: 35,
            width: 35,
          ),
          Text(status)
        ],
      );
    }
  }

  void logout(context) {
    setState(() {
      MyApp.auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    });
  }
}
