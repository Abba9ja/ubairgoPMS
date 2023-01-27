class UserModelF {
  String id;
  String email_address;
  String phone_number;
  String full_name;
  String profile_picture;
  String status;
  String sys_status;

  UserModelF({
    required this.id,
    required this.email_address,
    required this.phone_number,
    required this.full_name,
    required this.profile_picture,
    required this.status,
    required this.sys_status,
  });
}

UserModelF user0 = UserModelF(
  id: 'user0',
  email_address: 'martins@qimadev.com',
  phone_number: '+2348178123423',
  full_name: 'Martins David',
  profile_picture: 'assets/sysimg/users/user0.jpeg',
  status: 'Active',
  sys_status: 'Client',
);

UserModelF userf0 = UserModelF(
  id: 'userf0',
  email_address: 'aisha_abubakar@qimadev.com',
  phone_number: '+2348178123423',
  full_name: 'Aisha Abubakar',
  profile_picture: 'assets/sysimg/users/userf0.jpeg',
  status: 'Active',
  sys_status: 'Client',
);

UserModelF user00 = UserModelF(
  id: 'user00',
  email_address: 'umar_ismael@qimadev.com',
  phone_number: '+2348178123423',
  full_name: 'Umar Ismael',
  profile_picture: 'assets/sysimg/users/user00.jpeg',
  status: 'Active',
  sys_status: 'Client',
);

UserModelF user1 = UserModelF(
  id: 'user1',
  email_address: 'mele_shattima@qimadev.com',
  phone_number: '+2348178123423',
  full_name: 'Shattima Mele',
  profile_picture: 'assets/sysimg/users/user1.jpeg',
  status: 'Active',
  sys_status: 'Client',
);

UserModelF userf00 = UserModelF(
  id: 'userf00',
  email_address: 'w_taulor@qimadev.com',
  phone_number: '+2348178123423',
  full_name: 'Elizabeth Taylor',
  profile_picture: 'assets/sysimg/users/userf00.jpeg',
  status: 'Active',
  sys_status: 'Client',
);

UserModelF user11 = UserModelF(
  id: 'user11',
  email_address: 'mele_shattima@qimadev.com',
  phone_number: '+2348178123423',
  full_name: 'Abdulkarim Muhammad',
  profile_picture: 'assets/sysimg/users/user11.jpeg',
  status: 'Active',
  sys_status: 'Client',
);

UserModelF user2 = UserModelF(
  id: 'user2',
  email_address: 'etomi_sam@qimadev.com',
  phone_number: '+2348178123423',
  full_name: 'Samuel Etomi',
  profile_picture: 'assets/sysimg/users/user2.jpeg',
  status: 'Active',
  sys_status: 'Client',
);

UserModelF userf3 = UserModelF(
  id: 'user3',
  email_address: 'fatima_ibraheem@qimadev.com',
  phone_number: '+2348178123423',
  full_name: 'Fatima Ibraheem',
  profile_picture: 'assets/sysimg/users/user3.jpeg',
  status: 'Active',
  sys_status: 'Client',
);

UserModelF userf4 = UserModelF(
  id: 'user4',
  email_address: 'bature_hadiza@qimadev.com',
  phone_number: '+2348178123423',
  full_name: 'Hadiza Bature',
  profile_picture: 'assets/sysimg/users/user4.jpeg',
  status: 'Active',
  sys_status: 'Client',
);

UserModelF user22 = UserModelF(
  id: 'user22',
  email_address: 'sanda_umar@qimadev.com',
  phone_number: '+2348178123423',
  full_name: 'Sanda Umaru Sani',
  profile_picture: 'assets/sysimg/users/user22.jpeg',
  status: 'Active',
  sys_status: 'Client',
);

UserModelF user33 = UserModelF(
  id: 'user33',
  email_address: 'jackson_temi@qimadev.com',
  phone_number: '+2348178123423',
  full_name: 'Jackson Temilade Ado',
  profile_picture: 'assets/sysimg/users/user33.jpeg',
  status: 'Active',
  sys_status: 'Client',
);

UserModelF user3 = UserModelF(
  id: 'user3',
  email_address: 'john_salami@qimadev.com',
  phone_number: '+2348178123423',
  full_name: 'Salami John',
  profile_picture: 'assets/sysimg/users/user3.jpeg',
  status: 'Active',
  sys_status: 'Client',
);

UserModelF userf22 = UserModelF(
  id: 'userf22',
  email_address: 'javami_marty@qimadev.com',
  phone_number: '+2348178123423',
  full_name: 'Javimi Marty',
  profile_picture: 'assets/sysimg/users/userf22.jpeg',
  status: 'Active',
  sys_status: 'Client',
);

class EstateSupport {
  String id;
  String role;
  double rating;
  bool is_verified;

  EstateSupport(
      {required this.id,
      required this.role,
      required this.rating,
      required this.is_verified});
}

class EmergencySupport {
  String id;
  String role;
  double rating;
  bool is_verified;
  String support_department;

  EmergencySupport({
    required this.id,
    required this.role,
    required this.rating,
    required this.is_verified,
    required this.support_department,
  });
}
