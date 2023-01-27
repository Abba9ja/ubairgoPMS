// ignore_for_file: equal_keys_in_map

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ubairgo/model/user_model.dart';
import 'package:ubairgo/model/user_modelf.dart';

class PaymentAccountF {
  String client_email;
  String payments_id;
  String total_amount_num;
  String paid_amount;
  String outstanding_amount;
  String paid_complete;
  PaymentAccountF({
    required this.client_email,
    required this.payments_id,
    required this.total_amount_num,
    required this.paid_amount,
    required this.outstanding_amount,
    required this.paid_complete,
  });
  factory PaymentAccountF.fromDocument(DocumentSnapshot doc) {
    return PaymentAccountF(
      client_email: doc.get('client_email'),
      payments_id: doc.get('payments_id'),
      total_amount_num: doc.get('total_amount_num'),
      paid_amount: doc.get('paid_amount'),
      outstanding_amount: doc.get('outstanding_amount'),
      paid_complete: doc.get('paid_complete'),
    );
  }
}

class PrmF {
  String payment_id;
  String plot_no;
  String paid_amount;
  Timestamp confirm_date;
  List<dynamic> search_query;
  bool confirm_status;
  String payment_status;

  PrmF({
    required this.plot_no,
    required this.payment_id,
    required this.paid_amount,
    required this.confirm_date,
    required this.search_query,
    required this.confirm_status,
    required this.payment_status,
  });
  factory PrmF.fromDocument(DocumentSnapshot doc) {
    return PrmF(
      plot_no: doc.get('plot_no'),
      payment_id: doc.get('payment_id'),
      paid_amount: doc.get('paid_amount'),
      search_query: doc.get('search_query'),
      confirm_date: doc.get('confirm_date'),
      confirm_status: doc.get('confirm_status'),
      payment_status: doc.get('payment_status'),
    );
  }
}

class PaymentRegistryModelF {
  String payment_id;
  String plot_no;
  String paid_for;
  String paid_amount;
  List<dynamic> transaction_id;
  List<dynamic> transactoin_reciept;
  String extra_note;
  String discount_id;
  String registeredby;
  Timestamp request_date;
  Timestamp confirm_date;
  String handler;
  String request_by;
  List<dynamic> search_query;
  bool confirm_status;
  String payment_status;

  PaymentRegistryModelF({
    required this.plot_no,
    required this.payment_id,
    required this.paid_for,
    required this.paid_amount,
    required this.transaction_id,
    required this.transactoin_reciept,
    required this.extra_note,
    required this.discount_id,
    required this.registeredby,
    required this.request_date,
    required this.confirm_date,
    required this.handler,
    required this.request_by,
    required this.search_query,
    required this.confirm_status,
    required this.payment_status,
  });
  factory PaymentRegistryModelF.fromDocument(DocumentSnapshot doc) {
    return PaymentRegistryModelF(
      plot_no: doc.get('plot_no'),
      payment_id: doc.get('payment_id'),
      paid_for: doc.get('paid_for'),
      paid_amount: doc.get('paid_amount'),
      transaction_id: doc.get('transaction_id'),
      transactoin_reciept: doc.get('transactoin_reciept'),
      extra_note: doc.get('extra_note'),
      discount_id: doc.get('discount_id'),
      registeredby: doc.get('registeredby'),
      request_date: doc.get('request_date'),
      confirm_date: doc.get('confirm_date'),
      handler: doc.get('handler'),
      request_by: doc.get('request_by'),
      search_query: doc.get('search_query'),
      confirm_status: doc.get('confirm_status'),
      payment_status: doc.get('payment_status'),
    );
  }
}

class PropertyF {
  String plot_no;//
  String status;//
  String type;//
  String size;//
  String amount;//
  String address;//
  String title;//
  String description;//
  num bedrooms;///
  num bathroom;//
  num kitchen;//
  num palours;//
  String property_owner;//
  List<dynamic> property_tenants;//
  String property_handler;//
  String featured_img;//
  List<dynamic> images;//
  String registered_by;//
  Timestamp date_reg;//
  List<dynamic> search_query;//

  PropertyF({
    required this.plot_no,
    required this.status,
    required this.type,
    required this.size,
    required this.amount,
    required this.address,
    required this.title,
    required this.description,
    required this.bedrooms,
    required this.bathroom,
    required this.kitchen,
    required this.palours,
    required this.property_owner,
    required this.property_tenants,
    required this.property_handler,
    required this.featured_img,
    required this.images,
    required this.registered_by,
    required this.date_reg,
    required this.search_query,
  });

