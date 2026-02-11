
import 'package:app/config/networks/api_endpoints.dart';
import 'package:app/screens/home/viewModel/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  IO.Socket? socket;

    late HomeProvider _homeProvider;

  /// Inject provider ONCE
  void attachHomeProvider(HomeProvider provider) {
    _homeProvider = provider;
    debugPrint("🧩 HomeProvider attached to SocketService");
  }


  void connect(String token) {
    if (socket != null && socket!.connected) {
      debugPrint("⚠️ Socket already connected");
      return;
    }

    debugPrint("🔑 Connecting driver socket...");

    socket = IO.io(
      ApiEndpoints.baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': token})
          .disableAutoConnect()
          .build(),
    );

    _registerDriverListeners();
    socket!.connect();
  }

  void _registerDriverListeners() {
    // Log all events
    socket!.onAny((event, data) {
      debugPrint("━━━━━━━━━━━━━━━━━━━━");
      debugPrint("📡 DRIVER EVENT: $event");
      debugPrint("📦 DATA: $data");
      debugPrint("━━━━━━━━━━━━━━━━━━━━");
    });

    socket!.onConnect((_) {
      debugPrint("🟢 DRIVER SOCKET CONNECTED");
      // Mark driver as online
      socket!.emit('driver:online');
    });

    // Server acknowledges driver is online
    socket!.on("driver:online:ack", (data) {
      debugPrint("✅ Driver is now online: $data");
     
    });

    // New ride offered to driver
    socket!.on("ride:new", (data) {
      debugPrint("🆕 NEW RIDE OFFERED: $data");
      // Parse and show to driver
      _homeProvider.newRideComing();
     
    });

    // Response after driver accepts ride
    socket!.on("ride:accept:response", (data) {
      debugPrint("✅ RIDE ACCEPT RESPONSE: $data");
      
    });

    // Response after driver marks arrived
    socket!.on("ride:arrived:response", (data) {
      debugPrint("📍 ARRIVED RESPONSE: $data");
      
    });

    // Response after driver starts ride
    socket!.on("ride:start:response", (data) {
      debugPrint("🚗 RIDE START RESPONSE: $data");
     
    });

    // Response after driver reaches destination
    socket!.on("ride:reachedDestination:response", (data) {
      debugPrint("🏁 REACHED DESTINATION RESPONSE: $data");
     
    });

    // Response after driver confirms payment received
    socket!.on("driver:receivedPayment:response", (data) {
      debugPrint("💰 PAYMENT RECEIVED RESPONSE: $data");
     
    });

    // User cancelled the ride
    socket!.on("driver:rideCancelled", (data) {
      debugPrint("❌ USER CANCELLED RIDE: $data");
     
    });

    // Ride completed (wallet payment)
    socket!.on("driver:rideCompleted", (data) {
      debugPrint("🎉 RIDE COMPLETED: $data");
     
    });

    // Response after driver cancels
    socket!.on("ride:cancel:response", (data) {
      debugPrint("🚫 CANCEL RESPONSE: $data");
      
    });

    // Chat room join response
    socket!.on("ride:joinRoom:response", (data) {
      debugPrint("💬 JOIN ROOM RESPONSE: $data");
      
    });

    // Chat message sent response
    socket!.on("ride:sendMessage:response", (data) {
      debugPrint("📤 SEND MESSAGE RESPONSE: $data");
     
    });

    // Receive chat message
    socket!.on("ride:receiveMessage", (data) {
      debugPrint("📩 NEW MESSAGE: $data");
    
    });

    socket!.onDisconnect((_) {
      debugPrint("🔴 DRIVER SOCKET DISCONNECTED");
    });
  }

  // ==================== EMIT METHODS ====================

  /// Mark driver as online
  void goOnline(String driverId) {
    debugPrint("🟢 Marking driver online...");
    socket?.emit('driver:online', driverId);
  }

  /// Send live location while on ride
  void sendLocation(String driverId, double lat, double lng) {
    socket?.emit('driver:location', {
      'driverId': driverId,
      'lat': lat,
      'lng': lng,
    });
  }

  /// Accept a ride
  void acceptRide(String rideId, String driverId) {
    debugPrint("✅ Accepting ride: $rideId");
    socket?.emit('ride:accept', {
      'rideId': rideId,
      'driverId': driverId,
    });
  }

  /// Mark arrived at pickup
  void markArrived(String rideId, String driverId) {
    debugPrint("📍 Marking arrived at pickup");
    socket?.emit('ride:arrived', {
      'rideId': rideId,
      'driverId': driverId,
    });
  }

  /// Start the ride with OTP
  void startRide(String rideId, String driverId, String otp) {
    debugPrint("🚗 Starting ride with OTP: $otp");
    socket?.emit('ride:start', {
      'rideId': rideId,
      'driverId': driverId,
      'otp': otp,
    });
  }

  /// Mark reached destination
  void reachedDestination(String rideId, String driverId) {
    debugPrint("🏁 Reached destination");
    socket?.emit('ride:reachedDestination', {
      'rideId': rideId,
      'driverId': driverId,
    });
  }

  /// Confirm cash received
  void confirmPaymentReceived(String rideId, String driverId) {
    debugPrint("💰 Confirming payment received");
    socket?.emit('driver:receivedPayment', {
      'rideId': rideId,
      'driverId': driverId,
    });
  }

  /// Cancel ride
  void cancelRide(String rideId, String driverId, {String? reason}) {
    debugPrint("🚫 Cancelling ride: $reason");
    socket?.emit('ride:cancel:driver', {
      'rideId': rideId,
      'driverId': driverId,
      
    });
  }

  /// Join chat room
  void joinChatRoom(String rideId) {
    debugPrint("💬 Joining chat room: $rideId");
    socket?.emit('ride:joinRoom', rideId);
  }

  /// Send chat message
  void sendChatMessage(String rideId, String text) {
    debugPrint("📤 Sending message: $text");
    socket?.emit('ride:sendMessage', {
      'rideId': rideId,
      'text': text,
    });
  }

  void disconnect() {
    debugPrint("🔌 Driver socket disconnected manually");
    socket?.disconnect();
    socket?.dispose();
    socket = null;
  }
}