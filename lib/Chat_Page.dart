// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ChatScreen extends StatefulWidget {
//   final String chatPartnerEmail;

//   const ChatScreen({Key? key, required this.chatPartnerEmail}) : super(key: key);

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   late String currentUserId;
//   late String chatId;

//   @override
//   void initState() {
//     super.initState();
//     currentUserId = _auth.currentUser!.uid;
//     chatId = _getChatId(currentUserId, widget.chatPartnerEmail);
//   }

//   // Generate chat ID based on user IDs
//   String _getChatId(String userId1, String userId2) {
//     return userId1.compareTo(userId2) < 0
//         ? '${userId1}_$userId2'
//         : '${userId2}_$userId1';
//   }

//   // Send message to Firestore
//   Future<void> _sendMessage() async {
//     String message = _messageController.text.trim();
//     if (message.isEmpty) return;

//     try {
//       // Create a chat document if it doesn't exist
//       final chatDocRef = _firestore.collection('chats').doc(chatId);

//       await chatDocRef.set({
//         'users': [currentUserId, widget.chatPartnerEmail],
//         'lastMessage': message,
//         'timestamp': FieldValue.serverTimestamp(),
//       }, SetOptions(merge: true));

//       // Store the message in the 'messages' sub-collection
//       await chatDocRef.collection('messages').add({
//         'senderId': currentUserId,
//         'receiverEmail': widget.chatPartnerEmail,
//         'message': message,
//         'timestamp': FieldValue.serverTimestamp(),
//       });

//       _messageController.clear();
//     } catch (e) {
//       print('Error sending message: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat with ${widget.chatPartnerEmail}'),
//       ),
//       body: Column(
//         children: [
//           // Messages List
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: _firestore
//                   .collection('chats')
//                   .doc(chatId)
//                   .collection('messages')
//                   .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 final messages = snapshot.data!.docs;
//                 return ListView.builder(
//                   reverse: true, // Show the latest message at the bottom
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     final message = messages[index];
//                     final isMe = message['senderId'] == currentUserId;

//                     return Align(
//                       alignment: isMe
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(
//                           vertical: 5,
//                           horizontal: 10,
//                         ),
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: isMe ? Colors.blue[100] : Colors.grey[300],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Text(
//                           message['message'],
//                           style: TextStyle(
//                             color: isMe ? Colors.black : Colors.black87,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),

//           // Message Input Field
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: const InputDecoration(
//                       hintText: 'Type your message...',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
