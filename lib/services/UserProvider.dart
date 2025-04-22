import 'package:flutter/material.dart';
import 'FireStore.dart';

class UserProvider with ChangeNotifier {
  String? _uid;
  String? _userName;
  String? _email;
  String? _phoneNumber;
  String? _Gender;
  String? _carType;
  String? _plateNumber;
  bool _isDriver = false;
  String? _tripId;
  String? _subscriptionType;
  String? _price;
  String? _driverId;
  String? _driverName;
  String? _location;
  String? _passengerCount;
  String? _acceptedLocations;

  // Getters
  String? get uid => _uid;
  String? get userName => _userName;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get Gender => _Gender;
  String? get carType => _carType;
  String? get plateNumber => _plateNumber;
  bool get isDriver => _isDriver;
  String? get tripId => _tripId;
  String? get subscriptionType => _subscriptionType;
  String? get price => _price;
  String? get driverId => _driverId;
  String? get driverName => _driverName;
  String? get location => _location;
  String? get passengerCount => _passengerCount;
  String? get acceptedLocations => _acceptedLocations;

  // Setters
  void setUid(String uid) {
    _uid = uid;
    notifyListeners();
  }

  void setUserName(String userName) {
    _userName = userName;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void setGender(String Gender) {
    _Gender = Gender;
    notifyListeners();
  }

  void setCarType(String carType) {
    _carType = carType;
    notifyListeners();
  }

  void setPlateNumber(String plateNumber) {
    _plateNumber = plateNumber;
    notifyListeners();
  }

  void setIsDriver(bool isDriver) {
    _isDriver = isDriver;
    notifyListeners();
  }

  void setTripId(String tripId) {
    _tripId = tripId;
    notifyListeners();
  }

  void setSubscriptionType(String subscriptionType) {
    _subscriptionType = subscriptionType;
    notifyListeners();
  }

  void setPrice(String price) {
    _price = price;
    notifyListeners();
  }

  void setDriverId(String driverId) {
    _driverId = driverId;
    notifyListeners();
  }

  void setDriverName(String driverName) {
    _driverName = driverName;
    notifyListeners();
  }

  void setLocation(String location) {
    _location = location;
    notifyListeners();
  }

  void setPassengerCount(String passengerCount) {
    _passengerCount = passengerCount;
    notifyListeners();
  }

  void setAcceptedLocations(String acceptedLocations) {
    _acceptedLocations = acceptedLocations;
    notifyListeners();
  }


  // load user data
  Future<void> loadUserData(String userId) async {
    final FirestoreService _firestoreService = FirestoreService(); // إنشاء كائن
    final userData = await _firestoreService.getUserData(userId);
    if (userData != null) {
      _uid = userId;
      _userName = userData['name'];
      _email = userData['email'];
      _phoneNumber = userData['phone'];
      _Gender = userData['gender'];
      _location = userData['address'];
      _isDriver = userData['isDriver'] ?? false;
      _plateNumber = userData['plateNumber'] ?? '';
      _subscriptionType = userData['subscriptionType'] ?? '';
      _carType = userData['carType'] ?? '';
      _passengerCount = userData['passengerCount'] ?? '0';
      _price = userData['price']?.toString() ?? '0';
      _acceptedLocations = userData['acceptedLocations'] ?? '';

      notifyListeners();
    }
  }

  // Clear all user data
  void clearUserData() {
    _uid = null;
    _userName = null;
    _email = null;
    _phoneNumber = null;
    _carType = null;
    _plateNumber = null;
    _isDriver = false;
    _tripId = null;
    _subscriptionType = null;
    _driverId = null;
    _driverName = null;
    _location = null;
    _passengerCount = null;
    _price = null;
    _acceptedLocations = null;

    notifyListeners();
  }
}
