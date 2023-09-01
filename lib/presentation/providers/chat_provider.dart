import 'package:flutter/material.dart';
import 'package:yes_not_app/config/helpers/get_api.dart';
import 'package:yes_not_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  // ChangeNotifier es para notificar cuando hay cambios

  // para poder controlar el Scroll y al ponerlo en el controller puedo acceder a él desde los widgets
  final ScrollController chatScrollController = ScrollController();

  final GetApi getApi = GetApi();

  List<Message> messagesList = [
    Message(text: 'Hola caracola!', fromWho: FromWho.mine),
    Message(text: '¿qué haces?', fromWho: FromWho.mine)
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;
    final newMessage = Message(text: text, fromWho: FromWho.mine);
    messagesList.add(newMessage);

    if (text.endsWith('?')) {
      apiResponse();
    }

    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> apiResponse() async {
    final responseMessage = await getApi.getAnswer();
    messagesList.add(responseMessage);
    notifyListeners();
    moveScrollToBottom();
  }

  // para  controllar el scroll

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(microseconds: 100));

    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(microseconds: 300),
        curve: Curves.easeOut);
  }
}
