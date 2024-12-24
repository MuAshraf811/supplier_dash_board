import 'package:dash_board/core/widgets/spacers.dart';
import 'package:dash_board/home/presentation/controller/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

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
                    shrinkWrap: true, // Ensures constraints are respected
                    itemCount:
                        context.read<ChatCubit>().allChatsInDataBase.length,
                    separatorBuilder: (context, index) => Divider(
                      thickness: 1.h,
                      color: Colors.grey,
                      indent: 12.h,
                      endIndent: 12.h,
                    ),
                    itemBuilder: (context, index) => ChatItem(
                        name: context
                            .read<ChatCubit>()
                            .allChatsInDataBase[index]
                            .userFirstName,
                        email: context
                            .read<ChatCubit>()
                            .allChatsInDataBase[index]
                            .userEmail,
                        city: context
                            .read<ChatCubit>()
                            .allChatsInDataBase[index]
                            .city,
                        isSupplier: true),
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
            child: Container(
              height: 600.h,
              color: Colors.white,
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
      required this.isSupplier});
  final String name;
  final String email;
  final String city;
  final bool isSupplier;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const VerticalSpacer(space: 6),
              Text(
                email,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
          const HorizontalSpacer(space: 16),
          Text(
            isSupplier ? "Supplier" : "Client",
            style: const TextStyle(
                color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w300),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 14.h,
            color: Colors.grey,
          )
        ],
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
