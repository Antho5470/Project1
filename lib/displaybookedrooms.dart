class MyBookingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get current tenant's ID
    String tenantId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: Text('My Bookings')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .where('tenant_id', isEqualTo: tenantId) // Only show bookings for the current tenant
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No bookings found.'));
          }

          final bookings = snapshot.data!.docs;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              var booking = bookings[index];
              BookingModel bookingModel = BookingModel.fromFirestore(booking);

              return ListTile(
                title: Text(bookingModel.roomName),
                subtitle: Text('Rent: \$${bookingModel.rent}'),
                trailing: Text('Status: ${bookingModel.status}'),
                onTap: () {
                  // Optionally handle the tap (e.g., show booking details)
                },
              );
            },
          );
        },
      ),
    );
  }
}