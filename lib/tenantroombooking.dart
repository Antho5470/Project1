class RoomBookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rooms')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('rooms').where('availability', isEqualTo: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No available rooms'));
          }

          final rooms = snapshot.data!.docs;

          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              var room = rooms[index];
              return ListTile(
                title: Text(room['room_name']),
                subtitle: Text('Rent: ${room['rent']}'),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Handle booking room
                    FirebaseFirestore.instance.collection('bookings').add({
                      'room_id': room.id,
                      'tenant_id': FirebaseAuth.instance.currentUser!.uid,
                      'status': 'Booked',
                    });
                  },
                  child: Text('Book'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}