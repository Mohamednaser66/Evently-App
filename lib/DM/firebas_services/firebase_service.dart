import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/DM/category_dm.dart';
import 'package:evently/DM/event_data.dart';
import 'package:evently/DM/user_dm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  static CollectionReference<EventData> getEventCollection() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<EventData> collection = db
        .collection('events')
        .withConverter(
          fromFirestore:
              (snapshot, options) => EventData.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
    return collection;
  }

  static Future<void> addEventToFireStore(EventData event) {
    CollectionReference<EventData> eventsCollection = getEventCollection();
    DocumentReference document = eventsCollection.doc();
    event.id = document.id;
    return document.set(event);
  }

  static getEvents() async {
    CollectionReference<EventData> eventCollection = getEventCollection();
    var documentsSnapShot = await eventCollection.get();
    List<QueryDocumentSnapshot<EventData>> documentsSnapShotList =
        documentsSnapShot.docs;
    List<EventData> events =
        documentsSnapShotList
            .map((documentSnapshot) => documentSnapshot.data())
            .toList();
    return events;
  }

  static Future<List<EventData>> getFavEVents() async {
    CollectionReference<EventData> collection = getEventCollection();
    QuerySnapshot<EventData> querySnapshot =
        await collection
            .where(
              FieldPath.documentId,
              whereIn: UserDM.currentUser!.favEventIds,
            )
            .get();
    List<EventData> events =
        querySnapshot.docs.map((snapshot) => snapshot.data()).toList();
    return events;
  }

  static Stream<List<EventData>> getEventsRealTime(CategoryDM category) async* {
    CollectionReference<EventData> eventsCollection = getEventCollection();
    Stream<QuerySnapshot<EventData>> eventSnapShot =
        eventsCollection
            .orderBy('date')
            .where(
              "categoryId",
              isEqualTo: category.id == "1" ? null : category?.id,
            )
            .snapshots();

    Stream<List<EventData>> eventsList = eventSnapShot.map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );

    yield* eventsList;
  }

  static register(String password, String email, String name) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserDM user = UserDM(
      id: credential.user!.uid,
      name: name,
      email: email,
      favEventIds: [],
    );
    addUserToFireStore(user);
  }

  static login(String email, String password) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    UserDM? user = await getUserFromFireStore(credential.user!.uid);
    UserDM.currentUser = user;
  }
  static logOut()async{
    await  FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  static Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print('Password reset email sent!');
    } catch (e) {
      print('Error: $e');
    }
  }


  static Future<void> removeEventFromFav(String eventId) {
    UserDM currentUser = UserDM.currentUser!;
    currentUser.favEventIds.remove(eventId);
    CollectionReference<UserDM> userCollection = getUsersCollection();
    DocumentReference<UserDM> userDoc = userCollection.doc(currentUser.id);
    return userDoc.set(currentUser);
  }

  static Future<void> addEventToFav(String eventId) {
    UserDM currentUser = UserDM.currentUser!;
    currentUser.favEventIds.add(eventId);
    CollectionReference<UserDM> usersCollection = getUsersCollection();
    DocumentReference<UserDM> document = usersCollection.doc(currentUser.id);
    return document.set(currentUser);
  }

  static getUsersCollection() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<UserDM> collection = db
        .collection('users')
        .withConverter(
          fromFirestore:
              (snapshot, options) => UserDM.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
    return collection;
  }

  static addUserToFireStore(UserDM user) {
    CollectionReference<UserDM> collection = getUsersCollection();
    var doc = collection.doc(user.id);
    return doc.set(user);
  }

  static getUserFromFireStore(String uid) async {
    CollectionReference<UserDM> collection = getUsersCollection();
    DocumentSnapshot<UserDM> documentSnapshot = await collection.doc(uid).get();
    return documentSnapshot.data();
  }

 static Future<void> updateEvent(EventData event)async{
    CollectionReference collection =getEventCollection();
   DocumentReference document= collection.doc(event.id);
  await document.update(event.toJson());

  }

static Future<void> deleteEvent(String id)async{
    CollectionReference collection =getEventCollection();
 DocumentReference  document = collection.doc(id);
 await document.delete();

 }

  static signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    var userData = await FirebaseAuth.instance.signInWithCredential(credential);
    UserDM user = UserDM(
      id: userData.user!.uid,
      name: userData.user!.displayName!,
      email: userData.user!.email!,
      favEventIds: [],
    );
    await addUserToFireStore(user);

     UserDM userDM =await getUserFromFireStore(userData.user!.uid);
     UserDM.currentUser =userDM;
  }
}
