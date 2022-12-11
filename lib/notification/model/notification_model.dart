import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String userId;
  final bool isRead;
  final bool isArchieve;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.isRead,
    required this.isArchieve,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'],
      title: map['title'],
      isRead: map['is_read'],
      isArchieve: map['is_archieve'],
      description: map['description'],
      userId: map['user_id'],
      createdAt: (map['created_at'] as Timestamp).toDate(),
      updatedAt: (map['updated_at'] as Timestamp).toDate(),
    );
  }
}
