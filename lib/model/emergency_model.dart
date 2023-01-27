import 'package:flutter/material.dart';
import 'package:ubairgo/model/user_model.dart';
import 'package:ubairgo/styles/sysimg_constants.dart';

class EmergencyModel {
  String id;
  String name;
  String email_address;
  List<UserModel> support_agent;
  String picture;

  EmergencyModel({
    required this.id,
    required this.name,
    required this.email_address,
    required this.support_agent,
    required this.picture,
  });
}

List<EmergencyModel> list_emrg = [
  hospital_emerg,
  police_station_,
  civl_defence_,
  estate_security,
  estate_clinic,
];

EmergencyModel hospital_emerg = EmergencyModel(
    id: 'GWARIMPAHOSP',
    name: 'Gwarimpa First Care Hospital',
    email_address: 'g_first_care@gmail.com',
    support_agent: [hostipal_assist],
    picture: hospital);

EmergencyModel police_station_ = EmergencyModel(
    id: 'GWARIMAPOLICE',
    name: 'General Police Station',
    email_address: 'g_police_station@gmail.com',
    support_agent: [
      police_assist
    ],
    picture: police_station);

EmergencyModel civl_defence_ = EmergencyModel(
    id: 'CIVILDEFENCE',
    name: 'Civil Defence Station',
    email_address: 'civil_defence@gmail.com',
    support_agent: [
      civil_assist
    ],
    picture: civil_defence);

EmergencyModel estate_security = EmergencyModel(
    id: 'ESTATESECURITY',
    name: 'Estate Security Post',
    email_address: 'estate_securityn@gmail.com',
    support_agent: [
      estate_assist
    ],
    picture: gss_scurity);

EmergencyModel estate_clinic = EmergencyModel(
    id: 'ESTATESCLINIC',
    name: 'Estate Clinic and Pharmacy',
    email_address: 'estate_clinic_pharmacyyn@gmail.com',
    support_agent: [
      pharmacist_assist
    ],
    picture: pharm);



UserModel hostipal_assist = UserModel(
    id: 'hosputalwwwuuee22',
    resident_id: '',
    email_address: 'hospital.assist@qimadev.com',
    phone_number: '+2348078087814',
    full_name: 'Maryam Abubakar',
    profile_pic: doctor,
    status: 'DOCTOR',
    is_verified: true,
    sys_status: 'Emergency Support',
    rate: 3.5);

UserModel police_assist = UserModel(
  id: 'policeassistanaasss88',
  resident_id: '',
  email_address: 'police.assist@qimadev.com',
  phone_number: '+2348078087814',
  full_name: 'Mary David',
  profile_pic: police_woman,
  status: 'POLICE',
  sys_status: 'Emergency Support',
  is_verified: true,
  rate: 3,
);

UserModel civil_assist = UserModel(
  id: 'sjjjseidnfu40328s',
  resident_id: 'EASTER|UB|32423',
  email_address: 'temi.civldefence@qimadev.com',
  phone_number: '+2348078087814',
  full_name: 'Temitope Ajayi',
  sys_status: 'Emergency Support',
  profile_pic: civil_defence_staff,
  status: 'CIVIL DEFENCE',
  is_verified: true,
  rate: 2.5,
);

UserModel estate_assist = UserModel(
  id: 'sjjjseidnfu40328s',
  resident_id: 'AISHA|UB|30903',
  email_address: 'usnman.security@qimadev.com',
  phone_number: '+2348078087814',
  full_name: 'Usman Suraj',
  sys_status: 'Emergency Support',
  profile_pic: security_staff,
  status: 'SECURITY',
  is_verified: true,
  rate: 3.5,
);


UserModel pharmacist_assist = UserModel(
  id: 'sjjjseidnfu40328s',
  resident_id: 'AISHA|UB|30903',
  email_address: 'sophia.pharmacist@qimadev.com',
  phone_number: '+2348078087814',
  full_name: 'Sophia Muhammad',
  sys_status: 'Emergency Support',
  profile_pic: pharmacist,
  status: 'PHARMACIST',
  is_verified: true,
  rate: 3.5,
);
