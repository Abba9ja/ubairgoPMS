import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ubairgo/model/emergency_model.dart';
import 'package:ubairgo/styles/sysimg_constants.dart';

class UserF {
  String id;
  String resident_id;
  String email_address;
  String phone_number;
  String full_name;
  String profile_pic;
  String status;
  String sys_status;
  double rate;
  bool is_verified;
  String user_status;
  String id_type;
  String id_number;
  List<dynamic> id_documents;
  String ref_note;
  List<dynamic> ref_documents;
  Timestamp date_reg;
  Timestamp date_signin;
  List<dynamic> search_query;

  UserF({
    required this.id,
    required this.resident_id,
    required this.email_address,
    required this.phone_number,
    required this.full_name,
    required this.profile_pic,
    required this.status,
    required this.sys_status,
    required this.rate,
    required this.is_verified,
    required this.user_status,
    required this.id_type,
    required this.id_number,
    required this.id_documents,
    required this.ref_note,
    required this.ref_documents,
    required this.date_reg,
    required this.date_signin,
    required this.search_query,
  });

  factory UserF.fromDocument(DocumentSnapshot doc) {
    return UserF(
      id: doc.get('id'),
      resident_id: doc.get('resident_id'),
      email_address: doc.get('email_address'),
      phone_number: doc.get('phone_number'),
      full_name: doc.get('full_name'),
      profile_pic: doc.get('profile_pic'),
      status: doc.get('status'),
      sys_status: doc.get('sys_status'),
      rate: doc.get('rate'),
      is_verified: doc.get('is_verified'),
      user_status: doc.get('user_status'),
      id_type: doc.get('id_type'),
      id_number: doc.get('id_number'),
      id_documents: doc.get('id_documents'),
      ref_note: doc.get('ref_note'),
      ref_documents: doc.get('ref_documents'),
      date_reg: doc.get('date_reg'),
      date_signin: doc.get('date_signin'),
      search_query: doc.get('search_query'),
    );
  }
}


class ESAgentF {
  String id;
  Timestamp date_reg;
  String email_address;
  List<dynamic> search_query;

  ESAgentF({
    required this.id,
    required this.date_reg,
    required this.email_address,
    required this.search_query,
  });

  factory ESAgentF.fromDocument(DocumentSnapshot doc) {
    return ESAgentF(
      id: doc.get('id'),
      date_reg: doc.get('date_reg'),
      email_address: doc.get('email_address'),
      search_query: doc.get('search_query'),
    );
  }
}

class SupportAgentF {
  String id;
  Timestamp date_reg;
  String email_address;
  List<dynamic> search_query;

  SupportAgentF({
    required this.id,
    required this.date_reg,
    required this.email_address,
    required this.search_query,
  });

  factory SupportAgentF.fromDocument(DocumentSnapshot doc) {
    return SupportAgentF(
      id: doc.get('id'),
      date_reg: doc.get('date_reg'),
      email_address: doc.get('email_address'),
      search_query: doc.get('search_query'),
    );
  }
}

class UserModel {
  String id;
  String resident_id;
  String email_address;
  String phone_number;
  String full_name;
  String profile_pic;
  String status;
  String sys_status;
  double rate;
  bool is_verified;

  UserModel({
    required this.id,
    required this.resident_id,
    required this.email_address,
    required this.phone_number,
    required this.full_name,
    required this.profile_pic,
    required this.status,
    required this.sys_status,
    required this.rate,
    required this.is_verified,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc.get('id'),
      resident_id: doc.get('resident_id'),
      email_address: doc.get('email_address'),
      phone_number: doc.get('phone_number'),
      full_name: doc.get('full_name'),
      profile_pic: doc.get('profile_pic'),
      status: doc.get('status'),
      sys_status: doc.get('sys_status'),
      rate: doc.get('rate'),
      is_verified: doc.get('is_verified'),
    );
  }
}

UserModel user20 = UserModel(
    id: 'user0',
    resident_id: '',
    email_address: 'martins@qimadev.com',
    phone_number: '+2348178123423',
    full_name: 'Martins David',
    profile_pic: 'assets/sysimg/users/user0.jpeg',
    status: 'LANDLORD',
    sys_status: 'Estate Client',
    is_verified: true,
    rate: 3.5);

UserModel _userf0 = UserModel(
  id: 'userf0',
  resident_id: '',
  email_address: 'aisha_abubakar@qimadev.com',
  phone_number: '+2348178123423',
  full_name: 'Aisha Abubakar',
  profile_pic: 'assets/sysimg/users/userf0.jpeg',
  status: 'LANLORD',
  rate: 2.5,
  sys_status: 'Estate Client',
  is_verified: false,
);

UserModel _user00 = UserModel(
  id: 'user00',
  email_address: 'umar_ismael@qimadev.com',
  phone_number: '+2348178123423',
  full_name: 'Umar Ismael',
  profile_pic: 'assets/sysimg/users/user00.jpeg',
  status: 'TENANT',
  resident_id: '',
  rate: 3.5,
  sys_status: 'Estate Client',
  is_verified: true,
);

