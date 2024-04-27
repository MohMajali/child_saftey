import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ecommerce/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  int conversationId, clientId;
  ChatScreen({super.key, required this.conversationId, required this.clientId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List messages = [];
  late IO.Socket socket;
  TextEditingController controller = TextEditingController();
  Future getConversation() async {
    try {
      var response = await http.get(
        Uri.parse('$URL/chats/${widget.conversationId}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      var conversationResponse;

      if (response.statusCode == 200) {
        conversationResponse = json.decode(response.body);
        if (!conversationResponse['error']) {
          // messages = conversationResponse['messages'];
          return conversationResponse['messages'];
        }
      }
      return conversationResponse;
    } catch (err) {
      log('getConversation FUNCTION ===> $err');
      return err;
    }
  }

  Future sendMessage(int client, String message) async {
    try {
      final body = jsonEncode(
          {'reciver_id': 1, 'sender_id': client, 'message': message});
      var response = await http.post(
          Uri.parse('$URL/chats/${widget.conversationId}'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: body);

      var chatResponse;

      if (response.statusCode == 200) {
        chatResponse = json.decode(response.body);
        if (!chatResponse['error']) {
          return chatResponse['message'];
        }
      }
      return chatResponse;
    } catch (err) {
      log('sendMessage FUNCTION ===> $err');
      return err;
    }
  }

  void initSocketClient() {
    socket = IO.io("http://192.168.100.189:8080", <String, dynamic>{
      "transports": ["websocket"],
      'autoConnect': true,
    });
    socket.connect();
    socket.onConnect((_) {
      log('connect');
    });
    socket.onDisconnect((_) => log('disconnect'));
    socket.on('message', (data) async {
      await getConversation().then((value) {
        setState(() {
          messages = value;
          controller.text = '';
        });
      });
    });
    socket.onConnectError((data) => {log("Conntect Error $data")});
    socket.onError((err) {
      log("ERROR ===> $err");
    });
  }

  @override
  void initState() {
    initSocketClient();
    getConversation().then((value) {
      setState(() {
        messages = value;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    socket.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.indigo,
            body: SafeArea(
                child: Stack(children: [
              Column(children: [
                _topChat(),
                _bodyChat(),
                const SizedBox(height: 120)
              ]),
              _formChat()
            ]))));
  }

  _topChat() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(Icons.arrow_back_ios,
                    size: 25, color: Colors.white)),
            const Text('MidWife',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))
          ]),
          Row(children: [
            Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black12,
                ),
                child: const Icon(Icons.call, size: 25, color: Colors.white)),
            const SizedBox(width: 20),
            Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black12),
                child:
                    const Icon(Icons.videocam, size: 25, color: Colors.white))
          ])
        ]));
  }

  Widget _bodyChat() {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45), topRight: Radius.circular(45)),
              color: Colors.white,
            ),
            child: ListView.builder(
                itemCount: messages.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, i) {
                  if (messages[i]['sender']['id'] == widget.clientId) {
                    return _itemChat(
                      chat: 0,
                      message: messages[i]['message'],
                      time: '18.00',
                    );
                  }
                  return _itemChat(
                    avatar: 'assets/image/5.jpg',
                    chat: 1,
                    message: messages[i]['message'],
                    time: '18.00',
                  );
                })));
  }

  _itemChat({int? chat, String? avatar, message, time}) {
    return Row(
        mainAxisAlignment:
            chat == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          avatar != null
              ? Avatar(image: avatar, size: 50)
              : Text('$time', style: TextStyle(color: Colors.grey.shade400)),
          Flexible(
              child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: chat == 0
                          ? Colors.indigo.shade100
                          : Colors.indigo.shade50,
                      borderRadius: chat == 0
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30))
                          : const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                  child: Text('$message'))),
          chat == 1
              ? Text('$time', style: TextStyle(color: Colors.grey.shade400))
              : const SizedBox()
        ]);
  }

  Widget _formChat() {
    return Positioned(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: 120,
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                color: Colors.white,
                child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: 'اكنب رسالة...',
                        suffixIcon: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.indigo),
                            padding: const EdgeInsets.all(14),
                            child: InkWell(
                              onTap: () async {
                                await sendMessage(
                                    widget.clientId, controller.text);
                              },
                              child: const Icon(Icons.send_rounded,
                                  color: Colors.white, size: 28),
                            )),
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        labelStyle: const TextStyle(fontSize: 12),
                        contentPadding: const EdgeInsets.all(20),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey[50]!),
                            borderRadius: BorderRadius.circular(25)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey[50]!),
                            borderRadius: BorderRadius.circular(25)))))));
  }
}

class Avatar extends StatelessWidget {
  final double size;
  final image;
  final EdgeInsets margin;
  const Avatar(
      {this.image, this.size = 50, this.margin = const EdgeInsets.all(0)});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: margin,
        child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(image)))));
  }
}
