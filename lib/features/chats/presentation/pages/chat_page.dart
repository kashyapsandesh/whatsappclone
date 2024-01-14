import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsappclone/features/app/const/page_const.dart';
import 'package:whatsappclone/features/app/global/widgets/profile_widget.dart';
import 'package:whatsappclone/features/app/theme/style.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            // final chat = myChat[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PageConst.singleChatPage);
                // Navigator.pushNamed(context, PageConst.singleChatPage,
                //     arguments: MessageEntity(
                //       senderUid: chat.senderUid,
                //       recipientUid:chat.recipientUid,
                //       senderName: chat.senderName,
                //       recipientName: chat.recipientName,
                //       senderProfile: chat.senderProfile,
                //       recipientProfile: chat.recipientProfile,
                // ));
              },
              child: ListTile(
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: profileWidget(),
                  ),
                ),
                title: Text("Anish"),
                subtitle: Text(
                  "K xa khabar",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(
                  DateFormat.jm().format(DateTime.now()),
                  style: const TextStyle(color: greyColor, fontSize: 13),
                ),
              ),
            );
          }),
    );
  }
}
