import 'package:flutter/material.dart';
import 'package:ubairgo/model/user_model.dart';

class NoticeBoardModel {
  String id;
  String title;
  String description;
  List<String> attachements;
  String date_time;
  UserModel userModel;
  Color priority;

  NoticeBoardModel({
    required this.id,
    required this.title,
    required this.description,
    required this.attachements,
    required this.date_time,
    required this.userModel,
    required this.priority,
  });
}

List<NoticeBoardModel> list_notice = [max, fha, security, utility];

NoticeBoardModel max = NoticeBoardModel(
  id: 'ijdnshgfhry374hd64',
  title: 'Chritmas Party | End of the Year Party',
  description: '',
  attachements: [
    'assets/temp/max_party.jpeg',
  ],
  date_time: 'Mon 19 Dec 13:58',
  userModel: gift,
  priority: Colors.blue,
);

NoticeBoardModel fha = NoticeBoardModel(
    id: 'ijdnshgfhry374hd64',
    title: 'Federal Housing Authority ',
    description: '',
    priority: Colors.green,
    attachements: [
      'assets/temp/fha.jpeg',
    ],
    date_time: 'Mon 19 Dec 13:49',
    userModel: fatima);

NoticeBoardModel security = NoticeBoardModel(
    id: 'ijdnshgfhry374hd64',
    title: 'Estate Security Awareness/Training',
    description:
        'Eagle Eye provides incomparable residential security and protective services to those seeking a higher level of training, professionalism and capability. Because of our reputation, we attract and hire a better caliber of security personnel. Eagle Eye’s approach is holistic: we help design a security program for optimal results. Your team is trained to observe, report and respond and we offer actionable daily intelligence reports .Armed and Unarmed Protection .Highly Vetted & Highly Trained .Discrete Services   .Actionable Intelligence Reporting .Tailored to Your Lifestyle and Preferences',
    attachements: [
      'assets/temp/security.jpeg',
    ],
    priority: Colors.red,
    date_time: 'Mon 19 Dec 13:00',
    userModel: martins);

NoticeBoardModel utility = NoticeBoardModel(
    id: 'ijdnshgfhry374hd64',
    title: 'Estate Utility Bills Review',
    description:
        'The utility expenses associated with a new home are an important factor for prospective buyers to consider. Electric bills in particular have been surging in recent years, along with natural gas prices, and that upward trend is not expected to ease anytime soon. Some states — such as Florida, Hawaii and New York — experienced a 15 percent increase in electric bills over 2021, according to the Energy Department. Home heating bills have also been soaring thanks to rising fuel costs, and cable, sewer and water bills are rarely inexpensive either.',
    attachements: [
      'assets/temp/utility.jpeg',
    ],
    date_time: 'Mon 19 Dec 9:00',
    priority: Colors.purple,
    userModel: martins);
