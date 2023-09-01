import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_not_app/domain/entities/message.dart';
import 'package:yes_not_app/presentation/providers/chat_provider.dart';
import 'package:yes_not_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_not_app/presentation/widgets/chat/other_message_bubble.dart';
import 'package:yes_not_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2N9SI7SMmNfqnTkzF_PdIHeLxdZy72JwGpLdR1rYZVv9qTqmNHNwXVR7Tjl7x2ahIlAo&usqp=CAU'),
          ),
        ),
        title: const Text('BFF 🐶'),
        centerTitle: false,
      ),
      body: const _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView();

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    controller: chatProvider.chatScrollController,
                    itemCount: chatProvider.messagesList.length,
                    itemBuilder: (context, index) {
                      final message = chatProvider.messagesList[index];

                      return (message.fromWho == FromWho.mine)
                          ? MyMessageBubble(message: message)
                          : OtherMessageBubble(message: message);
                    })),
            MessageFieldBox(
              onValue: (value) {
                chatProvider.sendMessage(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
