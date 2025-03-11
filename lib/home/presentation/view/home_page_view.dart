import 'package:dash_board/core/constants/side_bar.dart';
import 'package:dash_board/core/sound_service.dart';
import 'package:dash_board/core/widgets/spacers.dart';
import 'package:dash_board/core/widgets/svg_handler.dart';
import 'package:dash_board/home/presentation/controller/cubit/chat_cubit.dart';
import 'package:dash_board/home/presentation/controller/home_cubit.dart';
import 'package:dash_board/home/presentation/view/accepted_offers.dart';
import 'package:dash_board/home/presentation/view/accepted_orders_view.dart';
import 'package:dash_board/home/presentation/view/chat_view.dart';
import 'package:dash_board/home/presentation/view/client_approvals_view.dart';
import 'package:dash_board/home/presentation/view/offers_view.dart';
import 'package:dash_board/home/presentation/view/orders_view.dart';
import 'package:dash_board/home/presentation/view/suppliers_view.dart';
import 'package:dash_board/home/presentation/view/users_view.dart';
import 'package:dash_board/notifications/presentation/cubit/notification_cubit.dart';
import 'package:dash_board/notifications/presentation/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/constants.dart';
import '../../../core/service_locator.dart';
import '../widget/responsive_text.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});
  static final List<Widget> _pages = [
    const UsersView(),
    const SuppliersView(),
    const ChatView(),
    const OrdersView(),
    const AcceptedOrdersView(),
    const OffersView(),
    const AcceptedOffersView(),
    const NotificationsScreen(),
    const ClientApprovalsView()
  ];

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  int _previousCount = 0;
  @override void initState() {
    super.initState();
    showNotificationPermissionDialog(context);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showNotificationPermissionDialog(context);
    // });
    _listenToNotifications();
    notificationService.getAllNotificationsStream();
  }
  void _listenToNotifications() {
    notificationService.getAllNotificationsStream().listen((notifications) {
      setState(() {
        // Check if we have new notifications
        if (_previousCount > 0 && notifications.length > _previousCount) {
          _showNewNotificationAlert();
          NotificationSoundPlayer().playNotificationSound();
          haveNotifications =true;
        }
        // notifications.sort((a, b) => b.date.compareTo(a.date));
        _previousCount = notifications.length;
        // _notifications = notifications;
      });
    });
  }
  void _showNewNotificationAlert() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('New notification received!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
        // action: SnackBarAction(
        //   label: 'View',
        //   onPressed: () {
        //     // Navigate to notifications view or expand notifications panel
        //   },
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SideBarWidget(),
          const HorizontalSpacer(space: 12),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return HomePageView._pages[context.read<HomeCubit>().sideBarIndex];
            },
          ),
        ],
      ),
    );
  }
}

class SideBarWidget extends StatelessWidget {
  SideBarWidget({
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
          return SingleChildScrollView(
            child: Column(
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
                          } else if(bar.index == 7){

                            notificationService.getAllNotificationsStream();
                            haveNotifications = false;
                            // context.read<HomeCubit>().loadNotifications();
                          }else if(bar.index == 8){
                            context
                                .read<HomeCubit>()
                                .fetchClientApprovals();
                          }
                        },
                        child: Container(
                          height: 70.h,
                          margin: EdgeInsets.only(bottom: 5.h),
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
                              if(bar.path.isNotEmpty)
                              SvgHandler(
                                imagePath: bar.path,
                                height: 20,
                                width: 20,
                                color: Colors.white,
                              ),
                              if(bar.path.isEmpty)
                                haveNotifications?
                                    const Icon(Icons.notifications_active, color: Colors.red)
                                : const Icon(Icons.notifications_none, color: Colors.white,),
                              const VerticalSpacer(space: 5),
                              ResponsiveText(
                                text: bar.title,
                                width: 70,
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
                    .toList()),
          );
        },
      ),
    );
  }
}
