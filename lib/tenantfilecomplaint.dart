class FileComplaintScreen extends StatefulWidget {
  @override
  _FileComplaintScreenState createState() => _FileComplaintScreenState();
}

class _FileComplaintScreenState extends State<FileComplaintScreen> {
  final _descriptionController = TextEditingController();

  Future<void> fileComplaint() async {
    FirebaseFirestore.instance.collection('complaints').add({
      'description': _descriptionController.text,
      'tenant_id': FirebaseAuth.instance.currentUser!.uid,
      'status': 'Open',
      'timestamp': FieldValue.serverTimestamp(),
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Complaint filed')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('File a Complaint')),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
    child: Column(
    children: [
    TextField(controller: _descriptionController, decoration: InputDecoration(labelText: 'Describe the issue')),
    Elevated