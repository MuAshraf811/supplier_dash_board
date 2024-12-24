import 'package:dash_board/core/widgets/spacers.dart';
import 'package:dash_board/home/presentation/controller/home_cubit.dart';
import 'package:dash_board/home/presentation/widget/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is FetchinSupplierOffersErrorState ||
          current is FetchingSupplierOffersState ||
          current is FetchingSupplierOffersSuccessState,
      builder: (context, state) {
        if (state is FetchingSupplierOffersState) {
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
            itemCount: context.read<HomeCubit>().allOffers.length,
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
                        "${context.read<HomeCubit>().allOffers[index].offerId} ",
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          context.read<HomeCubit>().deletSpacificOffer(
                              collection: "quotations",
                              id: context
                                  .read<HomeCubit>()
                                  .allOffers[index]
                                  .offerId);
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
                          context.read<HomeCubit>().acceptSpacificOffer(
                              offer:
                                  context.read<HomeCubit>().allOffers[index]);
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
                    "Order id : ${context.read<HomeCubit>().allOffers[index].orderNumber}",
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const VerticalSpacer(space: 8),
                  Text(
                    "Offer id : ${context.read<HomeCubit>().allOffers[index].offerId}",
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                  const VerticalSpacer(space: 8),
                  Text(
                    context.read<HomeCubit>().allOffers[index].offerDescription,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const VerticalSpacer(space: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      context.read<HomeCubit>().allOffers[index].offerDate,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  const VerticalSpacer(space: 12),
                  Row(
                    children: [
                      const Text(
                        "Quantity :",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Text(
                        " ${context.read<HomeCubit>().allOffers[index].quantity}",
                        style: const TextStyle(fontSize: 14, color: Colors.red),
                      ),
                      const Text("   ||   "),
                      const Text(
                        "Rate :",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Text(
                        " ${context.read<HomeCubit>().allOffers[index].rate}",
                        style: const TextStyle(fontSize: 14, color: Colors.red),
                      ),
                      const Text("  ||  "),
                      const Text(
                        "Amount :",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Text(
                        " ${context.read<HomeCubit>().allOffers[index].amount}",
                        style: const TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    ],
                  ),
                  const Text(
                    "Supplier Information :",
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  const VerticalSpacer(space: 6),
                  Row(
                    children: [
                      Text(
                        " Name : ${context.read<HomeCubit>().allOffers[index].supplierName}",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      const Text("    ||    "),
                      Text(
                        "Mobile : ${context.read<HomeCubit>().allOffers[index].mobile}",
                        style: const TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        " email : ${context.read<HomeCubit>().allOffers[index].emial}",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      const Text("    ||    "),
                      Text(
                        "city : ${context.read<HomeCubit>().allOffers[index].city}",
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
