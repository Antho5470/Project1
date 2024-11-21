class BookingModel {
  String id; // Booking ID (Firestore will auto-generate this)
  String tenantId; // The user id of the tenant
  String roomId; // The room that the tenant booked
  String roomName; // The name of the room booked
  double rent; // The rent of the room
  String status; // 'Booked', 'Cancelled', 'Completed', etc.
  DateTime bookingDate; // Date when the room was booked

  BookingModel({
    required this.id,
    required this.tenantId,
    required this.roomId,
    required this.roomName,
    required this.rent,
    required this.status,
    required this.bookingDate,
  });

  // Convert from Firestore document to BookingModel
  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return BookingModel(
      id: doc.id,
      tenantId: data['tenant_id'] ?? '',
      roomId: data['room_id'] ?? '',
      roomName: data['room_name'] ?? '',
      rent: data['rent'] ?? 0.0,
      status: data['status'] ?? 'Booked', // Default to 'Booked'
      bookingDate: (data['booking_date'] as Timestamp).toDate(),
    );
  }

  // Convert BookingModel to Firestore data
  Map<String, dynamic> toMap() {
    return {
      'tenant_id': tenantId,
      'room_id': roomId,
      'room_name': roomName,
      'rent': rent,
      'status': status,
      'booking_date': Timestamp.fromDate(bookingDate),
    };
  }
}