  factory PropertyF.fromDocument(DocumentSnapshot doc) {
    return PropertyF(
      plot_no: doc.get('plot_no'),
      status: doc.get('status'),
      type: doc.get('type'),
      size: doc.get('size'),
      amount: doc.get('amount'),
      address: doc.get('address'),
      title: doc.get('title'),
      description: doc.get('description'),
      bedrooms: doc.get('bedrooms'),
      bathroom: doc.get('bathroom'),
      kitchen: doc.get('kitchen'),
      palours: doc.get('palours'),
      property_owner: doc.get('property_owner'),
      property_tenants: doc.get('property_tenants'),
      property_handler: doc.get('property_handler'),
      featured_img: doc.get('featured_img'),
      images: doc.get('images'),
      registered_by: doc.get('registered_by'),
      date_reg: doc.get('date_reg'),
      search_query: doc.get('search_query'),
    );
  }
}

class UserPropertyF {
  String plot_no;
  Timestamp date_reg;
  List<dynamic> search_query;

  UserPropertyF({
    required this.plot_no,
    required this.date_reg,
    required this.search_query,
  });

  factory UserPropertyF.fromDocument(DocumentSnapshot doc) {
    return UserPropertyF(
      plot_no: doc.get('plot_no'),
      date_reg: doc.get('date_reg'),
      search_query: doc.get('search_query'),
    );
  }
}

class PropertyModel {
  String plot_no;
  String status;
  String type;
  String size;
  String address;
  String title;
  String description;
  String bedrooms;
  String bathromms;
  String kitchens;
  String palours;
  String extra;
  List<String> amnesties;
  String co_ordinate_lang;
  String co_ordinate_lat;
  UserModelF owner;
  String price;
  UserModel registered_by;
  UserModel handler;

  PropertyModel({
    required this.plot_no,
    required this.status,
    required this.type,
    required this.size,
    required this.title,
    required this.description,
    required this.address,
    required this.bedrooms,
    required this.bathromms,
    required this.kitchens,
    required this.palours,
    required this.extra,
    required this.amnesties,
    required this.co_ordinate_lang,
    required this.co_ordinate_lat,
    required this.owner,
    required this.price,
    required this.registered_by,
    required this.handler,
  });
}

List<PropertyModel> p_registry = [plot101, plot202, plot303, plot404];

List<PropertyGallaryModel> pg_registry = [
  plot101_G,
  plot202_G,
  plot303_G,
  plot404_G
];

PropertyModel plot101 = PropertyModel(
  plot_no: 'plot101',
  status: 'For Sale',
  type: 'Contemporary Duplex',
  size: '360 m²',
  title: 'House Merano, Abuja FCT',
  description:
      "The project M, a residential building in the centre of Meran, is embedded in the quit area of Obermais. The concept of the design was it to play with transparent and solid surfaces what fallows fascinating insights and outlooks. The interior melts together with the outside space. The terrain flows through the building and finds his renewal in the pool- and meadow area. Because of a refined external design and the arrangement of the pool, lawn, garden and house the whole concept seems like a unity with seamless transition. The ground floor follows the slightly sloping ground like a staircase to get a large garden area. Because of engineering technology considerations the building is conceived as a compact volume with one underground and two upper floors. From the construction point of view the house is built as a concrete construction, furnished with upgraded insulation. The glass-facade, door and window elements are executed as 3 layered glazier.",
  address: "Plot 101 Merano Street, Ubairgao Real Estate",
  bedrooms: '6 Bedrooms',
  bathromms: "7 Bathrooms",
  kitchens: "2 Kitchen",
  palours: '2 Palours',
  extra: "Pool House and BQ Quaters",
  amnesties: [
    'Water recycling system',
    "Internet Connectivity",
  ],
  co_ordinate_lang: '',
  co_ordinate_lat: '',
  owner: userf0,
  price: '₦354,000,000',
  registered_by: fatima,
  handler: fatima,
);

PropertyGallaryModel plot101_G = PropertyGallaryModel(
  plot_no: 'plot101',
  featured_file: {'Featured Image': 'assets/sysimg/properties/h0.jpeg'},
  media_files: {
    'Front View Image': 'assets/sysimg/properties/h1.jpeg',
    'Sitting Room': 'assets/sysimg/properties/h2.jpeg',
    'Main Sitting Room': 'assets/sysimg/properties/h3.jpeg',
    '': 'assets/sysimg/properties/h4.jpeg',
    '': 'assets/sysimg/properties/h5.jpeg',
    '': 'assets/sysimg/properties/h6.jpeg',
    '': 'assets/sysimg/properties/h7.jpeg',
    '': 'assets/sysimg/properties/h8.jpeg',
    '': 'assets/sysimg/properties/h9.jpeg',
    '': 'assets/sysimg/properties/h10.jpeg',
    '': 'assets/sysimg/properties/h11.jpeg',
    '2D Design Sketch': 'assets/sysimg/properties/h12.jpeg',
  },
);

