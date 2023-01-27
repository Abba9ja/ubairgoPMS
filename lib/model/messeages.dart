import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ubairgo/model/emergency_model.dart';
import 'package:ubairgo/model/user_model.dart';
import 'package:ubairgo/styles/sysimg_constants.dart';

class MessageF {
  String id;
  String type;
  String content;
  String sender;
  String receiver;
  Timestamp time;
  List<dynamic> views;
  List<dynamic> search_query;

  MessageF({
    required this.id,
    required this.type,
    required this.content,
    required this.sender,
    required this.receiver,
    required this.time,
    required this.views,
    required this.search_query,
  });

  factory MessageF.fromDocument(DocumentSnapshot doc) {
    return MessageF(
      id: doc.get('id'),
      type: doc.get('type'),
      content: doc.get('content'),
      sender: doc.get('sender'),
      receiver: doc.get('receiver'),
      time: doc.get('time'),
      views: doc.get('views'),
      search_query: doc.get('search_query'),
    );
  }
}

class MessageAttachmentF {
  String id;
  String file_name;
  String file_url;
  String alt;
  Timestamp time;
  MessageAttachmentF({
    required this.id,
    required this.file_name,
    required this.file_url,
    required this.alt,
    required this.time,
  });

  factory MessageAttachmentF.fromDocument(DocumentSnapshot doc) {
    return MessageAttachmentF(
      id: doc.get('id'),
      file_name: doc.get('file_name'),
      file_url: doc.get('file_url'),
      time: doc.get('time'),
      alt: doc.get('alt'),
    );
  }
}

class MessagePropertyF {
  String id;
  String plot_no;
  String caption;
  Timestamp time;

  MessagePropertyF({
    required this.id,
    required this.plot_no,
    required this.caption,
    required this.time,
  });

  factory MessagePropertyF.fromDocument(DocumentSnapshot doc) {
    return MessagePropertyF(
      id: doc.get('id'),
      plot_no: doc.get('plot_no'),
      caption: doc.get('caption'),
      time: doc.get('time'),
    );
  }
}

class RecentChatModel {
  String messageId;
  String messageFrom;
  String messageSpaceId;
  Timestamp messageTime;
  String messageSender;
  String messageReciever;
  List<dynamic> messageViews;
  List<dynamic> search_query;

  RecentChatModel({
    required this.messageId,
    required this.messageFrom,
    required this.messageSpaceId,
    required this.messageTime,
    required this.messageSender,
    required this.messageReciever,
    required this.messageViews,
    required this.search_query,
  });

  factory RecentChatModel.fromDocument(DocumentSnapshot doc) {
    return RecentChatModel(
      messageId: doc.get('messageId'),
      messageFrom: doc.get('messageFrom'),
      messageSpaceId: doc.get('messageSpaceId'),
      messageTime: doc.get('messageTime'),
      messageSender: doc.get('messageSender'),
      messageReciever: doc.get('messageReciever'),
      messageViews: doc.get('messageViews'),
      search_query: doc.get('search_query'),
    );
  }
}

class MessageModel {
  String msg_id;
  String msg_type;
  String msg_content;
  List<String> attachement;
  bool islike;
  bool isme;
  String time;

  MessageModel({
    required this.msg_id,
    required this.msg_type,
    required this.msg_content,
    required this.attachement,
    required this.islike,
    required this.isme,
    required this.time,
  });
}

class RecentChats {
  String id;
  MessageModel msg;
  UserModel sender;
  int isread;

  RecentChats(
      {required this.id,
      required this.msg,
      required this.sender,
      required this.isread});
}

List<MessageModel> conversation = [msg3, msg2, msg1, msg0];

RecentChats fatichat =
    RecentChats(id: 'id', msg: msg3, sender: fatima, isread: 0);

RecentChats pharmchat =
    RecentChats(id: 'id', msg: msgpham, sender: pharmacist_assist, isread: 0);

RecentChats policechat =
    RecentChats(id: 'id', msg: msgPolice, sender: police_assist, isread: 2);

RecentChats archchat =
    RecentChats(id: 'id', msg: msgarch, sender: aisha, isread: 0);

List<RecentChats> recents_chat = [fatichat, policechat, pharmchat, archchat];

MessageModel msgarch = MessageModel(
    msg_id: 'msg_id',
    msg_type: 'txt',
    msg_content: 'Join my meeting with d realtor Fatima',
    attachement: [''],
    islike: true,
    isme: true,
    time: '1hr ago');

MessageModel msgpham = MessageModel(
    msg_id: 'msg_id',
    msg_type: 'img',
    msg_content: 'Here\'s the prescription',
    attachement: [''],
    islike: true,
    isme: true,
    time: '30min ago');

MessageModel msgPolice = MessageModel(
    msg_id: 'msg_id',
    msg_type: 'img',
    msg_content: 'Noise complain have been registered',
    attachement: [''],
    islike: true,
    isme: false,
    time: '15min ago');

MessageModel msg0 = MessageModel(
    msg_id: 'msg_id',
    msg_type: 'txt',
    msg_content: 'In respect to your call earlier a meeting have been schedule',
    attachement: [],
    islike: true,
    isme: false,
    time: 'Thur 22 10:00am');

MessageModel msg1 = MessageModel(
    msg_id: 'msg_id',
    msg_type: 'shared_house',
    msg_content: 'To visit this House right?',
    attachement: [f_view, palour, bedroom, toilet],
    islike: true,
    isme: true,
    time: 'Thur 22 10:05 am');

MessageModel msg2 = MessageModel(
    msg_id: 'msg_id',
    msg_type: 'txt',
    msg_content: 'Yeah that\'s the house',
    attachement: [],
    islike: true,
    isme: false,
    time: 'Thur 22 10:12am');

MessageModel msg3 = MessageModel(
    msg_id: 'msg_id',
    msg_type: 'txt',
    msg_content: 'Great see you then',
    attachement: [],
    islike: true,
    isme: true,
    time: '5min ago');
