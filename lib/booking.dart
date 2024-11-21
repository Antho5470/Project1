class BookRentalScreen extends StatefulWidget {
  @override
  _BookRentalScreenState createState() => _BookRentalScreenState();
}

class _BookRentalScreenState extends State<BookRentalScreen> {
  final _rentalIdController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _bookRental() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // User is not logged in
        return;
      }

      final bookingRef = _firestore.collection('bookings').doc();
      await bookingRef.set({
        'client_id': user.uid,
        'rental_id': _rentalIdController.text,
        'start_date': _startDateController.text,
        'end_date': _endDateController.text,
        'date_booked': Timestamp.now(),
      });

      // Navigate back after booking rental
      Navigator.pop(context);
    } catch (e) {
      print("Error booking rental: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Rental')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _rentalIdController,
              decoration: InputDecoration(labelText: 'Rental ID'),
            ),
            TextField(
              controller: _startDateController,
              decoration: InputDecoration(labelText: 'Start Date'),
            ),
            TextField(
              controller: _endDateController,
              decoration: InputDecoration(labelText: 'End Date'),
            ),
            ElevatedButton(
              onPressed: _bookRental,
              child: Text('Book Rental'),
            ),
          ],
        ),
      ),
    );
  }
}