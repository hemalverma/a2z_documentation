import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document_solution/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';


class Helper with ChangeNotifier{
  static const token = '5537866108:AAF64gFE6qgQP2f2vDTBVyopurUI-PkE-Yg';
  static const chatId = '-1001612206798';

  static const  Color bgColor = Color(0xFFD9D9D9);
  static final storage = FirebaseStorage.instance.ref('Clients/${MyApp.auth.currentUser!.phoneNumber}/Requests');

  static final DatabaseReference dbImage = FirebaseDatabase.instance.ref('Images');
  static final DatabaseReference dbRealtime = FirebaseDatabase.instance.ref('Clients/${MyApp.auth.currentUser?.phoneNumber}/Requests');
  static final List<String> imageList = [];

  static final picker = ImagePicker();

  static final db = FirebaseFirestore.instance
      .collection('Clients')
      .doc(MyApp.auth.currentUser?.phoneNumber)
      .collection('Requests');

  static void showLoadingDialog(context,text) {
    AlertDialog alertDialog = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.all(10),
            child: Text(text),
          )
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }


  static void showUploadingDialog(context,UploadTask task) {
    String? percent;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              task.snapshotEvents.listen((event) {
                setState((){
                  percent = 'Uploading... (${((event.bytesTransferred/event.totalBytes)*100).toStringAsFixed(2)} %)';
                });
              });

              return AlertDialog(
                content: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(percent ??'Uploading... (0.00 %)'),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  static sendTelegramMessage({chatId,token,message})async {
    final username = (await Telegram(token).getMe()).username;
    TeleDart telDart = TeleDart(token, Event(username!));
    telDart.sendMessage(chatId, message);
  }
  static final List<Map<String,dynamic>> serviceList = [
    {
      'id':0,
      'title':'Lease Hold to Free Hold',
      'content':'Freehold is a way to transfer the ownership of the property '
          'from Government Authority to private person. It enhances the duty '
          'of the property. A Conveyance Deed is given as a final document to '
          'the owner which is the registry of property in common parlance.\n\n '
          'For conversion from leasehold to freehold, one needs to apply to the'
          ' concerned authority in prescribed format. Our services in this '
          'regard include Consultancy and documentation required for the '
          'application. We guide you through the entire process of Freehold '
          'from beginning to the end. During the whole process, all your '
          'documentations needs are taken care off and all these are available '
          'at nominal & reasonable service charges.\n\n'
          'To get your property converted into Freehold, you require '
          'photocopies of certain document which varies depending upon type of '
          'property (residential, industrial etc.) and concerned authority '
          '(DDA).\n\n'
          'Generally, the copies of following documents are required:\n'
          'Letters of allotment, allocation\n'
          'Possession letter and Possession slip\n'
          'Perpetual Lease Deed (if any)\n'
          'Possession proof such as Electricity Bill, Water Bill\n'
          'Photographs\n\n'
          'Bank challans regarding payment of installments, Ground Rent, '
          'Service Charges etc\n\n'
          'Original documents like Indemnity Bond, Affidavit, Undertaking (on '
          'Non-Judicial Stamp Paper) together with duly filled application form '
          'for freehold\n\n'
          'Beyond these documents, applicable conversion charges and requisite '
          'stamp duty has to be paid.'

    },
    {
      'id':1,
      'title':'Sale Deed',
      'content':'Sale Deed is a document which is registered for sale of '
          'property in case of freehold properties. However, it may be '
          'registered in certain leasehold properties also where there is such '
          'provision. It grants clear title & complete ownership to the buyer/'
          'purchaser. It is compulsorily registered when transaction is for '
          'consideration between two persons.'
    },
    {
      'id':2,
      'title':'Certified Copy',
      'content':'Certify copy of a document is treated '
          'equivalent to the original document itself. If the original document is '
          'lost/misplaced/ torn/mutilated etc., its certify copy will work as '
          'substitute for original document. You can get the certify copy of all '
          'the registered documents from the office of the Sub-Registrar where the '
          'document was registered.\n\n'
          'To get the certify copy, it is necessary to have the registration '
          'number, book number, volume number, page numbers and date of '
          'registration of the document together with Sub-Registrar\'s office.\n\n'
          'We help you to locate the document and obtain the certify from the '
          'concerned Sub-Registrar office. If you have incomplete details of the '
          'document, we will help to trace the document and search for it from the '
          'concerned sub-registrar office.\n\n'
          'PROCESS\n'
          'Write an application to the concerned Sub-Registrar '
          'Office mentioning the registration number, '
          'book number, page numbers, volume number and '
          'the date of registration of document together. '
          'Attach a stamp paper of Rs. 10/- and paste court '
          'fee on application.'
    },

    {
      'id':3,
      'title':'Agreement to Sell',
      'content':'Agreement to Sell or Deed of Agreement is registered for sale '
          'of leasehold property or when there is a promise to transfer in '
          'future. As the name specifies, Agreement to Sell is registered when '
          'the seller is not the absolute owner of the property & agrees to '
          'sell the property as the title vests with the government. Thus, it '
          'is agreed between the parties that whenever, in future, the clear '
          'title shall be given by the government, the concerned property shall '
          'be sold to the intended purchaser.'
    },
    {
      'id':4,
      'title':'Power of Attorney',
      'content':'Power of Attorney is a document which grants the general/'
          'specific powers to the person in whose favor the document is '
          'executed. It can be related to a specific property or specific acts '
          'or both. A Power of Attorney having specifically few powers is '
          'called Special Power of Attorney (SPA) and that having generally '
          'all the powers are called the General Power of Attorney (GPA). In '
          'Both cases, attorney Holder is entitled to act on behalf of the '
          'Principal owner.'
    },
    {
      'id':5,
      'title':'Relinquishment Deed',
      'content':'Relinquishment Deed is a document whereby a person releases '
          'his share or claim in a property. When the owner of a property dies '
          'and his/her legal heirs agree to relinquish (leave) their respective '
          'share of the concerned property in favor of one or more of the legal '
          'heirs, this document is made.'
    },
    {
      'id':6,
      'title':'Rectification Deed',
      'content':'When a document has been registered in the office of the '
          'Sub-Registrar and a mistake has been found in the same after it has '
          'been registered, it can be corrected only through Rectification '
          'Deed duly registered in the office of Sub-Registrar.'
    },
    {
      'id':7,
      'title':'Lease Deed',
      'content':'A Lease of immoveable property is a transfer of a right to '
          'enjoy such property, made for a certain time, or in perpetuity, in '
          'consideration of a price. It is compulsory to register Lease Deed '
          'when the monthly rent of the property is more than Rs. 3,500/- per '
          'month or lease is for a period more than one year.'
    },
    {
      'id':8,
      'title':'Gift Deed',
      'content':'Gift Deed is safest and surest way to transfer your property '
          'in your lifetime. It assures clear title to the donee(to whom gift '
          'is made) without interference of other persons.'
    },

    {
      'id':9,
      'title':'Partition Deed',
      'content':'Partition Deed is registered for partition of the property. '
          'Partition is mutually agreed between the owners of the property and '
          'their respective proportions are outlined and specified in the '
          'Partition Deed so as to divide the property.'
    },

    {
      'id':10,
      'title':'Trust Deed',
      'content':'A trust is an obligation annexed to the ownership of the '
          'property, and arising out of a confidence reposed in and accepted by '
          'the owner, or declared and accepted by him for the benefit of '
          'another, or of another and the owner. Trust Deed is registered for '
          'creating a trust. It is registered through Settlor/Author. The '
          'Settlor may appoint any number of Trustees to look after the Trust '
          'and its activities. There are Public charitable trusts and Private '
          'Trusts for the benefit of few but the essence lies that the confidence'
          ' is reposed for the benefit of others.'
    },
    {
      'id':11,
      'title':'Cancellation of Documents',
      'content':'Some registered documents can be cancelled at the wish of the '
          'executor of the document such as Power of Attorney and Will through '
          'a Cancellation or Revocation Deed.'
    },
    {
      'id':12,
      'title':'Partnership Deed',
      'content':'Partnership is the relation between persons who have agreed '
          'to share the profits of a business carried on by all or any of them '
          'acting for all. Persons who have entered into partnership with one '
          'another are called individually \'partners\' and collectively a '
          '\'Firm\' and the name under which their business is carried on is '
          'called the firm name. Partnership Deed is registered for creating '
          'Partnership Firm. It needs minimum two partners.'
    },
    {
      'id':13,
      'title':'Assignment Deed',
      'content':'Assignment Deed in general can be registered for assignment '
          'of any property. It is commonly used for transfer of a liability/'
          'debt. The purchaser in this case steps into the shoes of the '
          'transferor and has all such rights which the transferor has. The '
          'purchaser is entitled to amount due under a loan agreement and all '
          'such legal remedies to which the transferor was entitled. It can '
          'also be registered when a leased property is sold to a third party.'
    },

    {
      'id':14,
      'title':'Indemnity Bond',
      'content':'Under India Contract Act, section 124 provides that Indemnity '
          'is a specific contract, a purpose whereof is to extend promise to '
          'save other party from loss caused to him from the acts of the one '
          'executing the bond.'
    },
    {
      'id':15,
      'title':'Will',
      'content':'Will means the declaration of the intention of a testator with '
          'respect to his property which he desires to be carried in to effect '
          'after his death. Though the registration of Will is not mandatory '
          'but a registered Will is the preferable mode to transfer your '
          'property and assets as per your wish. You can specify the division '
          'of your property and assets as per your wish.'
    },
    {
      'id':16,
      'title':'Passport Assistance',
      'content':'A passport is an official identification document issued by '
    'your own government. It includes your photo, name, address, date, and '
    'place of birth, as well as blank pages for travel stamps. '
    'Immigration officials will stamp those pages for approval every time you '
    'enter and exit a different country.\n\n'
    'A U.S. passport is required to travel between the United States and all '
    'foreign countries. In certain parts of Europe, however, you can travel '
    'from one country to another without a passport. Even without a passport,'
    'you’ll always need to show identification. In some cases, you’ll need to '
    'show proof of your nationality.\n\n'
    'Then Schengen Agreement, signed in 1985, allows people to travel freely '
    'between 26 countries without a passport. Be aware that most airlines do '
    'require a passport for travel, even if the countries you’re traveling '
    'between don’t.\n\n'
          'If you’re planning to travel outside your home country, it’s always '
          'best to have a passport. Without one, immigration and customs '
          'officials can deny you entry or exit.'
    },
    {
      'id':17,
      'title':'Visa Processing',
      'content':'A visa is an official document issued by a foreign government '
    'that permits entry into their country. Visas have various expiration '
    'dates. They may be 10 days, 30 days, or 60 days – or longer. Once your '
    'visa expires, you will no longer be able to stay legally in that '
    'country. Visa requirements may be different from one country to the next. '
    'In some countries, a transit visa, business visa, student visa, or '
    'employment visa might be necessary.\n\n'
    'And sometimes, there are places you can travel to without a visa.\n\n'
          'For example, US citizens can spend up to 90 days (for tourism or '
          'business) in dozens of countries without a visa. Some of those '
          'countries include most parts of Europe, Canada, Mexico, and South '
          'America. United States citizens can visit the United Kingdom for '
          'tourism or business for up to six months without a visa.'
    },

    {
      'id':18,
      'title':'Conveyance Deed',
      'content':'Conveyance Deed technically means any document through which '
          'a property is transferred from one person to another. However, in '
          'common usage it is a document which is registered when title of '
          'property is transferred from government to a person. It grants '
          'freehold status to the property.'
    },
    {
      'id':19,
      'title':'Pan Card',
      'content':'A PAN card, like an Aadhar card or a Voter IT Card, is one of '
    'the most important documents required to complete any major task. While '
    'you are most likely familiar with what a PAN card is and how it is used, '
    'there are a few things you should know about a PAN card.\n\n'
    'Continue reading to learn more about what a PAN card is, the eligibility '
    'requirements for applying for one, the different types of PAN cards, and '
    'how to apply for one.\n\n'
    'What is a PAN Card?\n\n'
    'PAN  is an abbreviation of Permanent Account Number. The Income Tax '
    'Department of India assigns an alphanumeric, 10-digit unique number to '
    'each taxpayer. Each PAN number is unique and different for each individual.\n\n'
    'The PAN number keeps track of a person’s financial activities and is '
    'required for all forms of payment.\n\n'
    'A PAN card appears to be a physical plastic card with one’s PAN number, '
    'name, DOB, and a photograph printed on it.\n\n'
          'The PAN number is valid for life because it is unaffected by changes '
          'in address or job profile and can thus be used as proof of identity.\n\n'
          'Structure of a PAN Card\n\n'
          'A PAN card is much more than just a card with the user’s basic '
          'information. It is designed in such a way that each special '
          'character, alphabet, and so on define various different things '
          'written on it. The following is an example of a PAN card structure:\n'
    },
    {
      'id':20,
      'title':'Legal Heir Certificate',
      'content':'Every family legacy has to be treasured to preserve the family '
    'tradition. Legacies are left behind by the forefathers of a family as an '
    'identity of one’s family. When the head of the family passes away, the '
    'legacy has to be inherited by the next direct legal heir of the deceased. '
    'In order to assure the right legal heir, a verified certificate is issued '
    'called a Legal Heir Certificate.\n\n'
    'The legal heir certificate consists of details like name, age, '
    'relationship with the deceased and marital status of all surviving family '
    'members. This article discusses the application procedure to obtain a '
    'legal heir certificate in Delhi.\n\n'
    'Need for the document\n\n'
    'On the sudden demise of the head of the family, the family properties '
    'have to be carried by the next person. This is mainly because to cherish '
    'the family tradition. There are other reasons for which this certificate '
    'can be used. They are to transfer electricity connection, house tax, '
    'telephone connection/patta transfer, bank account, etc. In addition to '
    'this, when a government employee passes away, the certificate is required '
    'to obtain a family pension and to get an appointment on compassionate '
    'grounds.\n\n'
    'Benefits of the document\n'
    'The following are the benefits of the document.\n\n'
    '•	To declare the relationship between the deceased and the heir.\n'
    '•	To avail insurances, pension, retirement benefits, service benefits, '
    'provident fund,  gratuity, etc.\n'
    '•	To get employment, for example, compassionate appointments.\n'
    '•	To benefit from other government schemes.\n\n'
    'Required Documents\n\n'
    'To apply for a legal heir certificate, one has to possess the following '
    'documents:\n\n'
    '•	Duly filled application form\n'
    '•	Death certificate\n'
    '•	Identity Card\n'
    '•	Ration card\n'
    '•	Aadhaar Card\n'
    '•	Ration Card\n\n'
    'Eligible Heirs\n\n'
    'Any family members of the deceased are eligible to apply for a legal heir '
    'certificate. It can be any of the following:\n\n'
    '•	Husband of the deceased\n'
    '•	Son of the deceased\n'
    '•	Daughter of the deceased\n'
    '•	Mother of the deceased\n\n'
    'Required Information\n\n'
    'Given below are the required information that has to be known about the '
    'deceased:\n\n'
    '•	Name of the deceased\n'
    '•	Details of the family members\n'
    '•	Applicant’s signature\n'
    '•	Application date\n'
    '•	Residential Address\n\n'
    'Application Procedure\n\n'
          'The application procedure to obtain a legal heir certificate is as '
          'follows. This certificate can be applied only by the legal heirs '
          'after obtaining the death certificate.'
    },
    {
      'id':21,
      'title':'Adoption Deed',
      'content':'Adoption Deed is required for adopting a child. It is '
          'executed by natural parents of the child in favor of adopting '
          'parents. Rules differ according to the religion of the parents. '
          'In respect of the Hindus, it is an essential part of the process '
          'of adoption as per the Act and rules in this regard.'
    },
    {
      'id':22,
      'title':'Others',
      'content':'If your service is not mentioned here. You can directly explain '
          'the service to the service provider \n\n'
          'You can contact to get completed your service'
    },
  ];

  static final List<Map<String,dynamic>> homeServiceList = [
    {
      'id':123450,
      'title':'E-Stamp',
      'content':'Stamp Duty is a payment to the government for the transaction '
          'related to property which is taking place. A Schedule in this regard '
          'has been published by the government stating stamp duty on various '
          'transaction and documents. One may pay the stamp duty either though '
          'E-stamp or E-Stamp Vendor.\n\nWe provide services for both modes of '
          'paying stamp duty.'

    },
    {
      'id':123451,
      'title':'Rent Agreement',
      'content':''
    },
    {
      'id':123452,
      'title':'Affidavit or Agreements',
      'content':''
    },
    {
      'id':123453,
      'title':'Marriage Registration',
      'content':'DELHI MARRIAGE CERTIFICATE\nThe marriage certificate is a '
    'legal document evidencing marriage that has taken place between a bride '
    'and a groom. A marriage certificate can prove to be useful while applying '
    'for many other government documents after marriage like PAN, Passport, '
    'and Visa etc. In this article, we look at the procedure for a marriage '
    'certificate in Delhi and the documents required.\n\nRequirement\n'
    '•	The Groom must be 21 years of age\n'
    '•	The Bride must be 18 years of age\n'
    '•	Documents as listed below\n'
    '•	Affidavits\n'
    '•	Two witnesses (Three in case of marriage through the Special Marriage Act).'
    },
  ];

  static final List<String> estampList = [
    'Select Article',
    'Acknowledgement of a debt [1]',
    'Additional Copy of document [25]',
    'Adoption [3]',
    'Affidavit [4]',
    'Agreement relating to deposit of title deed [6(2)(b)]',
    'Agreement relating to deposit of title deed [6(2)(a)]',
    'Assignment of Debt [11(Sch-1A)]',
    'Authority of Adopt [11]',
    'Award [12]',
    'Award – Immovable [12]',
    'Award – Movable [12]',
    'Bank Guarantee',
    'Bill of Exchange [13]',
    'Bond',
    'Bonds [15]',
    'Cancellation of Will',
    'Cancellation of Agreement [17]',
    'Cancellation of instrument [17]',
    'Car Loan/ Loan Agreement',
    'Certificate of Sale [18]',
    'Certificate or other document (Share) [19]',
    'Consent Letyter [5]',
    'Conveyance [23]',
    'Conveyance (M&A of Companies under Amalgamation scheme) [23]',
    'Customs-Bonds [26]',
    'Debenture [27]',
    'Declaration [4]',
    'Decree (Sale Deed/Covenyance) [23]',
    'Decree (Settlement) [58]',
    'Deed of Retirement [64(b)]',
    'Disclaimer [55]',
    'Dissolution Deed [64(b)]',
    'Divorce [29]',
    'Exchange of property [31]',
    'Forward Contract',
    'Further Charge [32(b)(ii)]',
    'Further Charge [32(a)]',
    'Further Charge [32(b)(i)]',
    'GPA-Blood Relation [48]',
    'General Agreement [5]',
    'Gift [33]',
    'Guarantee Bond',
    'Indemnity Bond [15]',
    'L.C. (Letter Certificate)',
    'Lease upto 10 years [35(iii)]',
    'Lease upto 100 years [35(vi)]',
    'Lease upto 20 years [35(iv)]',
    'Lease upto 200 years [35(vii)]',
    'Lease upto 30 years [35(v)]',
    'Lease upto 5 years [35(ii)]',
    'Lease with security upto 10 years [35(iii)]',
    'Lease with security upto 100 years [35(vi)]',
    'Lease with security upto 20 years [35(iv)]',
    'Lease with security upto 200 years [35(vii)]',
    'Lease with security upto 30 years [35(v)]',
    'Lease with security upto 5 years [35(ii)]',
    'Lease-Rent deed upto 1 year [35(i)]',
    'Memorandum of Settlement [58]',
    'Mortgage [40]',
    'Mortgage Collateral [40(c)]',
    'Mortgage of a Crop [41]',
    'Partition [45]',
    'Perpetual [35]',
    'Policy of Insurance [47]',
    'Power of Attoney – Authenticate GPA [48(g)]',
    'Power of Attorney – GPA [48(c)]',
    'Power of Attorney – GPA more than five persons but less than ten persons [48(e)]',
    'Power of Attorney – GPA more than five persons jointly and severly [48(d)]',
    'Power of Attorney – SPA [48]',
    'Power of Attorney – GPA with consideration [48(f)]',
    'Re-conveyance [54]',
    'Receipt [53]',
    'Record of Transactionon (Electronics or Otheriwse) effected by a trading member (Broker Note) [54A]',
    'Rectification Deed – Immovable [5(c)]',
    'Rectification Deed – Moveable [5(c)]',
    'Release [55]',
    'Relinquishment Deed [55]',
    'Respondentia Bond [56]',
    'Revovation of Trust [64(b)]',
    'Sale [23]',
    'Sale Agreement [23-A]',
    'Security Bond [57]',
    'Settlement [58]',
    'Share Warrants [59]',
    'Surety Warrants [59]',
    'Surety Bonds [ ]',
    'Surrender of Lease [61]',
    'Transrer (with or without consideration for Debentures & Company Shares) [62]',
    'Transfer Deed [ ]',
    'Transfer of Lease [63]',
    'Trust [64]',
    'Undertaking [ ]',
    'Will [ ]',
    'Will After Death [ ]',
    'Will Medical Ground [ ]',
    'Will Sealed Cover [ ]',
    'Will with Cancellation [ ]',
  ];


  static final List<Map<String, dynamic>> advertisingDetails =[

    {
      'id':0,
      'name':'Indian Express\n+ Jansatta',
      'edition':'Delhi NCR',
      'adsize':'20 Words',
      'rate':'900',
      'extra':'35',
    },
    {
      'id':1,
      'name':'Economics Times\n+ Hindustan (Hindi)',
      'edition':'Delhi NCR',
      'adsize':'20 Words',
      'rate':'1000',
      'extra':'35',
    },
    {
      'id':2,
      'name':'Hindustan Times\n+ Hindustan (Hindi)',
      'edition':'Delhi NCR',
      'adsize':'20 Words',
      'rate':'1200',
      'extra':'55',
    },
    {
      'id':3,
      'name':'Economics Times\n+ Nav Bharat Times (Hindi)',
      'edition':'Delhi NCR',
      'adsize':'20 Words',
      'rate':'1050',
      'extra':'65',
    },
    {
      'id':4,
      'name':'Times of India\n+ Nav Bharat Times (Hindi)',
      'edition':'Delhi NCR',
      'adsize':'20 Words',
      'rate':'1500',
      'extra':'125',
    },
    {
      'id':5,
      'name':'Jansatta',
      'edition':'Delhi NCR',
      'adsize':'20 Words',
      'rate':'600',
      'extra':'25',
    },{
      'id':6,
      'name':'Indian Express',
      'edition':'Delhi NCR',
      'adsize':'20 Words',
      'rate':'650',
      'extra':'30',
    },

    {
      'id':7,
      'name':'Hindustan (Hindi)',
      'edition':'Delhi NCR',
      'adsize':'20 Words',
      'rate':'600',
      'extra':'25',
    },
    {
      'id':8,
      'name':'Economics Times',
      'edition':'Delhi NCR',
      'adsize':'20 Words',
      'rate':'600',
      'extra':'25',
    },
    {
      'id':9,
      'name':'Hindustan Times',
      'edition':'Delhi NCR',
      'adsize':'20 Words',
      'rate':'800',
      'extra':'50',
    },


  ];

  static const  String disclaimerText = 'It is hereby declared for clarification that '
      'we are not a law firm. We are acting as a service provider and are '
      'engaged in Property & Family matters consultancy, deed writing services '
      'and providing the property documentation (para legal) services and '
      'assistance and other allied matters. Your usage of the application '
      'implies you understand the risk, and agree to the rules/policies '
      'prescribed in this regard from time to time. However, we reserve the '
      'right to take assistance from any professionals including Advocate etc., '
      'which not does change the constitution or nature of the firm.\n\n'
      'The application further aims at disseminating information relating to '
      'property matters and is a resource centre. The information provided '
      'hereunder has been taken from the both government and non-government, '
      'public and private sources, most of them reliable and authentic but '
      'possibility of incorrectness cannot be ruled out, and thus it is '
      'suggested that you must verify them.\n\n'
      'By entering the application you agree that we owe no liability '
      'whatsoever by your usage of the content of the application. Any sharing '
      'of information hereunder, rendering of advice or such other acts would '
      'not constitute attorney or any legal relationship. The proprietor or all '
      'other persons related with it, shall not be held liable in any manner '
      'for the same. The comments suggestion or any information on this '
      'application should not be construed as legal advice. You must act upon '
      'your own peril.';



}