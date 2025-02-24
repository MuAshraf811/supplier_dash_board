import 'package:dash_board/core/widgets/spacers.dart';
import 'package:dash_board/home/presentation/controller/home_cubit.dart';
import 'package:dash_board/home/presentation/widget/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AcceptedOffersView extends StatelessWidget {
  const AcceptedOffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is FetchingSupplierAcceptedOffersSuccessState ||
          current is FetchingSupplierAcceptedOffersState ||
          current is FetchingSupplierAcceptedOffersErrorState,
      builder: (context, state) {
        if (state is FetchingSupplierAcceptedOffersState) {
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
            itemCount: context.read<HomeCubit>().allAcceptedOffers.length,
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
                              "Offer : ${context.read<HomeCubit>().allAcceptedOffers[index].offerId}\nOrder : ${context.read<HomeCubit>().allAcceptedOffers[index].orderNumber}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context.read<HomeCubit>().deletSpacificOrder(
                                  collection: "accepted_offers",
                                  id: context
                                      .read<HomeCubit>()
                                      .allAcceptedOffers[index]
                                      .offerId).then((value) {
                                          context.read<HomeCubit>().fetchClientAcceptedOfferss();
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
                      const VerticalSpacer(space: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.25,
                        child: Text(
                          "Description: ${context
                              .read<HomeCubit>()
                              .allAcceptedOffers[index]
                              .offerDescription}",
                          maxLines: 3,
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      const VerticalSpacer(space: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Date: ${context
                              .read<HomeCubit>()
                              .allAcceptedOffers[index]
                              .offerDate}",
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                      const VerticalSpacer(space: 12),
                      const Text(
                        "Supplier Information :",
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                      const VerticalSpacer(space: 8),
                      Text(
                        "SupplierId: ${context.read<HomeCubit>().allAcceptedOffers[index].supplierDataId}",
                        style: const TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                      const VerticalSpacer(space: 12),
                      Row(
                        children: [
                          Text(
                            " Name : ${context.read<HomeCubit>().allAcceptedOffers[index].supplierName}",
                            style:
                                const TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          const Text("    ||    "),
                          Text(
                            "Mobile : ${context.read<HomeCubit>().allAcceptedOffers[index].mobile}",
                            style: const TextStyle(fontSize: 14, color: Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            " Email : ${context.read<HomeCubit>().allAcceptedOffers[index].email}",
                            style:
                                const TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          const Text("    ||    "),
                          Text(
                            "Address : ${context.read<HomeCubit>().allAcceptedOffers[index].city}",
                            style: const TextStyle(fontSize: 14, color: Colors.red),
                          ),
                        ],
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