PropertyModel plot202 = PropertyModel(
  plot_no: 'plot202',
  status: 'For Rent',
  type: 'Smart Studio House',
  size: '398 m²',
  title: 'Smart Studio House, Belguim Street',
  description:
      "The project M, a residential building in the centre of Meran, is embedded in the quit area of Obermais. The concept of the design was it to play with transparent and solid surfaces what fallows fascinating insights and outlooks. The interior melts together with the outside space. The terrain flows through the building and finds his renewal in the pool- and meadow area. Because of a refined external design and the arrangement of the pool, lawn, garden and house the whole concept seems like a unity with seamless transition. The ground floor follows the slightly sloping ground like a staircase to get a large garden area. Because of engineering technology considerations the building is conceived as a compact volume with one underground and two upper floors. From the construction point of view the house is built as a concrete construction, furnished with upgraded insulation. The glass-facade, door and window elements are executed as 3 layered glazier.",
  address: "Plot 202 Belguim Street, Ubairgao Real Estate",
  bedrooms: '3 Bedrooms',
  bathromms: "4 Bathrooms",
  kitchens: "1 Kitchen",
  palours: '1 Palours',
  extra: "",
  amnesties: [
    'Water recycling system',
    "Internet Connectivity",
    '24/7 Power Supply'
  ],
  co_ordinate_lang: '',
  co_ordinate_lat: '',
  owner: user00,
  price: '₦5,400,000/Year',
  registered_by: aisha,
  handler: aisha,
);

PropertyGallaryModel plot202_G = PropertyGallaryModel(
  plot_no: 'plot202',
  featured_file: {'Featured Image': 'assets/sysimg/smart_studio/ho.jpeg'},
  media_files: {
    'Featured Image': 'assets/sysimg/smart_studio/h1.jpeg',
    'Featured Image': 'assets/sysimg/smart_studio/h2.jpeg',
    'Featured Image': 'assets/sysimg/smart_studio/h3.jpeg',
    'Featured Image': 'assets/sysimg/smart_studio/h4.jpeg',
    'Featured Image': 'assets/sysimg/smart_studio/h5.jpeg',
    'Featured Image': 'assets/sysimg/smart_studio/h6.jpeg',
    'Featured Image': 'assets/sysimg/smart_studio/h7.jpeg',
  },
);

PropertyModel plot303 = PropertyModel(
  plot_no: 'plot303',
  status: 'For Sale',
  type: 'Tech Wood Duplex',
  size: '267 m²',
  title: 'TechWood Smart Duplex,',
  description:
      "The project M, a residential building in the centre of Meran, is embedded in the quit area of Obermais. The concept of the design was it to play with transparent and solid surfaces what fallows fascinating insights and outlooks. The interior melts together with the outside space. The terrain flows through the building and finds his renewal in the pool- and meadow area. Because of a refined external design and the arrangement of the pool, lawn, garden and house the whole concept seems like a unity with seamless transition. The ground floor follows the slightly sloping ground like a staircase to get a large garden area. Because of engineering technology considerations the building is conceived as a compact volume with one underground and two upper floors. From the construction point of view the house is built as a concrete construction, furnished with upgraded insulation. The glass-facade, door and window elements are executed as 3 layered glazier.",
  address: "Plot 303 Merano, Ubairgao Real Estate",
  bedrooms: '6 Bedrooms',
  bathromms: "7 Bathrooms",
  kitchens: "2 Kitchen",
  palours: '2 Palours',
  extra: "Pool House and BQ Quaters",
  amnesties: [
    'Water recycling system',
    "Internet Connectivity",
    '24/7 Power Supply'
  ],
  co_ordinate_lang: '',
  co_ordinate_lat: '',
  owner: user2,
  price: '₦453,000,000',
  registered_by: abdul,
  handler: aisha,
);

PropertyGallaryModel plot303_G = PropertyGallaryModel(
  plot_no: 'plot101',
  featured_file: {'Featured Image': 'assets/sysimg/technowwod/h0.jpeg'},
  media_files: {
    'Front View Image': 'assets/sysimg/technowwod/h1.jpeg',
    'Sitting Room': 'assets/sysimg/technowwod/h2.jpeg',
    'Main Sitting Room': 'assets/sysimg/technowwod/h3.jpeg',
  },
);

