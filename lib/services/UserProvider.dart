import 'package:flutter/material.dart';

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
  String? _driverId;
  String? _driverName;
  String? _location;

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
  String? get driverId => _driverId;
  String? get driverName => _driverName;
  String? get location => _location;

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
    notifyListeners();
  }
}
