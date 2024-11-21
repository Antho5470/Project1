class ViewComplaintsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Complaints')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('complaints').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No complaints'));
          }

          final complaints = snapshot.data!.docs;

          return ListView.builder(
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              var complaint = complaints[index];
              return ListTile(
                title: Text(complaint['description']),
                subtitle: Text(complaint['status']),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Handle mark as resolved
                    FirebaseFirestore.instance.collection('complaints').doc(complaint.id).update({'status': 'Resolved'});
                  },
                  child: Text('Resolve'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}