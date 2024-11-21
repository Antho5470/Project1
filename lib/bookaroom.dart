Future<void> bookRoom(String roomId, String roomName, double rent) async {
  // Get the current tenant's ID (from Firebase Auth)
  String tenantId = FirebaseAuth.instance.currentUser!.uid;

  // Get the current date and time for the booking
  DateTime bookingDate = DateTime.now();

  // Create the BookingModel object
  BookingModel booking = BookingModel(
    id: '', // Firestore will generate the ID
    tenantId: tenantId,
    roomId: roomId,
    roomName: roomName,
    rent: rent,
    status: 'Booked', // Initially the status is 'Booked'
    bookingDate: bookingDate,
  );

  try {
    // Save the booking in Firestore
    DocumentReference bookingRef = await FirebaseFirestore.instance
        .collection('bookings')
        .add(booking.toMap());

    // Optionally, update the room availability status
    await FirebaseFirestore.instance.collection('rooms').doc(roomId).update({
      'availability': false, // Mark room as unavailable once it's booked
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Room booked successfully')));
  } catch (e) {
    print('Error booking room: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to book room')));
  }
}