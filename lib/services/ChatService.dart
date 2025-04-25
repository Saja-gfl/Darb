import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'request.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // إنشاء غرفة دردشة جديدة
  Future<void> createChatRoom(
      String tripId, String driverId, String passengerId) async {
    try {
      final chatRoomDoc =
          await _firestore.collection('chatRooms').doc(tripId).get();

      if (chatRoomDoc.exists) {
        // إذا كانت غرفة الدردشة موجودة، أضف الراكب الجديد فقط
        await _firestore.collection('chatRooms').doc(tripId).update({
          'passengerIds': FieldValue.arrayUnion([passengerId]),
        });
      } else {
        // إذا لم تكن غرفة الدردشة موجودة، أنشئ غرفة جديدة
        await _firestore.collection('chatRooms').doc(tripId).set({
          'tripId': tripId,
          'driverId': driverId,
          'passengerIds': [passengerId],
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error creating or updating chat room: $e');
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
      //حالة الاشتراك
      final userDoc = await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(chatId)
          .get();

      if (userDoc.exists) {
        final status = userDoc.data()?['sub_status'];
        // منع الإرسال إذا كانت الحالة "منتهية"
        if (status == 'منتهي') {
          // إظهار رسالة خطأ
          print("❌ لا يمكن إرسال الرسائل: الاشتراك منتهي");
          return;
        }
      }
      final timestamp = FieldValue.serverTimestamp();

      await _firestore
          .collection('chatRooms')
          .doc(chatId)
          .collection('messages')
          .add({
        'senderId': senderId,
        'senderName': senderName,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // تحديث آخر رسالة في غرفة الدردشة
      await _firestore.collection('chatRooms').doc(chatId).update({
        'lastMessage': message,
        'timestamp': FieldValue.serverTimestamp(),
        'unread': FieldValue.increment(1), // زيادة عدد الرسائل غير المقروءة
      });
    } catch (e) {
      print("❌ Error sending message: $e");
    }
  }

  // جلب الرسائل حسب ID الاشتراك (subscription/chat room)
  Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore
        .collection('chatRooms')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // إضافة راكب إلى غرفة الدردشة
  /*Future<void> addPassengerToChatRoom(String tripId, String passengerId) async {
    try {
      await _firestore.collection('chatRooms').doc(tripId).update({
        'passengerIds': FieldValue.arrayUnion([passengerId]),
      });
    } catch (e) {
      print('Error adding passenger to chat room: $e');
    }
  }*/

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

  Future<List<Map<String, dynamic>>> getDriverChatRooms(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('chatRooms')
          .where('driverId', isEqualTo:  userId)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'tripId': data['tripId'] + ':رحلة رقم '?? '',
          //'driverId': data['driverId'] ?? '',
          'lastMessage':
              data['lastMessage'] ?? 'لا توجد رسائل', // رسالة افتراضية
          'time': data['timestamp'] is Timestamp
                  ? ChatService.formatTimestamp(data['timestamp'])
                  : 'مافيه وقت', // تحقق من النوع // وقت افتراضي
          'unread': data['unread'] ?? 0, // عدد الرسائل غير المقروءة
        };
      }).toList();
    } catch (e) {
      print('Error fetching user chat rooms: $e');
      return [];
    }
  }
  //getUserChatRooms
  Future<List<Map<String, dynamic>>> getUserChatRooms(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('chatRooms')
          .where('passengerIds', arrayContains: userId)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'tripId': data['tripId'] ?? '',
          'driverId': data['driverId'] ?? '',
          'name': data['tripId'] ?? 'غير معروف', // اسم افتراضي
          'lastMessage':
              data['lastMessage'] ?? 'لا توجد رسائل', // رسالة افتراضية
          'time': data['timestamp'] 
         // تنسيق الوقت إذا كان موجودًا
        ?? 'غير متrفر', // وقت افتراضي
          'unread': data['unread'] ?? 0, // عدد الرسائل غير المقروءة
        };
      }).toList();
    } catch (e) {
      print('Error fetching user chat rooms: $e');
      return [];
    }
  }

  Future<bool> canSendMessage(String chatId, String userId) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(chatId)
          .collection('users')
          .doc(userId)
          .get();

      // تحقق من  الاشتراك العامه 
      final subscriptionDoc = await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(chatId)
          .get();
      if (subscriptionDoc.exists) {
        final Status = subscriptionDoc.data()?['status'];
        if (Status == 'منتهي') {
          return false; // الاشتراك منتهي
        }
      }


      if (userDoc.exists) {
        final subStatus = userDoc.data()?['sub_status'];
        if (subStatus == 'منتهي') {
          return false; // الاشتراك منتهي
        }
      }


      return true; // يمكن الإرسال
    } catch (e) {
      print("❌ خطأ أثناء التحقق من حالة الاشتراك: $e");
      return false;
    }
  }

  // إعادة تعيين عدد الرسائل غير المقروءة
  Future<void> markMessagesAsRead(String chatId) async {
    try {
      await _firestore.collection('chatRooms').doc(chatId).update({
        'unread': 0,
      });
    } catch (e) {
      print('Error marking messages as read: $e');
    }
  }

  static String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'غير متوفر';
    final date = timestamp.toDate();
    return DateFormat('hh:mm a').format(date); // تنسيق الوقت
  }

}
