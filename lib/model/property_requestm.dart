import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyRequestF {
  String plot_no;
  String request_id;
  String request;
  String request_by;
  List<dynamic> search_query;
  Timestamp date_reg;
  String status;
  String extra_note;
  String reviewed_by;

  PropertyRequestF({
    required this.plot_no,
    required this.request_id,
    required this.request,
    required this.request_by,
    required this.search_query,
    required this.date_reg,
    required this.status,
    required this.extra_note,
    required this.reviewed_by,
  });

  factory PropertyRequestF.fromDocument(DocumentSnapshot doc) {
    return PropertyRequestF(
      plot_no: doc.get('plot_no'),
      request_id: doc.get('request_id'),
      request: doc.get('request'),
      request_by: doc.get('request_by'),
      search_query: doc.get('search_query'),
      date_reg: doc.get('date_reg'),
      status: doc.get('status'),
      extra_note: doc.get('extra_note'),
      reviewed_by: doc.get('reviewed_by'),
    );
  }
}
