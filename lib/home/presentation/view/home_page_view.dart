import 'package:dash_board/core/constants/side_bar.dart';
import 'package:dash_board/core/widgets/spacers.dart';
import 'package:dash_board/core/widgets/svg_handler.dart';
import 'package:dash_board/home/presentation/controller/cubit/chat_cubit.dart';
import 'package:dash_board/home/presentation/controller/home_cubit.dart';
import 'package:dash_board/home/presentation/view/accepted_offers.dart';
import 'package:dash_board/home/presentation/view/accepted_orders_view.dart';
import 'package:dash_board/home/presentation/view/chat_view.dart';
import 'package:dash_board/home/presentation/view/offers_view.dart';
import 'package:dash_board/home/presentation/view/orders_view.dart';
import 'package:dash_board/home/presentation/view/suppliers_view.dart';
import 'package:dash_board/home/presentation/view/users_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/responsive_text.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});
  static final List<Widget> _pages = [
    const UsersView(),
    const SuppliersView(),
    const ChatView(),
    const OrdersView(),
    const AcceptedOrdersView(),
    const OffersView(),
    const AcceptedOffersView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SideBarWidget(),
          const HorizontalSpacer(space: 12),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return _pages[context.read<HomeCubit>().sideBarIndex];
            },
          ),
        ],
      ),
    );
  }
}

class SideBarWidget extends StatelessWidget {
  const SideBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26.w,
      height: 800.h,
      margin: EdgeInsets.only(right: 6.w),
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) => current is ChangingSideBarState,
        builder: (context, state) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: SideBar.bars
                  .map(
                    (bar) => InkWell(
                      onTap: () {
                        context
                            .read<HomeCubit>()
                            .changeViewonSideBar(index: bar.index);
                        context.read<HomeCubit>().fetchClientAcceptedOrders();
                        if (bar.index == 3) {
                          context.read<HomeCubit>().fetchClientOrders();
                        } else if (bar.index == 4) {
                          context.read<HomeCubit>().fetchClientAcceptedOrders();
                        } else if (bar.index == 1) {
                          context.read<HomeCubit>().fetchSuppliers();
                        } else if (bar.index == 2) {
                          context.read<ChatCubit>().chechkChatIdExistance();
                          context.read<ChatCubit>().getAllChats();
                        } else if (bar.index == 5) {
                          context.read<HomeCubit>().fetchSupplierOffers();
                        } else if (bar.index == 6) {
                          context
                              .read<HomeCubit>()
                              .fetchClientAcceptedOfferss();
                        }
                      },
                      child: Container(
                        height: 70.h,
                        margin: EdgeInsets.only(bottom: 10.h),
                        padding: EdgeInsets.only(left: 4.w),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                                color: bar.index ==
                                        context.read<HomeCubit>().sideBarIndex
                                    ? Colors.white
                                    : Colors.blue,
                                width: 2.w),
                          ),
                        ),
                        child: Column(
                          children: [
                            SvgHandler(
                              imagePath: bar.path,
                              height: 24,
                              width: 24,
                              color: Colors.white,
                            ),
                            const VerticalSpacer(space: 10),
                            ResponsiveText(
                              text: bar.title,
                              width: 50,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList());
        },
      ),
    );
  }
}
