import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String priority;
  final String status;
  final String residentId;
  final String residentName;
  final String flatNo;
  final String? assignedTo;
  final String? assignedToName;
  final List<String> images;
  final double? rating;
  final String? feedback;
  final DateTime createdAt;
  final DateTime updatedAt;

  ComplaintModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.status,
    required this.residentId,
    required this.residentName,
    required this.flatNo,
    this.assignedTo,
    this.assignedToName,
    required this.images,
    this.rating,
    this.feedback,
    required this.createdAt,
    required this.updatedAt,
  });
factory ComplaintModel.fromMap(Map<String, dynamic> map, String id) {
    return ComplaintModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? 'other',
      priority: map['priority'] ?? 'Medium',
      status: map['status'] ?? 'submitted',
      residentId: map['residentId'] ?? '',
      residentName: map['residentName'] ?? '',
      flatNo: map['flatNo'] ?? '',
      assignedTo: map['assignedTo'],
      assignedToName: map['assignedToName'],
      images: List<String>.from(map['images'] ?? []),
      rating: (map['rating'] as num?)?.toDouble(),
      feedback: map['feedback'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'priority': priority,
      'status': status,
      'residentId': residentId,
      'residentName': residentName,
      'flatNo': flatNo,
      'assignedTo': assignedTo,
      'assignedToName': assignedToName,
      'images': images,
      'rating': rating,
      'feedback': feedback,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}