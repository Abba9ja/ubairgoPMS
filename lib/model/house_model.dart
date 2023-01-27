import '../styles/sysimg_constants.dart';

class HouseModel {
  String house_id;
  String house_no;
  String house_street;
  String house_state;
  String house_condition;
  String house_size;
  String house_description;
  String house_title;
  String house_bedrooms;
  String house_toilet;
  String house_kitchen;
  String house_status;
  String amount;
  bool iclude_bq;
  bool iclude_pool;
  String bq_details;
  List<String> house_images;

  HouseModel({
    required this.house_id,
    required this.house_no,
    required this.house_street,
    required this.house_state,
    required this.house_condition,
    required this.house_size,
    required this.house_description,
    required this.house_title,
    required this.amount,
    required this.house_bedrooms,
    required this.house_toilet,
    required this.house_kitchen,
    required this.house_status,
    required this.iclude_bq,
    required this.iclude_pool,
    required this.bq_details,
    required this.house_images,
  });
}

List<HouseModel> my_house = [plot804, plot732, plot202];

List<HouseModel> houses = [
  plot564,
  plot804,
  plot202,
  plot732,
  plot503,
  plot303,
  plot674,
  plot502,
];

List<HouseModel> related_houses = [
  plot564,
  plot804,
  plot732,
  plot303,
];

HouseModel plot804 = HouseModel(
    house_id: 'AQUSJDHWOEU78',
    house_no: 'Plot 804',
    house_street: 'Plot 804. Ubairgo Estate Karsana, FCT Abuja',
    house_state: 'FCT ABUJA',
    house_condition: 'Newly Built, Serviced',
    house_size: '2,400 sqft',
    house_title: 'Contemporary design, iconic house in the locality',
    house_description:
        'the brief required a House for a family of four on a 2,400 square feet site, located in South Bangalore. The clients aspired for a Contemporary design, iconic house in the locality that housed not only a living unit but also work and entertainment zones on different levels. Contemporary design, iconic house in the locality.',
    house_bedrooms: '5',
    house_toilet: '6',
    house_kitchen: '2',
    house_status: 'For Sale',
    amount: '₦170,600,000',
    iclude_bq: true,
    iclude_pool: true,
    bq_details: '2 bedroom selcontain BQ',
    house_images: [f_view, palour, bedroom, bedroom1, toilet]);

HouseModel plot732 = HouseModel(
    house_id: 'AQUSJDHWOEU78',
    house_no: 'Plot 732',
    house_street: 'Plot 732. Ubairgo Estate Maitama, FCT Abuja',
    house_state: 'FCT ABUJA',
    house_condition: 'Furnished, Serviced',
    house_title: 'Contemporary design, iconic house in the locality',
    house_size: '2,400 sqft',
    house_description:
        'The brief required a House for a family of four on a 2,400 square feet site, located in South Bangalore. The clients aspired for a Contemporary design, iconic house in the locality that housed not only a living unit but also work and entertainment zones on different levels.',
    house_bedrooms: '4',
    house_toilet: '5',
    house_kitchen: '2',
    house_status: 'For Sale',
    amount: '₦246,340,000',
    iclude_bq: true,
    iclude_pool: true,
    bq_details: '2 bedroom selcontain BQ',
    house_images: ['assets/temp/house22.jpeg']);

HouseModel plot202 = HouseModel(
    house_id: 'AQUSJDHWOEU78',
    house_no: 'Plot 202',
    house_street: 'Plot 202. Liberia Street Ubairgo Estate Karsana, FCT Abuja',
    house_state: 'FCT ABUJA',
    house_condition: 'Newly Developed',
    house_title: 'Bungalow with pent-house, for family of 3',
    house_size: '3500 sqmt',
    house_status: 'For Rent',
    amount: '₦4,340,000/Year',
    house_description:
        'Fully furnished duplex, 5 bedroom, 6 toilet, 2 kitches and swimiming pool.',
    house_bedrooms: '5',
    house_kitchen: '1',
    house_toilet: '6',
    iclude_bq: true,
    iclude_pool: true,
    bq_details: '2 bedroom selcontain BQ',
    house_images: ['assets/temp/house32.jpeg']);

