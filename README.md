# Project4_Comic_Reading_App_V0
--
cd project4

flutter run
flutter emulators --launch flutter_emulator



-----------------------------------------------------------------------git command

git add .
git commit - m "[content]"
git push




-------------------------------------------------------------------- run web with port
chay dung cong de cho phep corsmapping test api
flutter run -d chrome --web-port 25032



@Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins("http://localhost:25032")
                .allowedMethods("GET", "POST", "PUT", "DELETE")
                .allowCredentials(true);
    }
    -------------------------
    import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create storage
final storage = new FlutterSecureStorage();

// Write value 
await storage.write(key: 'jwt', value: token);
save token in flutter





-------------------------------------------------------------------- notification
runZoned(() async {
  var server = await HttpServer.bind('127.0.0.1', 4040);
  server.listen((HttpRequest req) async {
    if (req.uri.path == '/ws') {
      var socket = await WebSocketTransformer.upgrade(req);
      socket.listen(handleMsg);
    }
  });
}, onError: (e) => print("An error occurred."));

ServerSocket.bind('127.0.0.1', 4041)
  .then((serverSocket) {
    serverSocket.listen((socket) {
      socket.transform(utf8.decoder).listen(print);
    });
  });
  Socket.connect('127.0.0.1', 4041).then((socket) {
  socket.write('Hello, World!');
});
///////





sever
import 'dart:io';

void main() async {
  // Tạo một server socket và lắng nghe trên cổng 12345
  var serverSocket = await ServerSocket.bind('127.0.0.1', 12345);

  print('Server listening on port 12345');

  // Lắng nghe các kết nối đến server
  await for (var socket in serverSocket) {
    print('Client connected: ${socket.remoteAddress}:${socket.remotePort}');

    // Xử lý thông báo từ client
    socket.listen(
      (List<int> data) {
        var message = String.fromCharCodes(data);
        print('Received message: $message');

        // Xử lý thông báo ở đây, ví dụ: gửi lại thông báo đến client
        socket.write('Server received: $message');
      },
      onDone: () {
        print('Client disconnected: ${socket.remoteAddress}:${socket.remotePort}');
      },
    );
  }
}
client
import 'dart:io';

void main() async {
  var socket = await Socket.connect('127.0.0.1', 12345);

  // Gửi thông báo đến server
  socket.write('Hello, server!');

  // Lắng nghe phản hồi từ server
  socket.listen(
    (List<int> data) {
      var message = String.fromCharCodes(data);
      print('Received from server: $message');
    },
    onDone: () {
      print('Connection closed');
      socket.destroy();
    },
  );
}



