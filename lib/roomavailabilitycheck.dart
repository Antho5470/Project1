Future<bool> isRoomAvailable(String roomId) async {
  var roomDoc = await FirebaseFirestore.instance.collection('rooms').doc(roomId).get();
  return roomDoc.exists && roomDoc['availability'] == true;
}