import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:whatsappclone/features/app/const/app_const.dart';
import 'package:whatsappclone/features/app/const/message_type_const.dart';
import 'package:whatsappclone/features/app/global/widgets/dialog_widget.dart';
import 'package:whatsappclone/features/app/global/widgets/show_image_picked_widget.dart';
import 'package:whatsappclone/features/app/global/widgets/show_video_picked_widget.dart';
import 'package:whatsappclone/features/app/theme/style.dart';
import 'package:whatsappclone/features/chats/presentation/widgets/message_widgets/message_type_widget.dart';
import 'package:whatsappclone/storage/storage_provider.dart';

class SingleChatPage extends StatefulWidget {
  const SingleChatPage({super.key});

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  final TextEditingController _textMessageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _focusNode = FocusNode();

  bool _isDisplaySendButton = false;

  @override
  void dispose() {
    _focusNode.dispose();
    _textMessageController.dispose();
    super.dispose();
  }

  bool _isShowAttachWindow = false;

  FlutterSoundRecorder? _soundRecorder;
  bool _isRecording = false;
  bool _isRecordInit = false;

  // @override
  // void initState() {
  //   _soundRecorder = FlutterSoundRecorder();
  //   _openAudioRecording();

  //   BlocProvider.of<MessageCubit>(context).getMessages(message: MessageEntity(
  //     senderUid: widget.message.senderUid,
  //     recipientUid: widget.message.recipientUid
  //   ));
  //   super.initState();
  // }

