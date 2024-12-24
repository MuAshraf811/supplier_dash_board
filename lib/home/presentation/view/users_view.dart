import 'package:dash_board/core/widgets/spacers.dart';
import 'package:dash_board/home/presentation/controller/home_cubit.dart';
import 'package:dash_board/home/presentation/widget/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is FetchingAllUsersErrorState ||
          current is FetchingAllUsersState ||
          current is FetchingAllUsersSuccessState,
      builder: (context, state) {
        if (state is FetchingAllUsersState) {
          return Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 2 / 1.5),
              itemBuilder: (context, index) => const ShimmerUserCard(),
            ),
          );
        }
        return Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.7 / 0.8,
                crossAxisSpacing: 12.h,
                mainAxisSpacing: 12.h),
            itemCount: context.read<HomeCubit>().users.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
              margin: EdgeInsets.only(top: 16.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Colors.blue,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${context.read<HomeCubit>().users[index].first_name} ${context.read<HomeCubit>().users[index].last_name}",
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                          onTap: () {
                            context.read<HomeCubit>().deletUser(
                                id: context
                                    .read<HomeCubit>()
                                    .users[index]
                                    .docId);
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                  const VerticalSpacer(space: 8),
                  Text(
                    context.read<HomeCubit>().users[index].email,
                    style: const TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                  const VerticalSpacer(space: 8),
                  Text(
                    context.read<HomeCubit>().users[index].mobile_number,
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  const VerticalSpacer(space: 8),
                  Text(
                    context.read<HomeCubit>().users[index].city,
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
