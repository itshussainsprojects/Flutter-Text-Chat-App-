Chat App
A simple real-time chat application built using Flutter and Firebase. This app allows users to register, log in, and communicate with each other via real-time messaging. It leverages Firebase Authentication for user management and Firestore for storing and syncing messages.

Features
User Registration & Login: Users can sign up and log in using Firebase Authentication (Email/Password).
Real-time Messaging: Send and receive messages instantly with real-time updates using Firebase Firestore.
User Search: Users can search for other users by email to start chatting.
Message History: All chat messages are stored in Firestore and are accessible for future reference.
Two-Way Communication: Both users can send and receive messages in real-time.
Tech Stack
Flutter: Framework used for building the mobile app.
Firebase Authentication: For user registration and login.
Firestore: For storing and syncing messages in real-time.
Setup
Prerequisites
Flutter SDK (latest version)
Firebase Project (set up for Firestore, Firebase Authentication)
Android Studio or VS Code for development
A device or emulator for testing
Installation
Clone the repository:

bash
Copy
Edit
git clone https://github.com/yourusername/chat-app.git
cd chat-app
Install Flutter dependencies:

bash
Copy
Edit
flutter pub get
Set up Firebase:

Go to the Firebase Console, create a new project.
Add your app’s Firebase credentials to the project.
Enable Firestore and Firebase Authentication (Email/Password).
Run the app:

bash
Copy
Edit
flutter run
Firebase Firestore Rules
Ensure the Firebase Firestore rules allow read and write access for authenticated users:

bash
Copy
Edit
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
How the App Works
User Registration: Users can sign up with their email and password, or log in if they already have an account.
User Search: Users can search for others by their email and start a chat.
Messaging: Once a chat is started, users can send and receive messages in real-time.
Message History: All messages are stored in Firestore and can be accessed anytime during the chat session.
Features to Add in Future
Push Notifications: Notify users when they receive new messages.
Message Read Status: Mark messages as read/unread.
User Profile: Allow users to update their profile information.
Contributing
Fork the repository.
Create a new branch (git checkout -b feature-name).
Commit your changes (git commit -am 'Add new feature').
Push to the branch (git push origin feature-name).
Open a pull request.
License
This project is open source and available under the MIT License.
