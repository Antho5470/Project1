class ComplaintModel {
  String id;
  String tenantId; // The user id of the tenant
  String roomId; // The room that the complaint is related to
  String description;
  String status; // 'open', 'in progress', 'resolved'
  DateTime timestamp;

  ComplaintModel({
    required this.id,
    required this.tenantId,
    required this.roomId,
    required this.description,
    required this.status,
    required this.timestamp,
  });

  // Convert from Firestore document to ComplaintModel
  factory ComplaintModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return ComplaintModel(
      id: doc.id,
      tenantId: data['tenant_id'] ?? '',
      roomId: data['room_id'] ?? '',
      description: data['description'] ?? '',
      status: data['status'] ?? 'open',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  // Convert ComplaintModel to Firestore data
  Map<String, dynamic> toMap() {
    return {
      'tenant_id': tenantId,
      'room_id': roomId,
      'description': description,
      'status': status,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}