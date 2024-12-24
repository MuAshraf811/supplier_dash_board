import 'package:dash_board/core/widgets/spacers.dart';
import 'package:dash_board/home/presentation/controller/home_cubit.dart';
import 'package:dash_board/home/presentation/widget/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is FetchingClientOrdersErrorState ||
          current is FetchingClientOrdersState ||
          current is FetchingClientOrdersSuccessState,
      builder: (context, state) {
        if (state is FetchingClientOrdersState) {
          return Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 1.5,
                  crossAxisSpacing: 16.h,
                  mainAxisSpacing: 18.h),
              itemBuilder: (context, index) => const ShimmerUserCard(),
            ),
          );
        }
        return Expanded(
          child: GridView.builder(
            padding: EdgeInsets.only(right: 12.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3 / 2.2,
                crossAxisSpacing: 12.h,
                mainAxisSpacing: 12.h),
            itemCount: context.read<HomeCubit>().allOrders.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 16.h),
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
                        "${context.read<HomeCubit>().allOrders[index].category}\n${context.read<HomeCubit>().allOrders[index].orderType}",
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          context.read<HomeCubit>().deletSpacificOrder(
                              collection: "Orders",
                              id: context
                                  .read<HomeCubit>()
                                  .allOrders[index]
                                  .orderId);
                        },
                        child: const Column(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            VerticalSpacer(space: 10),
                            Text(
                              "Delete",
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.read<HomeCubit>().acceptSpacificOrder(
                              order:
                                  context.read<HomeCubit>().allOrders[index]);
                        },
                        child: const Column(
                          children: [
                            Icon(
                              Icons.verified_sharp,
                              color: Colors.green,
                            ),
                            VerticalSpacer(space: 10),
                            Text(
                              "Accept",
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpacer(space: 8),
                  Text(
                    context.read<HomeCubit>().allOrders[index].details,
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                  const VerticalSpacer(space: 8),
                  Text(
                    context.read<HomeCubit>().allOrders[index].extea_details,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const VerticalSpacer(space: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      context.read<HomeCubit>().allOrders[index].date,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  const VerticalSpacer(space: 12),
                  const Text(
                    "Client Information :",
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  const VerticalSpacer(space: 12),
                  Row(
                    children: [
                      Text(
                        " Name : ${context.read<HomeCubit>().allOrders[index].name}",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      const Text("    ||    "),
                      Text(
                        "Mobile : ${context.read<HomeCubit>().allOrders[index].mobile}",
                        style: const TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        " Email : ${context.read<HomeCubit>().allOrders[index].email}",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      const Text("    ||    "),
                      Text(
                        "Address : ${context.read<HomeCubit>().allOrders[index].address}",
                        style: const TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    ],
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
