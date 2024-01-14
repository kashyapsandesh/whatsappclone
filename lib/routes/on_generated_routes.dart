import 'package:flutter/material.dart';
import 'package:whatsappclone/features/app/const/page_const.dart';
import 'package:whatsappclone/features/app/home/contact_page.dart';
import 'package:whatsappclone/features/app/settings/setting_page.dart';
import 'package:whatsappclone/features/call/presentation/pages/call_contacts_page.dart';
import 'package:whatsappclone/features/chats/presentation/pages/single_chat_page.dart';
import 'package:whatsappclone/features/status/presentation/pages/my_status.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;
    final name = settings.name;

    switch (name) {
      case PageConst.contactUsersPage:
        {
          return materialPageBuilder(ContactsPage());
          // uid: args,
        }
      case PageConst.settingsPage:
        {
          if (args is String) {
            return materialPageBuilder(SettingsPage());
            // uid: args,
          } else {
            return materialPageBuilder(const ErrorPage());
          }
        }
      // case PageConst.editProfilePage: {
      //   if(args is UserEntity) {
      //     return materialPageBuilder( EditProfilePage(currentUser: args));
      //   } else {
      //     return materialPageBuilder( const ErrorPage());
      //   }
      // }
      case PageConst.callContactsPage:
        {
          return materialPageBuilder(const CallContactsPage());
        }
      case PageConst.myStatusPage:
        {
          return materialPageBuilder(const MyStatusPage());
        }
      case PageConst.singleChatPage:
        {
          return materialPageBuilder(SingleChatPage());
        }
    }
  }
}

dynamic materialPageBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: const Center(
        child: Text("Error"),
      ),
    );
  }
}
