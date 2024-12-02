import 'package:dash_board/core/constants/side_bar.dart';
import 'package:dash_board/core/widgets/spacers.dart';
import 'package:dash_board/core/widgets/svg_handler.dart';
import 'package:dash_board/home/presentation/controller/home_cubit.dart';
import 'package:dash_board/home/presentation/view/offers_view.dart';
import 'package:dash_board/home/presentation/view/orders_view.dart';
import 'package:dash_board/home/presentation/view/users_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});
  static const List<Widget> _pages = [
    UsersView(),
    OrdersView(),
    OffersView(),
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
      width: 24.w,
      height: 400.h,
      margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(48.r)),
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
                            if(bar.index==1){ 
                              context.read<HomeCubit>().fetchClientOrders();
                            } else   if(bar.index==2){ 
                              context.read<HomeCubit>().fetchClientOrders();
                            }
                      },
                      child: Container(
                        height: 60.h,
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
                            const VerticalSpacer(space: 12),
                            Text(
                              bar.title,
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
