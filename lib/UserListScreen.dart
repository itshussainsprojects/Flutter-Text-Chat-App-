// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebaselab/Chat_Page.dart';
// import 'package:flutter/material.dart';
// // Assuming this is your chat screen.

// class UserListScreen extends StatefulWidget {
//   @override
//   _UserListScreenState createState() => _UserListScreenState();
// }

// class _UserListScreenState extends State<UserListScreen> {
//   List<User> usersList = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUsers();
//   }

//   // Fetch users from Firestore
//   Future<void> _fetchUsers() async {
//     try {
//       // Get the list of users from Firestore
//       QuerySnapshot querySnapshot =
//           await FirebaseFirestore.instance.collection('users').get();

//       if (querySnapshot.docs.isNotEmpty) {
//         setState(() {
//           usersList = querySnapshot.docs.map((doc) {
//             return User(
//               email: doc['email'],
//               username: doc['username'] ?? 'Anonymous',
//             );
//           }).toList();
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           usersList = []; // No users found
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print('Error fetching users: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User List'),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : usersList.isEmpty
//               ? Center(child: Text('No users found'))
//               : ListView.builder(
//                   itemCount: usersList.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(usersList[index].username),
//                       subtitle: Text(usersList[index].email),
//                       onTap: () {
//                         // Navigate to chat screen when tapping on a user
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ChatScreen(
//                               chatPartnerEmail: usersList[index].email,
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//     );
//   }
// }

// class User {
//   final String email;
//   final String username;

//   User({required this.email, required this.username});
// }
