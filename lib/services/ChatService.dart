import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // إنشاء غرفة دردشة جديدة
  Future<void> createChatRoom(
      String tripId, String driverId, List<String> passengerIds) async {
    try {
      await _firestore.collection('chatRooms').doc(tripId).set({
        'tripId': tripId,
        'driverId': driverId,
        'passengerIds': passengerIds,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error creating chat room: $e');
    }
  }

  // إرسال رسالة إلى غرفة الدردشة الخاصة بالاشتراك
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String senderName,
    required String message,
  }) async {
    try {
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'senderId': senderId,
        'senderName': senderName,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("❌ Error sending message: $e");
    }
  }

  // جلب الرسائل حسب ID الاشتراك (subscription/chat room)
  Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // إضافة راكب إلى غرفة الدردشة
  Future<void> addPassengerToChatRoom(String tripId, String passengerId) async {
    try {
      await _firestore.collection('chatRooms').doc(tripId).update({
        'passengerIds': FieldValue.arrayUnion([passengerId]),
      });
    } catch (e) {
      print('Error adding passenger to chat room: $e');
    }
  }

  // إزالة راكب من غرفة الدردشة
  Future<void> removePassengerFromChatRoom(
      String tripId, String passengerId) async {
    try {
      await _firestore.collection('chatRooms').doc(tripId).update({
        'passengerIds': FieldValue.arrayRemove([passengerId]),
      });
    } catch (e) {
      print('Error removing passenger from chat room: $e');
    }
  }

  // حذف غرفة الدردشة
  Future<void> deleteChatRoom(String tripId) async {
    try {
      await _firestore.collection('chatRooms').doc(tripId).delete();
    } catch (e) {
      print('Error deleting chat room: $e');
    }
  }
}
