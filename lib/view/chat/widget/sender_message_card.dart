import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../data/Model/enum/message_enum.dart';
import '../../../res/color/app_color.dart';
import '../../../res/widget/display_text_image_gif.dart';


class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    super.key,
    required this.message,
    required this.date, required this.type, this.onRightSwipe, required this.repliedText, required this.userName, required this.repliedMessageType,
  });
  final String message;
  final String date;
  final MessageEnum type;
  final VoidCallback? onRightSwipe; // Change here
  final String repliedText;
  final String userName;
  final MessageEnum repliedMessageType;

  @override
  Widget build(BuildContext context) {
    final isReplying = repliedText.isNotEmpty;

    return SwipeTo(
      onRightSwipe: onRightSwipe != null // Check if onLeftSwipe is not null before invoking
          ? (details) => onRightSwipe!() // Invoke onLeftSwipe if not null
          : null,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: AppColor.senderMessageColor,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              children: [
                Padding(
                    padding: type == MessageEnum.text? const EdgeInsets.only(
                      left: 10,
                      right: 30,
                      top: 5,
                      bottom: 20,
                    ): const EdgeInsets.only(
                      left: 5,
                      right: 5,
                      top: 5,
                      bottom: 25,
                    ),
                    child: Column(
                      children: [
                        if(isReplying)...[
                          Text(
                            userName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),
                          const SizedBox(height: 3,),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: AppColor.backgroundColor.withOpacity(0.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                )
                            ),
                            child: DisplayTextImageGif(
                                message: repliedText,
                                type: repliedMessageType
                            ),
                          ),
                          const SizedBox(height: 8,),




                        ],
                        DisplayTextImageGif(
                            message: message,
                            type: type
                        ),
                      ],
                    )
                ),
                Positioned(
                  bottom: 2,
                  right: 10,
                  child: Text(
                    date,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