PropertyModel plot404 = PropertyModel(
  plot_no: 'plot404',
  status: 'For Sale',
  type: 'Smart Studio House',
  size: '160 m²',
  title: 'Fully Furniseh Wooden Bungalow',
  description:
      "The project M, a residential building in the centre of Meran, is embedded in the quit area of Obermais. The concept of the design was it to play with transparent and solid surfaces what fallows fascinating insights and outlooks. The interior melts together with the outside space. The terrain flows through the building and finds his renewal in the pool- and meadow area. Because of a refined external design and the arrangement of the pool, lawn, garden and house the whole concept seems like a unity with seamless transition. The ground floor follows the slightly sloping ground like a staircase to get a large garden area. Because of engineering technology considerations the building is conceived as a compact volume with one underground and two upper floors. From the construction point of view the house is built as a concrete construction, furnished with upgraded insulation. The glass-facade, door and window elements are executed as 3 layered glazier.",
  address: "Plot 202 Belguim Street, Ubairgao Real Estate",
  bedrooms: '3 Bedrooms',
  bathromms: "4 Bathrooms",
  kitchens: "1 Kitchen",
  palours: '1 Palours',
  extra: "",
  amnesties: [
    'Water recycling system',
    "Internet Connectivity",
    '24/7 Power Supply'
  ],
  co_ordinate_lang: '',
  co_ordinate_lat: '',
  owner: userf22,
  price: '₦55,400,000',
  registered_by: fatima,
  handler: fatima,
);

PropertyGallaryModel plot404_G = PropertyGallaryModel(
  plot_no: 'plot404',
  featured_file: {'Featured Image': 'assets/sysimg/woodtech/h0.jpeg'},
  media_files: {
    'Featured Image': 'assets/sysimg/woodtech/h1.jpeg',
    'Featured Image': 'assets/sysimg/woodtech/h2.jpeg',
  },
);

class PropertyGallaryModel {
  String plot_no;
  Map<String, String> featured_file;
  Map<String, String> media_files;

  PropertyGallaryModel({
    required this.plot_no,
    required this.featured_file,
    required this.media_files,
  });
}

class PropertyAccountModel {
  String plot_no;
  num current_price_value;
  num prv_price_value;
  num paid_amount;
  String discount_id;
  int discount_val;
  num faccility_amount;
  num facility_paid_amount;

  PropertyAccountModel({
    required this.plot_no,
    required this.current_price_value,
    required this.prv_price_value,
    required this.paid_amount,
    required this.discount_id,
    required this.discount_val,
    required this.faccility_amount,
    required this.facility_paid_amount,
  });
}

class PaymentRegistryModel {
  String plot_no;
  String payment_id;
  String paid_for;
  String paid_amount;
  List<String> transaction_id;
  List<String> transactoin_reciept;
  String extra_note;
  String discount_id;
  UserModelF request_by;
  String request_date;
  UserModel handler;

  PaymentRegistryModel({
    required this.plot_no,
    required this.payment_id,
    required this.paid_for,
    required this.paid_amount,
    required this.transaction_id,
    required this.transactoin_reciept,
    required this.extra_note,
    required this.discount_id,
    required this.request_by,
    required this.request_date,
    required this.handler,
  });
}

PaymentRegistryModel pplot101 = PaymentRegistryModel(
    plot_no: 'Plot 101',
    payment_id: 'payment_id',
    paid_for: 'House Purchase',
    paid_amount: '₦354,000,000',
    transaction_id: [
      '#238923892019393810',
      '#38949238823838292',
      '#0193933892019393810'
    ],
    transactoin_reciept: [],
    extra_note:
        'Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim.',
    discount_id: 'discount_id',
    request_by: userf0,
    request_date: '10 Dec, 8:20',
    handler: fatima);

PaymentRegistryModel pplot202 = PaymentRegistryModel(
    plot_no: 'Plot 202',
    payment_id: 'payment_id',
    paid_for: 'House Rent',
    paid_amount: '₦14,000,000',
    transaction_id: [
      '#238923892019393810',
    ],
    transactoin_reciept: [],
    extra_note:
        'Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim.',
    discount_id: 'discount_id',
    request_by: user00,
    request_date: '6 Dec, 8:20',
    handler: abdul);

PaymentRegistryModel pplot303 = PaymentRegistryModel(
    plot_no: 'Plot 303',
    payment_id: 'payment_id',
    paid_for: 'House Purchase',
    paid_amount: '₦453,000,000',
    transaction_id: [
      '#238923892019393810',
      '#238923892019393810',
    ],
    transactoin_reciept: [],
    extra_note:
        'Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim.',
    discount_id: 'discount_id',
    request_by: user00,
    request_date: '6 Dec, 8:20',
    handler: abdul);

PaymentRegistryModel pplot404 = PaymentRegistryModel(
    plot_no: 'Plot 404',
    payment_id: 'payment_id',
    paid_for: 'House Purchase',
    paid_amount: '₦55,400,000',
    transaction_id: [
      '#238923892019393810',
    ],
    transactoin_reciept: [],
    extra_note:
        'Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim.',
    discount_id: 'discount_id',
    request_by: user00,
    request_date: '6 Dec, 8:20',
    handler: abdul);

List<PaymentRegistryModel> list_pp = [pplot101, pplot202, pplot303, pplot404];
