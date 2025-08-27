import 'package:dash_board/core/widgets/spacers.dart';
import 'package:dash_board/home/presentation/controller/home_cubit.dart';
import 'package:dash_board/home/presentation/widget/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientApprovalsView extends StatelessWidget {
  const ClientApprovalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is FetchingClientApprovalsSuccessState ||
          current is FetchingClientApprovalsState ||
          current is FetchingClientApprovalsErrorState,
      builder: (context, state) {
        if (state is FetchingClientApprovalsState) {
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
            padding: EdgeInsets.only(right: 10.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3 / 2.2,
                crossAxisSpacing: 12.h,
                mainAxisSpacing: 12.h),
            itemCount: context.read<HomeCubit>().allClientApprovals.length,
            itemBuilder: (context, index) => FittedBox(
              fit: BoxFit.fitWidth,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
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
                            padding: const EdgeInsets.only(right: 18.0),
                            child: Text(
                              "Offer : ${context.read<HomeCubit>().allClientApprovals[index].offerId}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              context.read<HomeCubit>().deletSpacificOrder(
                                  collection: "client_approvals",
                                  id: context
                                      .read<HomeCubit>()
                                      .allClientApprovals[index]
                                      .id
                              ).then((value) {
                                          context.read<HomeCubit>().fetchClientApprovals();
                                      },);

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
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Text(
                          "Order : ${context.read<HomeCubit>().allClientApprovals[index].orderNumber}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const VerticalSpacer(space: 8),
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Text(
                          "SupplierId: ${context.read<HomeCubit>().allClientApprovals[index].supplierDataId}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const VerticalSpacer(space: 8),
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Text(
                          "Supplier Name: ${context.read<HomeCubit>().allClientApprovals[index].supplierName}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const VerticalSpacer(space: 8),
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Text(
                          "Client Email: ${context.read<HomeCubit>().allClientApprovals[index].clientEmail}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      // const VerticalSpacer(space: 12),
                      // Text(
                      //   "Supplier Name : ${context.read<HomeCubit>().allClientApprovals[index].supplierName}",
                      //   style:
                      //       const TextStyle(fontSize: 18, color: Colors.black),
                      // ),

                      const VerticalSpacer(space: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Date: ${context
                              .read<HomeCubit>()
                              .allClientApprovals[index]
                              .offerDate}",
                          style: const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
