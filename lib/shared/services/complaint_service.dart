import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import '../models/complaint_model.dart';
import '../../core/constants/app_constants.dart';

class ComplaintService {
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final _uuid = const Uuid();
  Future<void> submitComplaint({
    required String title,
    required String description,
    required String category,
    required String priority,
    required String residentId,
    required String residentName,
    required String flatNo,
    List<File> images = const [],
  }) async {
    final id = _uuid.v4();
    List<String> imageUrls = [];
    for (var image in images) {
      final ref = _storage.ref('complaints/$id/${_uuid.v4()}.jpg');
      await ref.putFile(image);
      final url = await ref.getDownloadURL();
      imageUrls.add(url);
    }

    final complaint = ComplaintModel(
      id: id,
      title: title,
      description: description,
      category: category,
      priority: priority,
      status: AppConstants.statusSubmitted,
      residentId: residentId,
      residentName: residentName,
      flatNo: flatNo,
      images: imageUrls,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _db
        .collection(AppConstants.complaintsCollection)
        .doc(id)
        .set(complaint.toMap());
  }
  Stream<List<ComplaintModel>> getAllComplaints() {
    return _db
        .collection(AppConstants.complaintsCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => ComplaintModel.fromMap(doc.data(), doc.id))
            .toList());
  }
  Stream<List<ComplaintModel>> getMyComplaints(String residentId) {
    return _db
        .collection(AppConstants.complaintsCollection)
        .where('residentId', isEqualTo: residentId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => ComplaintModel.fromMap(doc.data(), doc.id))
            .toList());
  }
  Stream<List<ComplaintModel>> getAssignedComplaints(String staffId) {
    return _db
        .collection(AppConstants.complaintsCollection)
        .where('assignedTo', isEqualTo: staffId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => ComplaintModel.fromMap(doc.data(), doc.id))
            .toList());
  }
  Stream<ComplaintModel?> getComplaintById(String complaintId) {
    return _db
        .collection(AppConstants.complaintsCollection)
        .doc(complaintId)
        .snapshots()
        .map((doc) =>
            doc.exists ? ComplaintModel.fromMap(doc.data()!, doc.id) : null);
  }

  Future<void> updateStatus(String complaintId, String status) async {
    await _db
        .collection(AppConstants.complaintsCollection)
        .doc(complaintId)
        .update({
      'status': status,
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> assignComplaint(
      String complaintId, String staffId, String staffName) async {
    await _db
        .collection(AppConstants.complaintsCollection)
        .doc(complaintId)
        .update({
      'assignedTo': staffId,
      'assignedToName': staffName,
      'status': AppConstants.statusAssigned,
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> rateComplaint(
      String complaintId, double rating, String feedback) async {
    await _db
        .collection(AppConstants.complaintsCollection)
        .doc(complaintId)
        .update({
      'rating': rating,
      'feedback': feedback,
      'updatedAt': Timestamp.now(),
    });
  }
  Future<void> sendMessage({
    required String complaintId,
    required String senderId,
    required String senderName,
    required String text,
  }) async {
    await _db
        .collection(AppConstants.complaintsCollection)
        .doc(complaintId)
        .collection(AppConstants.messagesCollection)
        .add({
      'senderId': senderId,
      'senderName': senderName,
      'text': text,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<List<Map<String, dynamic>>> getMessages(String complaintId) {
    return _db
        .collection(AppConstants.complaintsCollection)
        .doc(complaintId)
        .collection(AppConstants.messagesCollection)
        .orderBy('timestamp')
        .snapshots()
        .map((snap) => snap.docs.map((doc) => doc.data()).toList());
  }
}