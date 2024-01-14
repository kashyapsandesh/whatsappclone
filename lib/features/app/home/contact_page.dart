
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:whatsappclone/features/app/const/page_const.dart';
import 'package:whatsappclone/features/app/theme/style.dart';

import '../global/widgets/profile_widget.dart';

class ContactsPage extends StatefulWidget {
  // final String uid;

  const ContactsPage({
    super.key,
  });
  // required this.uid

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  // @override
  // void initState() {
  //   BlocProvider.of<UserCubit>(context).getAllUsers();
  //   BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Select Contacts"),
        ),
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              // final contact = contacts[index];
              return ListTile(
                onTap: () {
                  // Navigator.pushNamed(context, PageConst.singleChatPage,
                  //     arguments: MessageEntity(
                  //       senderUid: currentUser.uid,
                  //       recipientUid: contact.uid,
                  //       senderName: currentUser.username,
                  //       recipientName: contact.username,
                  //       senderProfile: currentUser.profileUrl,
                  //       recipientProfile: contact.profileUrl,
                  //     ));
                },
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: profileWidget(
                          imageUrl:
                              "https://images.pexels.com/photos/18489099/pexels-photo-18489099/free-photo-of-man-in-white-shirt-with-book-in-hands.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")),
                ),
                title: Text("{contact.username}"),
                subtitle: Text("{contact.status}"),
              );
            }));
  }
}

// FIXME: Logic to fetch contacts of the phone

// BlocBuilder<GetDeviceNumberCubit, GetDeviceNumberState>(
// builder: (context, state) {
// if(state is GetDeviceNumberLoaded) {
// final contacts = state.contacts;
// return ListView.builder(itemCount: contacts.length, itemBuilder: (context, index) {
// final contact = contacts[index];
// return ListTile(
// leading: SizedBox(
// width: 50,
// height: 50,
// child: ClipRRect(
// borderRadius: BorderRadius.circular(25),
// child: Image.memory(
// contact.photo ?? Uint8List(0),
// errorBuilder: (context, error, stackTrace) {
// return Image.asset('assets/profile_default.png'); // Placeholder image
// },
// ),
//
// //profileWidget()
// ),
// ),
// title: Text("${contact.name!.first} ${contact.name!.last}"),
// subtitle: const Text("Hey there! I'm using WhatsApp"),
// );
// });
//
// }
// return const Center(
// child: CircularProgressIndicator(
// color: tabColor,
// ),
// );
// },
// ),