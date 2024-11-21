class AddRoomScreen extends StatefulWidget {
  @override
  _AddRoomScreenState createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  final _roomNameController = TextEditingController();
  final _rentController = TextEditingController();

  Future<void> addRoom() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Add the room to Firestore
      FirebaseFirestore.instance.collection('rooms').add({
        'room_name': _roomNameController.text,
        'rent': _rentController.text,
        'availability': true,
        'owner_id': FirebaseAuth.instance.currentUser!.uid,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Room added successfully')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Room')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _roomNameController, decoration: InputDecoration(labelText: 'Room Name')),
              TextFormField(controller: _rentController, decoration: InputDecoration(labelText: 'Rent')),
              ElevatedButton(onPressed: addRoom, child: Text('Add Room')),
            ],
          ),
        ),
      ),
    );
  }
}