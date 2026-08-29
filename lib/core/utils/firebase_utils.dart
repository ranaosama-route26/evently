import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app_c17_mon_7pm/model/event_data_model.dart';

abstract class FirebaseUtils {
  /// add event on database || data model store event
  /// CRUD, Create Read Update Delete Operation
  ///
  /// Map<String, dynamic>;
  /// json formate
  /// {
  /// "name" : "ahmed",
  /// "age": 25,
  /// "isMale": true,
  /// }

  static CollectionReference<EventDataModel> _getCollectionRef() {
    return FirebaseFirestore.instance
        .collection("EventCollection")
        .withConverter<EventDataModel>(
          fromFirestore:
              (snapshot, _) => EventDataModel.fromFirestore(snapshot.data()!),
          toFirestore: (value, _) => value.toFirestore(),
        );
  }

  static Future<bool> addEvent(EventDataModel event) async {
    try {
      var collectionRef = _getCollectionRef();

      /// collection --> docs --> data
      ///            --> docs --> data
      ///            --> docs --> data
      ///            --> docs --> data
      ///            --> docs
      ///            --> docs

      /// generate new document on collection + id auto generate
      var docRef = collectionRef.doc();

      event.eventID = docRef.id;
      docRef.set(event);
      return Future.value(true);
    } catch (error) {
      return Future.value(false);
    }
  }

  /// One time read
  static Future<List<EventDataModel>> getDataForFirestore() async {
    List<EventDataModel> events = [];

    var collectionRef = _getCollectionRef();
    var data = await collectionRef.get();

    events =
        data.docs.map((element) {
          return element.data();
        }).toList();

    return events;
  }

  /// Real time read || Stream || websocket
  static Stream<QuerySnapshot<EventDataModel>> getStreamDataForFirestore(
    String categoryId,
  ) {
    var collectionRef = _getCollectionRef().where(
      "categoryId",
      isEqualTo: categoryId,
    );
    return collectionRef.snapshots();
  }

  static Stream<QuerySnapshot<EventDataModel>>
  getStreamFavoriteDataForFirestore() {
    var collectionRef = _getCollectionRef().where(
      "isFavorite",
      isEqualTo: true,
    );
    return collectionRef.snapshots();
  }

  static Future<bool> updateEvent(EventDataModel event) async {
    try {
      if (event.eventID == null) return false;
      var collectionRef = _getCollectionRef();
      var docRef = collectionRef.doc(event.eventID);
      docRef.update(event.toFirestore());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteEvent(String? eventId) async {
    try {
      if (eventId == null) return false;
      var collectionRef = _getCollectionRef();
      var docRef = collectionRef.doc(eventId);
      await docRef.delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
