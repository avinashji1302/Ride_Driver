import 'package:app/config/networks/api_endpoints.dart';
import 'package:app/main.dart';
import 'package:app/screens/audio/view/audio_call.dart';
import 'package:app/screens/audio/view/calling_screen.dart';
import 'package:app/screens/chat/viewmodel/chat_State.dart';
import 'package:app/screens/chat/viewmodel/chat_provider.dart';
import 'package:app/screens/home/model/Socket/ride_accept_socket_model.dart';
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

  void connect(String token, String driverId) {
    debugPrint("driver id : ${driverId}");
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
          .enableReconnection() // ✅ ADD THIS
          .setReconnectionAttempts(999999) // keep trying
          .setReconnectionDelay(1000) // 1 sec
          .setReconnectionDelayMax(5000)
          .build(),
    );

    _registerDriverListeners(driverId);
    socket!.connect();
  }

  void _registerDriverListeners(String driverId) {
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
      debugPrint("driveid : $driverId");
      socket!.emit('driver:online', driverId);

      //  socket.emit("driver:online", driverId);
    });

    socket!.on("ride:joinRoom:response", (data) {
      debugPrint("🔥 DRIVER JOIN ROOM RESPONSE: $data");
    });

    // Server acknowledges driver is online
    socket!.on("driver:online:ack", (data) {
      debugPrint("✅ Driver is now online: ${data['ok']}");
    });

    // New ride offered to driver (done)
    socket!.on("ride:new", (data) {
      debugPrint("🆕 NEW RIDE OFFERED: $data");
      // Parse and show to driver
      // _homeProvider.incomingRide(data);

      debugPrint("🆕 NEW RIDE OFFERED: $data");

      try {
        final ride = RideAcceptedSocketModel.fromJson(data);

        _homeProvider.incomingRide(ride);

        final rideId = ride.id;

        debugPrint("data revived : $rideId jpoined............");
        debugPrint("🚗 JOINING ROOM WITH ID: $rideId"); // ← add this
        // joinRoom(rideId);
        // recievedMessage();
      } catch (e) {
        debugPrint("❌ Ride parse error: $e");
      }
    });

    // Response after driver accepts ride (done)
    socket!.on("ride:accept:response", (data) {
      debugPrint("✅ RIDE ACCEPT RESPONSE: $data");

      debugPrint("🚗 DRIVER ACCEPTED RIDE");
      debugPrint("📦 data without: ${data}");
      debugPrint("📦 Ride Data: ${data['results']}");
      debugPrint("📦 otp: ${data['otp']}");
      debugPrint("📦 driver: ${data['driver']}");
      debugPrint("📦 ride: ${data['ride']}");
      debugPrint("📦 vehicle : ${data['vehicle']}");

      final rideDetails = RideAcceptedSocketModel.fromJson(data);

      debugPrint("📦 ride details : $rideDetails");

      // _homeProvider.onRideAccepted(rideDetails);

      final rideId = rideDetails.id;

      debugPrint("✅ DRIVER JOINING ROOM AFTER ACCEPT: $rideId");
      joinRoom(rideId);
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
      _homeProvider.setFlow(HomeFlow.idle);
    });

    // Ride completed (wallet payment)
    socket!.on("driver:rideCompleted", (data) {
      debugPrint("🎉 RIDE COMPLETED: $data");
    });

    // Response after driver cancels
    socket!.on("ride:cancel:response", (data) {
      debugPrint("🚫 CANCEL RESPONSE: $data");
    });

    // Chat message sent response
    socket!.on("ride:sendMessage:response", (data) {
      debugPrint("📤 SEND MESSAGE RESPONSE: $data");
      // recievedMessage();
    });

    _registerChatListeners();

    // socket!.onDisconnect((_) {
    //   debugPrint("🔴 DRIVER SOCKET DISCONNECTED");
    // });

    /// 🔥 ADD THESE
    // listenIncomingCall();
    // // listenCallAccepted();
    // listenCallEnded();
    // listenCallAcceptedAsReceiver();

    listenIncomingCall();
    listenCallAccepted();
    listenCallRejected();
    listenCallEnded();
  }

  // ==================== EMIT METHODS ====================

  void _registerChatListeners() {
    socket!.off("ride:receiveMessage"); // ⭐ IMPORTANT
    socket!.on("ride:receiveMessage", (data) {
      debugPrint("📩 DRIVER MESSAGE: $data");
      debugPrint("📩 DRIVER GOT ride:receiveMessage: $data"); // ← add this

      if (data == null) {
        debugPrint("❌ DATA IS NULL");
        return;
      }

      final senderType = data['senderType'];
      final msg = data['text'];
      final rideId = data['ride'].toString();

      if (senderType == "driver") return; // skip own

      DriverChatProvider.instance.addMessage(data);

      if (!ChatState.isChatOpen) {
        DriverChatProvider.instance.showPopup(msg, rideId);
      }
    });
  }

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
    socket?.emit('ride:accept', {'rideId': rideId, 'driverId': driverId});
  }

  /// Mark arrived at pickup
  void markArrived(String rideId, String driverId) {
    debugPrint("📍 Marking arrived at pickup");
    socket?.emit('ride:arrived', {'rideId': rideId, 'driverId': driverId});
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

  void disconnect() {
    debugPrint("🔌 Driver socket disconnected manually");
    socket?.disconnect();
    socket?.dispose();
    socket = null;
  }

  // void joinRoom(String rideId) {
  //   debugPrint("joined room....... $rideId");
  //   socket!.emit("ride:joinRoom", rideId);
  // }
  void joinRoom(String rideId) {
    debugPrint("🚗 joining room with raw id: $rideId");
    socket!.emit("ride:joinRoom", rideId); // ✅ FIXED
  }

  void sendMessage(String rideId, String message) {
    debugPrint("send message room....... $rideId ");
    socket!.emit("ride:sendMessage", {'rideId': rideId, 'text': message});
  }

  // ================= AUDIO CALL =================

  // ================= AUDIO CALL (COMMON FOR USER + DRIVER) =================

  bool _iAmTheCaller = false;

  void startAudioCall(String rideId) {
    _iAmTheCaller = true;
    debugPrint("📞 DRIVER starting call");
    socket!.emit("ride:startAudioCall", {"rideId": rideId});

    Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (_) => CallingScreen(
          callerLabel: "Calling User...",
          onCancel: () {
            _iAmTheCaller = false;
            Navigator.pop(navigatorKey.currentContext!);
          },
        ),
      ),
    );
  }

  void listenIncomingCall() {
    socket!.off("ride:incomingAudioCall");
    socket!.on("ride:incomingAudioCall", (data) {
      debugPrint("📞 DRIVER got incomingAudioCall — iAmCaller: $_iAmTheCaller");

      // ✅ I started this call — skip dialog, I see CallingScreen
      if (_iAmTheCaller) return;

      // ✅ User called me — show dialog
      final rideId = data['rideId'] as String;
      final callId = data['callId'] as String;

      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            "📞 Incoming Call",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "User is calling you",
            style: TextStyle(color: Colors.grey),
          ),
          actions: [
            TextButton(
              onPressed: () {
                acceptAudioCall(rideId, callId);
                Navigator.pop(navigatorKey.currentContext!);
              },
              child: const Text(
                "Accept",
                style: TextStyle(color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () {
                rejectAudioCall(rideId, callId);
                Navigator.pop(navigatorKey.currentContext!);
              },
              child: const Text("Reject", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    });
  }

  void listenCallAccepted() {
    socket!.off("ride:audioCallAccepted");
    socket!.on("ride:audioCallAccepted", (data) {
      debugPrint("✅ DRIVER audioCallAccepted — iAmCaller: $_iAmTheCaller");

      final rideId = data['rideId'] as String;
      final channel = data['channel'] as String;

      // ✅ Caller uses callerToken (uid=0), receiver uses receiverToken (uid=1)
      final token = _iAmTheCaller
          ? data['callerToken'] as String
          : data['receiverToken'] as String;

      if (_iAmTheCaller) {
        Navigator.pop(navigatorKey.currentContext!); // pop CallingScreen
      }

      final wasCaller = _iAmTheCaller;
      _iAmTheCaller = false; // reset before navigation

      Navigator.push(
        navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (_) => AudioCallScreen(
            channelName: channel,
            token: token,
            rideId: rideId,
            isCaller: wasCaller,
            callerLabel: wasCaller ? "Driver" : "User",
            receiverLabel: wasCaller ? "User" : "Driver",
          ),
        ),
      );
    });
  }

  void acceptAudioCall(String rideId, String callId) {
    socket!.emit("ride:acceptAudioCall", {"rideId": rideId, "callId": callId});
  }

  void rejectAudioCall(String rideId, String callId) {
    _iAmTheCaller = false;
    socket!.emit("ride:rejectAudioCall", {"rideId": rideId, "callId": callId});
  }

  void endAudioCall(String rideId, String callId) {
    _iAmTheCaller = false;
    socket!.emit("ride:endAudioCall", {"rideId": rideId, "callId": callId});
  }

  void listenCallRejected() {
    socket!.off("ride:audioCallRejected");
    socket!.on("ride:audioCallRejected", (data) {
      debugPrint("❌ DRIVER call rejected");
      _iAmTheCaller = false;
      if (navigatorKey.currentContext != null) {
        Navigator.pop(navigatorKey.currentContext!);
      }
    });
  }

  void listenCallEnded() {
    socket!.off("ride:audioCallEnded");
    socket!.on("ride:audioCallEnded", (data) {
      debugPrint("🔚 DRIVER call ended");
      _iAmTheCaller = false;
      if (navigatorKey.currentContext != null) {
        Navigator.pop(navigatorKey.currentContext!);
      }
    });
  }

  //   void startAudioCall(String rideId) {
  //     debugPrint("📞 Starting call: $rideId");

  //     socket!.emit("ride:startAudioCall", {"rideId": rideId});
  //   }

  // void listenIncomingCall() {
  //   socket!.off("ride:incomingAudioCall");

  //   socket!.on("ride:incomingAudioCall", (data) {
  //     debugPrint("📞 Driver got incomingAudioCall: $data");

  //     if (data['callerType'] == 'driver') return; // ✅ correct — skip own broadcast
  //   });

  // }

  // // ✅ Driver (caller) listens here and uses callerToken
  // void listenCallAcceptedAsReceiver() {
  //   socket!.off("ride:audioCallAccepted");

  //   socket!.on("ride:audioCallAccepted", (data) {
  //     debugPrint("✅ Driver got audioCallAccepted: $data");

  //     final rideId = data['rideId'] as String;
  //     final callerToken = data['callerToken'] as String; // ✅ driver uses callerToken
  //     final channel = data['channel'] as String;

  //     Navigator.push(
  //       navigatorKey.currentContext!,
  //       MaterialPageRoute(
  //         builder: (_) => AudioCallScreen(
  //           channelName: channel,
  //           token: callerToken, // ✅ callerToken for driver
  //           rideId: rideId,
  //           isCaller: true, // ✅ driver is caller
  //         ),
  //       ),
  //     );
  //   });
  // }

  //   /// REJECT
  //   void rejectAudioCall(String rideId, String callId) {
  //      debugPrint("✅ Call rejected: $rideId callId $callId");
  //     socket!.emit("ride:rejectAudioCall", {"rideId": rideId, "callId": callId});
  //   }

  //   /// END CALL
  //   void endAudioCall(String rideId, String callId) {
  //      debugPrint("✅ end audio call $rideId callId $callId");
  //     socket!.emit("ride:endAudioCall", {"rideId": rideId, "callId": callId});
  //   }

  //   /// CALL ENDED
  //   void listenCallEnded() {
  //      debugPrint("❌ Call Ended: ");
  //     socket!.on("ride:audioCallEnded", (data) {
  //       debugPrint("❌ Call Ended: $data");

  //       Navigator.pop(navigatorKey.currentContext!);
  //     });
  //   }
}
