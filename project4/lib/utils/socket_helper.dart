import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/main.dart';
import 'package:project4/models/notification/notification_page_item.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/utils/storages.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class SocketHelper {
  static SocketHelper? _instance;

  SocketHelper._();

  static SocketHelper get instance {
    _instance ??= SocketHelper._();
    return _instance!;
  }

  late StompClient _stompClient;

  void _onConnect(StompFrame frame) {
    if (!Storages.instance.isLogin()) {
      return;
    }
    Helper.debug('connect to ${Storages.instance.getUser()!.id}');
    _stompClient.subscribe(
      destination: '/topic/${Storages.instance.getUser()!.id}/notification',
      callback: (frame) {
        NotificationPageItem notificationPageItem = NotificationPageItem.fromJson(
            jsonDecode(frame.body!) as Map<String, dynamic>);
        Helper.debug('receive new notification $notificationPageItem');
        GetIt.instance<ScreenProvider>().updateNotificationPageItem(notificationPageItem);
      },
    );
  }

  void activate() {
    _stompClient = StompClient(
      config: StompConfig.sockJS(
        url: '${Environment.apiUrl}/socket',
        onConnect: _onConnect,
        beforeConnect: () async {
          Helper.debug('connecting...');
        },
        onWebSocketError: (dynamic error) => Helper.debug(error),
        onStompError: (d) => Helper.debug('error stomp'),
      ),
    );
    _stompClient.activate();
  }

  void deactivate() {
    _stompClient.deactivate();
  }
}