HouseModel plot674 = HouseModel(
    house_id: 'AQUSJDHWOEU78',
    house_no: 'Plot 674',
    house_street: 'Plot 674. Ubairgo Estate Karsana, FCT Abuja',
    house_state: 'FCT ABUJA',
    house_condition: 'Newly Developed',
    house_size: '4200 sqft',
    house_status: 'For Lease',
    amount: '₦16,340,000/Annum',
    house_title:
        'Fully furnished duplex, 5 bedroom, 6 toilet, 2 kitches and swimiming pool.',
    house_description: '',
    house_bedrooms: '5',
    house_toilet: '6',
    house_kitchen: '2',
    iclude_bq: true,
    iclude_pool: true,
    bq_details: '2 bedroom selcontain BQ',
    house_images: ['assets/temp/housedp9.jpeg']);

HouseModel plot564 = HouseModel(
    house_id: 'AQUSJDHWOEU78',
    house_no: 'Plot 564',
    house_street: 'Plot 564. Ubairgo Estate Karsana, FCT Abuja',
    house_state: 'FCT ABUJA',
    house_condition: 'Newly Developed',
    house_size: '4200 sqft',
    house_status: 'For Sale',
    amount: '₦312,340,000',
    house_title:
        'Newly Built, Funished and Serviced Duplex, 5 bedroom, 6 toilet, 2 kitches.',
    house_description: '',
    house_bedrooms: '5',
    house_toilet: '6',
    house_kitchen: '3',
    iclude_bq: true,
    iclude_pool: true,
    bq_details: '2 bedroom selcontain BQ',
    house_images: ['assets/temp/housedp7.jpeg']);

HouseModel plot303 = HouseModel(
    house_id: 'AQUSJDHWOEU78',
    house_no: 'Plot 303',
    house_street: 'Plot 303. Ubairgo Estate Karsana, FCT Abuja',
    house_state: 'FCT ABUJA',
    house_condition: 'Newly Developed',
    house_size: '4200 sqft',
    house_status: 'For Sale',
    amount: '₦312,340,000',
    house_title:
        'Family of 3 Bungalow Newly Built, Funished and Serviced, 4 bedroom, 5 toilet, 1 kitches.',
    house_description: '',
    house_bedrooms: '4',
    house_toilet: '5',
    house_kitchen: '1',
    iclude_bq: true,
    iclude_pool: true,
    bq_details: '2 bedroom selcontain BQ',
    house_images: ['assets/temp/housbg.jpeg']);

HouseModel plot502 = HouseModel(
    house_id: 'AQUSJDHWOEU78',
    house_no: 'Plot 502',
    house_street: 'Plot 502. Ubairgo Estate Karsana, FCT Abuja',
    house_state: 'FCT ABUJA',
    house_condition: 'Newly Developed',
    house_size: '4200 sqft',
    house_status: 'For Rent',
    amount: '₦3,340,000/Year',
    house_title:
        'Family of 3 Bungalow Newly Built, Funished and Serviced, 4 bedroom, 5 toilet, 1 kitches.',
    house_description: '',
    house_bedrooms: '4',
    house_toilet: '5',
    house_kitchen: '1 & half',
    iclude_bq: true,
    iclude_pool: true,
    bq_details: '2 bedroom selcontain BQ',
    house_images: ['assets/temp/housebg8.jpeg']);

HouseModel plot503 = HouseModel(
    house_id: 'AQUSJDHWOEU78',
    house_no: 'Plot 503',
    house_street: 'Plot 502. Ubairgo Estate Karsana, FCT Abuja',
    house_state: 'FCT ABUJA',
    house_condition: 'Newly Developed',
    house_size: '4200 sqft',
    house_status: 'For Rent',
    amount: '₦3,340,000/Year',
    house_title:
        'Bungalow Newly Built, Funished and Serviced, 4 bedroom, 5 toilet, 1 kitches.',
    house_description: '',
    house_bedrooms: '4',
    house_toilet: '5',
    house_kitchen: '1 & half',
    iclude_bq: true,
    iclude_pool: true,
    bq_details: '2 bedroom selcontain BQ',
    house_images: ['assets/temp/house83.jpeg']);
