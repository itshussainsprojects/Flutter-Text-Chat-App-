import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String currentUserId;
  String? chatPartnerId;

  @override
  void initState() {
    super.initState();
    currentUserId = _auth.currentUser!.uid;
    _initializeUserDocument(); // Ensure the user document exists
  }

  // Ensure the current user's document exists in Firestore
  Future<void> _initializeUserDocument() async {
    final userDoc = await _firestore.collection('users').doc(currentUserId).get();

    if (!userDoc.exists) {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(currentUserId).set({
          'email': user.email,
          'username': user.displayName ?? 'Anonymous',
        });
      }
    }
  }

  // Send a message to Firestore
  Future<void> _sendMessage(String message) async {
    if (message.trim().isEmpty || chatPartnerId == null) return;

    final chatId = _getChatId(currentUserId, chatPartnerId!);

    try {
      // Save the message in the Firestore
      final chatRef = _firestore.collection('chats').doc(chatId);

      // Ensure the chat document exists
      await chatRef.set({
        'users': [currentUserId, chatPartnerId],
        'lastMessage': message.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Add the message to the messages sub-collection
      await chatRef.collection('messages').add({
        'senderId': currentUserId,
        'receiverId': chatPartnerId,
        'message': message.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      _messageController.clear(); // Clear the message input
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  // Search for a user by email and set chat partner
  Future<void> _searchUserByEmail(String email) async {
    if (email.trim().isEmpty) return;

    try {
      final userQuery = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (userQuery.docs.isNotEmpty) {
        setState(() {
          chatPartnerId = userQuery.docs.first.id;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Chat partner set to $email')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not found')),
        );
      }
    } catch (e) {
      print('Error searching for user: $e');
    }
  }

  // Generate chat ID based on both user IDs
  String _getChatId(String userId1, String userId2) {
    return userId1.compareTo(userId2) < 0
        ? '${userId1}_$userId2'
        : '${userId2}_$userId1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Room'),
      ),
      body: Column(
        children: [
          // Search User Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search user by email...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _searchUserByEmail(_searchController.text),
                ),
              ],
            ),
          ),

          // Chat Messages Section
          Expanded(
            child: chatPartnerId == null
                ? const Center(
                    child: Text('Search for a user to start chatting'),
                  )
                : StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('chats')
                        .doc(_getChatId(currentUserId, chatPartnerId!))
                        .collection('messages')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final messages = snapshot.data!.docs;

                      return ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isMe = message['senderId'] == currentUserId;

                          return Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:
                                    isMe ? Colors.blue[100] : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                message['message'],
                                style: TextStyle(
                                  color: isMe ? Colors.black : Colors.black87,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),

          // Input Field and Send Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) => _sendMessage(value),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _sendMessage(_messageController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
