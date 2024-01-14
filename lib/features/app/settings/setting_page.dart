import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:whatsappclone/features/app/const/page_const.dart';
import 'package:whatsappclone/features/app/global/widgets/dialog_widget.dart';
import 'package:whatsappclone/features/app/global/widgets/profile_widget.dart';
import 'package:whatsappclone/features/app/theme/style.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PageConst.editProfilePage,
                  );
                },
                child: SizedBox(
                  width: 65,
                  height: 65,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32.5),
                    child: profileWidget(
                        imageUrl:
                            "https://images.pexels.com/photos/18489099/pexels-photo-18489099/free-photo-of-man-in-white-shirt-with-book-in-hands.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "{singleUser.username}",
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      "{singleUser.status}",
                      style: const TextStyle(color: greyColor),
                    )
                  ],
                ),
              ),
              const Icon(
                Icons.qr_code_sharp,
                color: tabColor,
              )
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            width: double.infinity,
            height: 0.5,
            color: greyColor.withOpacity(.4),
          ),
          const SizedBox(
            height: 10,
          ),
          _settingsItemWidget(
              title: "Account",
              description: "Security applications, change number",
              icon: Icons.key,
              onTap: () {}),
          _settingsItemWidget(
              title: "Privacy",
              description: "Block contacts, disappearing messages",
              icon: Icons.lock,
              onTap: () {}),
          _settingsItemWidget(
              title: "Chats",
              description: "Theme, wallpapers, chat history",
              icon: Icons.message,
              onTap: () {}),
          _settingsItemWidget(
              title: "Logout",
              description: "Logout from WhatsApp Clone",
              icon: Icons.exit_to_app,
              onTap: () {
                displayAlertDialog(context, onTap: () {
                  // BlocProvider.of<AuthCubit>(context).loggedOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, PageConst.welcomePage, (route) => false);
                },
                    confirmTitle: "Logout",
                    content: "Are you sure you want to logout?");
              }),
        ],
      ),
    );
  }
  // );
}

_settingsItemWidget(
    {String? title, String? description, IconData? icon, VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        SizedBox(
            width: 80,
            height: 80,
            child: Icon(
              icon,
              color: greyColor,
              size: 25,
            )),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$title",
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                "$description",
                style: const TextStyle(color: greyColor),
              )
            ],
          ),
        )
      ],
    ),
  );
}
