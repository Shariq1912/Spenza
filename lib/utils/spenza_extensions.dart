import 'dart:math';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/utils/firestore_constants.dart';

extension ImageExtension on String {
  String get assetImageUrl {
    return 'assets/images/$this';
  }
  String get assetSvgIconUrl {
    return 'assets/bottom_nav_icons/$this';
  }
}

extension SnackbarExtension on BuildContext {
  void showSnackBar({required String message}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

extension SharedPreferencesExtension on SharedPreferences {
  String getUserId() {
    return getString('uid') ?? "Cool User";
  }

  bool isUserLoggedIn() {
    return getBool('is_login') ?? false;
  }

  bool isFirstLogin() {
    return getBool('is_first_login') ?? true;
  }

  String getUserListId() {
    return getString('user_list_id') ?? "4NlYnhmchdlu528Gw2yK";
  }

  String getUserListName() {
    return getString('user_list_name') ?? MyListConstant.myListCollection;
  }

  String getPostalCode() {
    return getString('zipCode') ?? "44110";
  }

  String getProfilePhoto() {
    String? result = getString('profilePhoto');
    return result!.isNotEmpty ? result : 'assets/images/user.png';
  }
}

extension NumberFormat on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

extension DistanceFormatter on double {
  String formatDistance() {
    double distanceInMeters = this;

    if (distanceInMeters < 1000) {
      // If distance is less than 1 kilometer, display it in meters
      return '${distanceInMeters.toStringAsFixed(0)} m';
    } else {
      // If distance is equal to or greater than 1 kilometer, display it in kilometers
      double distanceInKilometers = distanceInMeters / 1000;
      return '${distanceInKilometers.toStringAsFixed(1)} km';
    }
  }
}

extension StringExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension LocationStringExtension on GeoPoint {
  String getLocationString() {
    String latitude = this.latitude.toString();
    String longitude = this.longitude.toString();
    return "($latitude, $longitude)";
  }
}

extension FirestoreExtension on FirebaseFirestore {
  DocumentReference getDocumentReferenceFromString(
      {required String collectionName, required String id}) {
    return this.collection(collectionName).doc(id);
  }
}

mixin FirstTimeLoginMixin {
  Future<bool> isFirstTimeLogin(
      {required FirebaseFirestore firestore, required String userId}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection(UserConstant.userCollection)
          .where(UserConstant.userIdField, isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data();
        debugPrint("IS FIRST LOGIN === $userData");
        return !(userData.containsKey(UserConstant.zipCodeField) &&
            userData[UserConstant.zipCodeField] != "");
      }

      return false;
    } catch (error) {
      return false;
    }
  }
}

/// extension for image selection
extension ImagePickerExtension on ImagePicker {
  Future<File?> pickImageFromGallery(BuildContext context) async {
    try {
      final pickedImage = await showDialog<File?>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Select Image'),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () async {
                  Navigator.pop(context, await _pickImage(ImageSource.gallery));
                },
                child: const Text('Choose from Gallery',style: TextStyle(color: Color(0xFF0CA9E6)),),
              ),
              CupertinoDialogAction(
                onPressed: () async {
                  Navigator.pop(context, await _pickImage(ImageSource.camera));
                },
                child: const Text('Capture from Camera',style: TextStyle(color: Color(0xFF0CA9E6)),),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context, null);
                },
                child: const Text('Cancel',style: TextStyle(color: Colors.redAccent,)),
              ),
            ],
          );
        },
      );

      return pickedImage;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }

  Future<File?> _pickImage(ImageSource source) async {
    try {
      final pickedImage = await this.pickImage(source: source);
      if (pickedImage == null) {
        return null;
      }

      final imageFile = File(pickedImage.path);
      return imageFile;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return null;
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }
}

extension FileExtension on File {
  Future<String?> uploadImageToFirebase({ required String path}) async {
    try {
      final storageReference = FirebaseStorage.instance
          .ref()
          .child(path)
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      final uploadTask = storageReference.putFile(this);
      final snapshot = await uploadTask.whenComplete(() {});

      if (snapshot.state == TaskState.success) {
        final downloadURL = await snapshot.ref.getDownloadURL();
        return downloadURL;
      }
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
    }

    return null;
  }
}

/// Not much accurate
double calculateDistance(
  double lat1,
  double lon1,
  double lat2,
  double lon2,
) {
  const int earthRadius = 6371; // in km
  final double dLat = _toRadians(lat2 - lat1);
  final double dLon = _toRadians(lon2 - lon1);
  final double a = pow(sin(dLat / 2), 2) +
      cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * pow(sin(dLon / 2), 2);
  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  final double distance = earthRadius * c;
  return distance;
}

double _toRadians(double degree) {
  return degree * pi / 180;
}

// Function to get GeoPoint instance from Cloud Firestore document data.
GeoPoint geopointFrom(Map<String, dynamic> data) =>
    (data['geo'] as Map<String, dynamic>)['geopoint'] as GeoPoint;
