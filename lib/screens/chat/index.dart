import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rhb_mobile_flutter/controllers/chat/chat.dart';
import 'package:rhb_mobile_flutter/models/chat/chat.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:rhb_mobile_flutter/widgets/loading.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().indigoAppBar(
        onpress: () {
          Get.back();
        },
        title: 'Chat',
        context: context,
      ),
      body: GetBuilder<ChatController>(
          id: "general",
          builder: (_) {
            if (_.chatRef == null) {
              return LoadingContent();
            } else {
              return StreamBuilder(
                stream: controller.chatRef
                    .orderBy('sentAt', descending: false)
                    .limitToLast(controller.limit)
                    .snapshots(),
                builder: (context, snapshoot) {
                  if (snapshoot.hasData) {
                    if (snapshoot == null) {
                      return LoadingContent();
                    } else {
                      return GetBuilder<ChatController>(
                        id: 'chat-list',
                        builder: (_) {
                          _.listMessage(snapshoot.data.docs);
                          return NotificationListener<ScrollNotification>(
                            onNotification: (scrollInfo) {
                              if (scrollInfo.metrics.pixels <= -30) {
                                _.increaseLimitMessage(
                                    scrollInfo.metrics.maxScrollExtent);
                                return;
                              } else if (scrollInfo.metrics.pixels >
                                  (scrollInfo.metrics.maxScrollExtent + 20)) {
                                _.enableAutoScroll();
                                return;
                              }
                              return;
                            },
                            child: Stack(
                              children: [
                                CupertinoScrollbar(
                                  controller: _.scroll,
                                  child: ListView.builder(
                                      physics: AlwaysScrollableScrollPhysics(
                                          parent: BouncingScrollPhysics()),
                                      controller: _.scroll,
                                      shrinkWrap: false,
                                      itemCount: _.messages.length,
                                      itemBuilder: (context, i) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: _messageBox(
                                            _.messages[i],
                                            i,
                                            _.timeSeen[i],
                                            controller.user.userId,
                                            timeFilter: _.timeMessage,
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                  } else {
                    return LoadingContent();
                  }
                },
              );
            }
          }),
      bottomNavigationBar: GetBuilder<ChatController>(
          id: 'send',
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          width: Get.context.width / 1.3,
                          child: TextField(
                            maxLines: 15,
                            minLines: 1,
                            controller: controller.chat,
                            onChanged: (val) {
                              controller.checkText();
                            },
                            textInputAction: TextInputAction.done,
                            textCapitalization: TextCapitalization.sentences,
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey,
                              hintText: 'Type your message',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: controller.confirm
                            ? () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                controller.sendMessage();
                              }
                            : null,
                        child: Transform.rotate(
                          angle: 45 * math.pi / 90,
                          child: Icon(
                            Icons.assistant_navigation,
                            color: Colors.indigo,
                            size: 35,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

  Builder _messageBox(
    Chat _chatDatas,
    int i,
    String timeSeen,
    int userId, {
    @required List timeFilter,
  }) {
    return Builder(builder: (context) {
      int _timeFilterIndex = timeFilter.indexWhere(
        (element) => element.contains(
          DateFormat("dd MMMM y").format(
            DateTime.fromMillisecondsSinceEpoch(_chatDatas.sentAt),
          ),
        ),
      );

      return Column(
        children: [
          if (i == _timeFilterIndex) _timefilter(timeFilter, i),
          _messageAlignment(
            _chatDatas,
            userId,
            i,
            DateFormat("jm").format(
              DateTime.fromMillisecondsSinceEpoch(_chatDatas.sentAt),
            ),
            timeSeen,
            alignmentText: _chatDatas.userId == userId
                ? Alignment.centerRight
                : Alignment.centerLeft,
            crossAxisAlignment: _chatDatas.userId == userId
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: _chatDatas.userId == userId
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
          )
        ],
      );
    });
  }

  Padding _timefilter(List timeFilter, int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              timeFilter[i],
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Divider(thickness: 2),
        ],
      ),
    );
  }

  Align _messageAlignment(
    Chat _chatDatas,
    int userId,
    int i,
    String _time,
    String _readTime, {
    @required Alignment alignmentText,
    @required CrossAxisAlignment crossAxisAlignment,
    @required MainAxisAlignment mainAxisAlignment,
  }) {
    return Align(
      alignment: alignmentText,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            _buildMessageWidget(
              _chatDatas.userId == userId ? true : false,
              _chatDatas,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                if (_chatDatas.userId == userId && _readTime != '')
                  Text(
                    'seen',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    _time,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  RoundedRectangleBorder _roundedRectangleBorder(
    bool primary, {
    double radius,
  }) {
    if (primary) {
      return RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(radius ?? 30),
              topLeft: Radius.circular(radius ?? 30),
              bottomLeft: Radius.circular(radius ?? 30)));
    } else {
      return RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius ?? 30),
        topRight: Radius.circular(radius ?? 30),
        bottomRight: Radius.circular(radius ?? 30),
      ));
    }
  }

  Builder _buildMessageWidget(
    bool primary,
    Chat _chatDatas,
  ) {
    return Builder(
      builder: (context) {
        return Card(
          color: Colors.white,
          shape: _roundedRectangleBorder(
            primary,
            radius: 10,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Column(
              children: [
                Text(
                  "${_chatDatas.message}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
