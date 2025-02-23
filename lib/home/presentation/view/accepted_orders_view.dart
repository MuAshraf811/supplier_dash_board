import 'package:dash_board/core/widgets/spacers.dart';
import 'package:dash_board/home/presentation/controller/home_cubit.dart';
import 'package:dash_board/home/presentation/widget/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AcceptedOrdersView extends StatelessWidget {
  const AcceptedOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is FetchingClientAcceptedOrdersErrorState ||
          current is FetchingClientAcceptedOrdersState ||
          current is FetchingClientAcceptedOrdersSuccessState,
      builder: (context, state) {
        if (state is FetchingClientAcceptedOrdersState) {
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
        if(context.read<HomeCubit>().allAcceptedOrders.isEmpty ){
          return Center(
            child: ElevatedButton(onPressed: () {

            }, child: Text("Reload")),
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
            itemCount: context.read<HomeCubit>().allAcceptedOrders.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 16.h),
              // margin: EdgeInsets.only(top: 16.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Colors.blue,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: SizedBox(
                            width: 200,
                            child: Text(
                              "${context.read<HomeCubit>().allAcceptedOrders[index].category}\n${context.read<HomeCubit>().allAcceptedOrders[index].orderType}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.read<HomeCubit>().deletSpacificOrder(
                                collection: "accepted_orders",
                                id: context
                                    .read<HomeCubit>()
                                    .allAcceptedOrders[index]
                                    .orderId);
                          },
                          child: const Column(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.red,size: 20,
                              ),
                              VerticalSpacer(space: 10),
                              Text(
                                "Delete",
                                style: TextStyle(color: Colors.green),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const VerticalSpacer(space: 8),
                    Text(
                      "Id: ${context.read<HomeCubit>().allAcceptedOrders[index].orderId}",
                      style: const TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                    const VerticalSpacer(space: 8),
                    Text(
                      context.read<HomeCubit>().allAcceptedOrders[index].details,
                      style: const TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                    const VerticalSpacer(space: 8),
                    Text(
                      context
                          .read<HomeCubit>()
                          .allAcceptedOrders[index]
                          .extea_details,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    const VerticalSpacer(space: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        context.read<HomeCubit>().allAcceptedOrders[index].date,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    const VerticalSpacer(space: 12),
                    const Text(
                      "Client Information :",
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                    const VerticalSpacer(space: 12),
                    Text(
                      "Id : ${context.read<HomeCubit>().allAcceptedOrders[index].userId}",
                      style:
                      const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    const VerticalSpacer(space: 12),
                    Text(
                      "Name : ${context.read<HomeCubit>().allAcceptedOrders[index].name}",
                      style:
                      const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    // const Text("    ||    "),
                    Text(
                      "Mobile : ${context.read<HomeCubit>().allAcceptedOrders[index].mobile}",
                      style: const TextStyle(fontSize: 14, color: Colors.red),
                    ),
                    Text(
                      "Email : ${context.read<HomeCubit>().allAcceptedOrders[index].email}",
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    // const Text("    ||    "),
                    Text(
                      "Address : ${context.read<HomeCubit>().allAcceptedOrders[index].address}",
                      style: const TextStyle(fontSize: 14, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
