# Chat App

A simple real-time chat application built using Flutter and Firebase. This app allows users to register, log in, and communicate with each other via real-time messaging. It leverages Firebase Authentication for user management and Firestore for storing and syncing messages.

### Features

- **User Registration & Login**: Users can sign up and log in using Firebase Authentication (Email/Password).
- **Real-time Messaging**: Send and receive messages instantly with real-time updates using Firebase Firestore.
- **User Search**: Users can search for other users by email to start chatting.
- **Message History**: All chat messages are stored in Firestore and are accessible for future reference.
- **Two-Way Communication**: Both users can send and receive messages in real-time.

### Tech Stack

- **Flutter**: Frontend framework for building the mobile application.
- **Firebase**: Provides authentication, real-time database, and Firestore for storing messages.
- **Firebase Authentication**: Manages user login and registration.
- **Firestore**: Cloud-based NoSQL database to store and sync chat messages in real time.

### Installation

To run this project locally:

1.**** Clone this repository:****

git clone https://github.com/itshussainsprojects/Flutter-Text-Chat-App-.git

2) **Navigate to the project directory:**
cd Flutter-Text-Chat-App-
3) **Install the dependencies:**
flutter pub get
4) **Set up Firebase in your Flutter project:**
Follow the official Firebase documentation to add Firebase to your Flutter app: Firebase Flutter Setup
Make sure you add your google-services.json (for Android) or GoogleService-Info.plist (for iOS) to the respective platform directories.
5)**Run App:**
flutter run 

****How to Use****
**Login:** After launching the app, log in using your email and password.
**Search User:** **Once logged in, you can search for users by their email and start chatting.
**Chat:** You can send and receive messages in real-time.
**Firebase Setup**

**Make sure to configure Firebase Firestore and Firebase Authentication in the Firebase Console:**
Create a Firebase project in the Firebase Console.
Enable Firebase Authentication for email/password login.
Set up Firestore database to store and retrieve messages.
Set Firestore security rules as per your needs.
Firebase Firestore Security Rules Example
**Here’s a basic Firestore security rule setup to allow only authenticated users to read and write their data:**


****
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection: Allow read and write only for the authenticated user.
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Chats collection: Allow read and write for authenticated users.
    match /chats/{chatId}/messages/{messageId} {
      allow read, write: if request.auth != null;
    }
  }
}

****

******## How to Use the Chat App******

Follow these steps to use the Chat App and start messaging with others:

### 1. **Sign Up / Log In**

- **First Time Users**: 
  - When you open the app for the first time, you'll be presented with a sign-up screen.
  - Enter a valid email address and password, and press the "Sign Up" button to create a new account.
  
- **Existing Users**:
  - If you've already registered, simply enter your email and password and press the "Log In" button to access the app.

### 2. **Navigating the Home Page**

Once you're logged in, you will be directed to the home page where you can:

- **Search for Users**:
  - At the top of the screen, you will see a search bar where you can type an email address of the person you want to chat with.
  - Once you type the email, click on the search icon. If the user exists, they will appear in the search results.

- **Start a Chat**:
  - Click on a user’s email from the search results to open the chat window and start chatting with them.
  - If the user isn’t available or hasn’t signed up, you will see a notification saying "User not found."

### 3. **Chat Interface**

In the chat window, you can:

- **Send Messages**:
  - Type your message in the text field at the bottom of the screen.
  - After typing the message, click the send button (or press Enter) to send it to the chat partner.
  
- **Real-Time Messaging**:
  - Messages will appear instantly for both you and your chat partner. The app uses Firebase Firestore to update the messages in real-time.
  - Sent messages are displayed in blue, while received messages are shown in grey.

### 4. **Message History**

- All messages exchanged between you and the other user are stored in Firebase Firestore.
- When you open the chat with the same user again, you will see your previous conversations displayed, as messages are saved for future reference.

### 5. **Error Handling**

- **User Not Found**: If the app cannot find the user by email, it will show a message like "User not found."
- **Empty Message**: If you try to send an empty message, it will not be sent, and you will be prompted to type something.
- **Authentication Issues**: If there's an issue with your login, such as incorrect credentials, the app will ask you to re-enter the details.

### Example Walkthrough

1. **Open the App**: You open the app and are presented with the login screen.
2. **Sign Up**: You sign up using the email "hussain@example.com" and a password "password123."
3. **Search for a User**: Once logged in, you search for the email "ahmed@example.com." ->he/she should be already login to app in order to chat.
4. **Start Chatting**: You click on Ahmed's email to open the chat screen. You type "Hello, Ahmed!" and click the send button.
5. **Receive Messages**: Ahmed replies back with "Hi, how are you?" The message appears instantly on your screen.
6. **View Chat History**: After a few days, you open the app again and see the previous conversation with Ahmed still there.

### Troubleshooting

- **App Not Showing Messages**: Ensure you have an active internet connection. Firebase Firestore requires a stable internet connection for real-time updates.
- **Cannot Send Messages**: Check that you have logged in properly and are not trying to send empty messages.
- **User Not Found**: If you can't find the user you're looking for, confirm that they have registered and that the email is entered correctly.

### Conclusion

With this app, you can easily start a conversation with friends, colleagues, or anyone using the app by simply searching for their email. Enjoy chatting!

**Contributing:**
If you would like to contribute to this project developed by **Hussain Ali** , feel free to fork the repository, make changes, and submit a pull request.
******
Screenshots
******

![WhatsApp Image 2025-01-18 at 7 28 41 PM](https://github.com/user-attachments/assets/f1dd186b-967e-450e-8f03-c4ead3cc5a81)

![WhatsApp Image 2025-01-18 at 7 28 43 PM](https://github.com/user-attachments/assets/04a36fbb-f7e5-45b9-9bf3-e2ce44e57f6a)
![WhatsApp Image 2025-01-18 at 7 28 45 PM](https://github.com/user-attachments/assets/bf235b8d-a2ad-4e95-ae62-738338eb177d)
![WhatsApp Image 2025-01-18 at 7 28 47 PM](https://github.com/user-attachments/assets/d50434aa-4b86-4719-b13a-ad09761b83a9)

![WhatsApp Image 2025-01-18 at 7 28 49 PM](https://github.com/user-attachments/assets/cf90614b-e0c3-4eee-b423-a4778be0cd81)

![WhatsApp Image 2025-01-18 at 7 28 51 PM](https://github.com/user-attachments/assets/2f4aed1f-7378-4bc9-9af0-fb4f2d8f74fb)
![WhatsApp Image 2025-01-18 at 7 28 53 PM](https://github.com/user-attachments/assets/7ea18d3a-5f08-4c3f-9f57-7b7092187761)

![WhatsApp Image 2025-01-18 at 7 28 57 PM](https://github.com/user-attachments/assets/731185f1-2742-4e68-a116-e7f9b8bde6c4)

![WhatsApp Image 2025-01-18 at 7 21 14 PM](https://github.com/user-attachments/assets/107c1540-4de9-43bc-881c-58714782590e)

![WhatsApp Image 2025-01-18 at 7 21 14 PM (1)](https://github.com/user-attachments/assets/1fa45f1a-90de-4b9b-b18f-d1f5207d8f24)










