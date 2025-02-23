import 'package:dash_board/core/widgets/spacers.dart';
import 'package:dash_board/home/presentation/controller/cubit/chat_cubit.dart';
import 'package:dash_board/home/presentation/widget/chat_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/message_modl.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: BlocBuilder<ChatCubit, ChatState>(
              buildWhen: (previous, current) =>
                  current is FetchingAllChatsErrorState ||
                  current is FetchingAllChatsState ||
                  current is FetchingAllChatsSuccessState,
              builder: (context, state) {
                if (state is FetchingAllChatsSuccessState) {
                  return ListView.separated(
                    padding: EdgeInsets.only(top: 16.h),
                    itemCount: context.read<ChatCubit>().allUsers.length,
                    separatorBuilder: (context, index) => Divider(
                      thickness: 1.h,
                      color: Colors.grey,
                      height: 32.h,
                      indent: 12.h,
                      endIndent: 12.h,
                    ),
                    itemBuilder: (context, index) => ChatItem(
                        onTap: () {
                          context.read<ChatCubit>().userChatId =
                              context.read<ChatCubit>().allUsers[index].docId;
                          context.read<ChatCubit>().getAllmessages(
                              id: context
                                  .read<ChatCubit>()
                                  .allUsers[index]
                                  .docId);
                        },
                        name:
                            "${context.read<ChatCubit>().allUsers[index].first_name} ${context.read<ChatCubit>().allUsers[index].last_name}",
                        email: context.read<ChatCubit>().allUsers[index].email,
                        city: context.read<ChatCubit>().allUsers[index].city,
                        isSupplier:
                        context.read<ChatCubit>().allUsers[index].isSupplier,

                        // context.read<ChatCubit>().isSupplierChatmarker(
                        //     context
                        //         .read<ChatCubit>()
                        //         .allUsers[index]
                        //         .docId
                        // ),
                    ),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    thickness: 1.h,
                    color: Colors.grey,
                    indent: 12.h,
                    height: 36.h,
                    endIndent: 12.h,
                  ),
                  shrinkWrap: true, // Ensures constraints are respected
                  itemBuilder: (context, index) => const ChatShimmer(),
                  itemCount: 6,
                );
              },
            ),
          ),
          VerticalDivider(
            indent: 16.h,
            endIndent: 16.h,
            color: Colors.grey,
            thickness: 1.h,
            width: 12.h,
          ),
          Expanded(
            // Constrain the right-side container
            child: Column(
              children: [
                const VerticalSpacer(space: 16),
                BlocBuilder<ChatCubit, ChatState>(
                  buildWhen: (previous, current) =>
                      current is FetchingMessagesState ||
                      current is FetchingMessagesSuccessState,
                  builder: (context, state) {
                    if (state is FetchingMessagesSuccessState) {
                      return StreamBuilder<List<MessageprodModel>>(
                        stream: context.read<ChatCubit>().getMessagesStream(
                            context.read<ChatCubit>().userChatId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text('No messages yet.'),
                            );
                          }

                          final messages = snapshot.data!;
                          return Expanded(
                            child: ListView.builder(
                              reverse:
                                  true, // Optional: Display newest messages at the bottom.
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message = messages[index];
                                return MessageItem(
                                  isSender: message.userId == "1",
                                  message: message.message,
                                  time: message.time,
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
                    return Expanded(
                        child: Container(
                      color: Colors.white,
                    ));
                  },
                ),
                const VerticalSpacer(space: 12),
                const ChatBottomBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  const ChatItem(
      {super.key,
      required this.name,
      required this.email,
      required this.city,
      required this.isSupplier,
      required this.onTap});
  final String name;
  final String email;
  final String city;
  final bool isSupplier;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: FittedBox(
        fit: BoxFit.cover,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  const VerticalSpacer(space: 6),
                  Text(
                    email,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 30,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                isSupplier ? "Supplier" : "Client",
                style: const TextStyle(
                    color: Colors.grey, fontSize: 30, fontWeight: FontWeight.w300),
              ),
              // const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 14.h,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChatShimmer extends StatelessWidget {
  const ChatShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 16,
                width: 120,
                color: Colors.grey,
              ),
              const SizedBox(height: 6),
              Container(
                height: 14,
                width: 100,
                color: Colors.grey,
              ),
            ],
          ),
          const SizedBox(width: 16),
          Container(
            height: 14,
            width: 80,
            color: Colors.grey,
          ),
          Expanded(
            // Fix layout issue with Spacer
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 14,
                width: 14,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.isSender,
    required this.message,
    required this.time,
  });
  final bool isSender;
  final String message;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: !isSender ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        margin: EdgeInsets.only(right: 12.w, bottom: 8.h, left: 12.w),
        width: MediaQuery.sizeOf(context).height / 2,
        decoration: BoxDecoration(
          color: isSender ? Colors.blue : Colors.white,
          border: Border.all(color: isSender ? Colors.blue : Colors.blue),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(isSender ? 16.r : 0),
            bottomRight: Radius.circular(isSender ? 0 : 16.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              maxLines: 15,
              style: TextStyle(
                fontSize: 16,
                color: isSender ? Colors.white : Colors.black,
              ),
            ),
            const VerticalSpacer(space: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 13,
                  color: isSender ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
