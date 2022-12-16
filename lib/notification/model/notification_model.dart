import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id;
  final String type;
  final String title;
  final String description;
  final String userId;
  final bool isRead;
  final bool isArchieve;
  final Map meta;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.userId,
    required this.isRead,
    required this.isArchieve,
    required this.meta,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return NotificationModel(
      id: id ?? map['id'],
      type: map['type'],
      title: map['title'],
      description: map['description'],
      isRead: map['is_read'] ?? false,
      isArchieve: map['is_archieve'] ?? false,
      userId: map['user_id'],
      meta: map['meta'],
      createdAt: (map['created_at'] as Timestamp).toDate(),
      updatedAt: (map['updated_at'] as Timestamp).toDate(),
    );
  }
}