UserModel _user1 = UserModel(
  id: 'user1',
  email_address: 'mele_shattima@qimadev.com',
  phone_number: '+2348178123423',
  full_name: 'Shattima Mele',
  profile_pic: 'assets/sysimg/users/user1.jpeg',
  status: 'LANLORD',
  resident_id: '',
  rate: 4,
  sys_status: 'Estate Client',
  is_verified: true,
);

UserModel _userf00 = UserModel(
  id: 'userf00',
  email_address: 'w_taulor@qimadev.com',
  phone_number: '+2348178123423',
  full_name: 'Elizabeth Taylor',
  profile_pic: 'assets/sysimg/users/userf00.jpeg',
  status: 'TENANT',
  resident_id: '',
  rate: 1.5,
  sys_status: 'Estate Client',
  is_verified: false,
);

UserModel _userf22 = UserModel(
  id: 'userf22',
  email_address: 'javami_marty@qimadev.com',
  phone_number: '+2348178123423',
  full_name: 'Javimi Marty',
  profile_pic: 'assets/sysimg/users/userf22.jpeg',
  status: 'LANLORD',
  resident_id: '',
  rate: 4,
  sys_status: 'Estate Client',
  is_verified: true,
);

List<UserModel> support = [engr_abba, fatima, martins, easter];

List<UserModel> userss = [
  engr_abba,
  user0,
  _user00,
  _user1,
  hostipal_assist,
  fatima,
  gift,
  abdul,
  estate_assist,
  user20,
  _userf0,
  martins,
  police_assist,
  _userf22,
  easter
];

List<UserModel> verified_people = [
  engr_abba,
  easter,
  fatima,
  martins,
  aisha,
  gift,
  abdul,
];

UserModel user0 = UserModel(
    id: 'user0',
    resident_id: 'MATIRNS|UB|20430',
    email_address: 'martins@qimadev.com',
    phone_number: '++234596847392',
    full_name: 'Martins David',
    profile_pic: 'assets/users/user0',
    status: 'LANLORD',
    is_verified: true,
    sys_status: 'Estate Client',
    rate: 3.5);

UserModel engr_abba = UserModel(
    id: 'asasdke9iose98ewkjsd4',
    resident_id: 'ENGR_ABBA|UB|20193',
    email_address: 'engr.abba@qimadev.com',
    phone_number: '+2348078087814',
    full_name: 'Muhammad Shehu Bello',
    profile_pic: abba_pic,
    status: 'ENGINEER',
    is_verified: true,
    sys_status: 'Estate Support',
    rate: 3.5);

UserModel fatima = UserModel(
  id: 'sjske0393jdjdi39ed',
  resident_id: 'FATIMA|UB|432342',
  email_address: 'fatima.aliyu@qimadev.com',
  phone_number: '+2348078087814',
  full_name: 'Fatima Aliyu',
  profile_pic: fatima_pic,
  status: 'REALTOR',
  is_verified: true,
  sys_status: 'Estate Support',
  rate: 3,
);

UserModel easter = UserModel(
  id: 'sjjjseidnfu40328s',
  resident_id: 'EASTER|UB|32423',
  email_address: 'easter.john@qimadev.com',
  phone_number: '+2348078087814',
  full_name: 'Easter John Ajayi',
  profile_pic: easter_pic,
  status: 'REALTOR',
  is_verified: false,
  sys_status: 'Estate Support',
  rate: 2.5,
);

UserModel aisha = UserModel(
  id: 'sjjjseidnfu40328s',
  resident_id: 'AISHA|UB|30903',
  email_address: 'aisha.abubakar@qimadev.com',
  phone_number: '+2348078087814',
  full_name: 'Aisha Abubakar',
  profile_pic: aisha_pic,
  status: 'ARCHITECT',
  is_verified: true,
  sys_status: 'Estate Support',
  rate: 3.5,
);

UserModel martins = UserModel(
  id: 'sjjjseidnfu40328s',
  resident_id: 'MARTINS|UB|23341',
  email_address: 'martins.jefferson@qimadev.com',
  phone_number: '+2348078087814',
  full_name: 'Martins Jefferson',
  profile_pic: moses_pic,
  status: 'QAUNTIY SVYR',
  is_verified: false,
  sys_status: 'Estate Support',
  rate: 2,
);

UserModel gift = UserModel(
  id: 'zmxnvjsiowsde332ks',
  resident_id: 'GIFT|UB|66453',
  email_address: 'gift.sam@qimadev.com',
  phone_number: '+2348078087814',
  full_name: 'Gift Samuel',
  profile_pic: gift_pic,
  status: 'RAELTOR',
  is_verified: false,
  sys_status: 'Estate Support',
  rate: 2,
);

UserModel abdul = UserModel(
  id: 'sjsuencgja43ejffn',
  resident_id: 'ABDUL|UB|34255',
  email_address: 'abdul.usman@qimadev.com',
  phone_number: '+2348078087814',
  full_name: 'Abdul Usman',
  profile_pic: abdul_pic,
  status: 'ENGINEER',
  is_verified: true,
  sys_status: 'Estate Support',
  rate: 4,
);