  Future<void> _scrollToBottom() async {
    if (_scrollController.hasClients) {
      await Future.delayed(const Duration(milliseconds: 100));
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  // Future<void> _openAudioRecording() async {
  //   final status = await Permission.microphone.request();
  //   if (status != PermissionStatus.granted) {
  //     throw RecordingPermissionException('Mic permission not allowed!');
  //   }
  //   await _soundRecorder!.openRecorder();
  //   _isRecordInit = true;
  // }

  File? _image;

  Future selectImage() async {
    setState(() => _image = null);
    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image has been selected");
        }
      });
    } catch (e) {
      toast("some error occured $e");
    }
  }

  File? _video;

  Future selectVideo() async {
    setState(() => _image = null);
    try {
      final pickedFile =
          await ImagePicker.platform.pickVideo(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _video = File(pickedFile.path);
        } else {
          print("no image has been selected");
        }
      });
    } catch (e) {
      toast("some error occured $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text("User"),
              const Text(
                'Online',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          actions: const [
            Icon(
              Icons.videocam_rounded,
              size: 25,
            ),
            SizedBox(
              width: 25,
            ),
            Icon(
              Icons.call,
              size: 22,
            ),
            SizedBox(
              width: 25,
            ),
            Icon(
              Icons.more_vert,
              size: 22,
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
        body: Column(children: [
          Expanded(
              child: Column(
            children: [
              _messageLayout(
                messageType: "Hello K xa khabar",
                message: "hello k xa halkhabar",
                alignment: Alignment.centerRight,
                createAt: Timestamp.now(),
                isSeen: false,
                isShowTick: true,
                messageBgColor: messageColor,
                onLongPress: () {},
              ),
              _messageLayout(
                messageType: "Hello K xa khabar",
                message: "hello k xa halkhabar",
                alignment: Alignment.centerLeft,
                createAt: Timestamp.now(),
                isSeen: false,
                isShowTick: true,
                messageBgColor: senderMessageColor,
                onLongPress: () {},
              ),
            ],
          )),
          Expanded(
            child: Container(
              child: _isShowAttachWindow == true
                  ? Positioned(
                      bottom: 65,
                      top: 320,
                      left: 15,
                      right: 15,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 0.20,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 20),
                        decoration: BoxDecoration(
                          color: bottomAttachContainerColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _attachWindowItem(
                                  icon: Icons.document_scanner,
                                  color: Colors.deepPurpleAccent,
                                  title: "Document",
                                ),
                                _attachWindowItem(
                                    icon: Icons.camera_alt,
                                    color: Colors.pinkAccent,
                                    title: "Camera",
                                    onTap: () {}),
                                _attachWindowItem(
                                    icon: Icons.image,
                                    color: Colors.purpleAccent,
                                    title: "Gallery"),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _attachWindowItem(
                                    icon: Icons.headphones,
                                    color: Colors.deepOrange,
                                    title: "Audio"),
                                _attachWindowItem(
                                    icon: Icons.location_on,
                                    color: Colors.green,
                                    title: "Location"),
                                _attachWindowItem(
                                    icon: Icons.account_circle,
                                    color: Colors.deepPurpleAccent,
                                    title: "Contact"),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _attachWindowItem(
                                  icon: Icons.bar_chart,
                                  color: tabColor,
                                  title: "Poll",
                                ),
                                _attachWindowItem(
                                    icon: Icons.gif_box_outlined,
                                    color: Colors.indigoAccent,
                                    title: "Gif",
                                    onTap: () {
                                      _sendGifMessage();
                                    }),
                                _attachWindowItem(
                                    icon: Icons.videocam_rounded,
                                    color: Colors.lightGreen,
                                    title: "Video",
                                    onTap: () {
                                      selectVideo().then((value) {
                                        if (_video != null) {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback(
                                            (timeStamp) {
                                              showVideoPickedBottomModalSheet(
                                                  context,
                                                  // recipientName: widget.message.recipientName,
                                                  file: _video, onTap: () {
                                                _sendVideoMessage();
                                                Navigator.pop(context);
                                              });
                                            },
                                          );
                                        }
                                      });

                                      setState(() {
                                        _isShowAttachWindow = false;
                                      });
                                    }),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 45),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: appBarColor,
                            borderRadius: BorderRadius.circular(25)),
                        height: 50,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          onTap: () {
                            setState(() {
                              _isShowAttachWindow = false;
                            });
                            // Open the keyboard manually
                            FocusScope.of(context).requestFocus(_focusNode);
                          },
                          focusNode: _focusNode,
                          controller: _textMessageController,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                _isDisplaySendButton = true;
                              });
                            } else {
                              setState(() {
                                _isDisplaySendButton = false;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15),
                            prefixIcon: const Icon(
                              Icons.emoji_emotions,
                              color: greyColor,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Wrap(
                                children: [
                                  Transform.rotate(
                                    angle: -0.5,
                                    child: GestureDetector(
                                      onTap: () {
                                        print("Hello World");
                                        setState(() {
                                          _isShowAttachWindow =
                                              !_isShowAttachWindow;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.attach_file,
                                        color: greyColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      selectImage().then((value) {
                                        if (_image != null) {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback(
                                            (timeStamp) {
                                              showImagePickedBottomModalSheet(
                                                  context,
                                                  file: _image, onTap: () {
                                                _sendImageMessage();
                                                Navigator.pop(context);
                                              });
                                            },
                                          );
                                        }
                                      });
                                    },
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: greyColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                            hintText: 'Message',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        _sendTextMessage();
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: tabColor),
                        child: Center(
                          child: Icon(
                            _isDisplaySendButton
                                ? Icons.send_outlined
                                : _isRecording
                                    ? Icons.close
                                    : Icons.mic,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // if ()
                  ],
                ),
              ],
            ),
          ),
        ]));
  }

  _messageLayout({
    Color? messageBgColor,
    Alignment? alignment,
    Timestamp? createAt,
    VoidCallback? onRight, // Change the type to VoidCallback?
    String? message,
    String? messageType,
    bool? isShowTick,
    bool? isSeen,
    VoidCallback? onLongPress,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: SwipeTo(
        onRightSwipe: (details) {
          onRight;
        },
        child: GestureDetector(
          onLongPress: onLongPress,
          child: Container(
            height: 60,
            alignment: alignment,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: EdgeInsets.only(
                        left: 5,
                        right: messageType == MessageTypeConst.textMessage
                            ? 88
                            : 5,
                        top: 5,
                        bottom: 5,
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.80,
                      ),
                      decoration: BoxDecoration(
                        color: messageBgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: MessageTypeWidget(
                        message: message,
                        type: messageType,
                      ),
                    ),
                    const SizedBox(height: 3),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _attachWindowItem(
      {IconData? icon, Color? color, String? title, VoidCallback? onTap}) {
    log("hello");
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40), color: color),
            child: Icon(icon),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "$title",
            style: const TextStyle(color: greyColor, fontSize: 13),
          ),
        ],
      ),
    );
  }

  _sendTextMessage() async {
    if (_isDisplaySendButton) {
      _sendMessage(
          message: _textMessageController.text,
          type: MessageTypeConst.textMessage);
    } else {
      final temporaryDir = await getTemporaryDirectory();
      final audioPath = '${temporaryDir.path}/flutter_sound.aac';
      if (!_isRecordInit) {
        return;
      }

      if (_isRecording == true) {
        await _soundRecorder!.stopRecorder();
        StorageProviderRemoteDataSource.uploadMessageFile(
          file: File(audioPath),
          onComplete: (value) {},
          // uid: widget.message.senderUid,
          // otherUid: widget.message.recipientUid,
          type: MessageTypeConst.audioMessage,
        ).then((audioUrl) {
          _sendMessage(message: audioUrl, type: MessageTypeConst.audioMessage);
        });
      } else {
        await _soundRecorder!.startRecorder(
          toFile: audioPath,
        );
      }

      setState(() {
        _isRecording = !_isRecording;
      });
    }
  }

  void _sendImageMessage() {
    StorageProviderRemoteDataSource.uploadMessageFile(
      file: _image!,
      onComplete: (value) {},
      // uid: widget.message.senderUid,
      // otherUid: widget.message.recipientUid,
      type: MessageTypeConst.photoMessage,
    ).then((photoImageUrl) {
      _sendMessage(message: photoImageUrl, type: MessageTypeConst.photoMessage);
    });
  }

  void _sendVideoMessage() {
    StorageProviderRemoteDataSource.uploadMessageFile(
      file: _video!,
      onComplete: (value) {},
      // uid: widget.message.senderUid,
      // otherUid: widget.message.recipientUid,
      type: MessageTypeConst.videoMessage,
    ).then((videoUrl) {
      _sendMessage(message: videoUrl, type: MessageTypeConst.videoMessage);
    });
  }

  Future _sendGifMessage() async {
    final gif = await pickGIF(context);
    if (gif != null) {
      String fixedUrl = "https://media.giphy.com/media/${gif.id}/giphy.gif";
      _sendMessage(message: fixedUrl, type: MessageTypeConst.gifMessage);
    }
  }

  void _sendMessage(
      {required String message,
      required String type,
      String? repliedMessage,
      String? repliedTo,
      String? repliedMessageType}) {
    _scrollToBottom();

    // ChatUtils.sendMessage(context,
    //   messageEntity: widget.message,
    //   message: message,
    //   type: type,
    //   repliedTo: repliedTo,
    //   repliedMessageType: repliedMessageType,
    //   repliedMessage: repliedMessage,
    // ).then((value) {
    //   setState(() {
    //     _textMessageController.clear();
    //   });
    //   _scrollToBottom();

    // });
  }
}
