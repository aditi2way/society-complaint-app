class AppConstants {
  // User roles
  static const String roleResident = 'resident';
  static const String roleAdmin = 'admin';
  static const String roleMaintenance = 'maintenance';
  static const String roleSecurity = 'security';

  // Complaint statuses
  static const String statusSubmitted = 'submitted';
  static const String statusInReview = 'in_review';
  static const String statusAssigned = 'assigned';
  static const String statusInProgress = 'in_progress';
  static const String statusResolved = 'resolved';

  // Complaint categories
  static const List<Map<String, String>> categories = [
    {'id': 'plumbing', 'label': 'Plumbing', 'icon': '🔧'},
    {'id': 'electrical', 'label': 'Electrical', 'icon': '⚡'},
    {'id': 'security', 'label': 'Security', 'icon': '🔒'},
    {'id': 'cleanliness', 'label': 'Cleanliness', 'icon': '🧹'},
    {'id': 'parking', 'label': 'Parking', 'icon': '🚗'},
    {'id': 'lift', 'label': 'Lift / Elevator', 'icon': '🛗'},
    {'id': 'noise', 'label': 'Noise Complaint', 'icon': '🔊'},
    {'id': 'water', 'label': 'Water Supply', 'icon': '💧'},
    {'id': 'garden', 'label': 'Garden / Common Area', 'icon': '🌿'},
    {'id': 'other', 'label': 'Other', 'icon': '📋'},
  ];

  // Priority levels
  static const List<String> priorities = ['Low', 'Medium', 'High', 'Urgent'];

  // Firestore collections
  static const String usersCollection = 'users';
  static const String complaintsCollection = 'complaints';
  static const String messagesCollection = 'messages';
  static const String noticesCollection = 'notices';
}