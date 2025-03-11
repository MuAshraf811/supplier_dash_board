import 'package:dash_board/home/presentation/controller/cubit/chat_cubit.dart';
import 'package:dash_board/home/presentation/controller/home_cubit.dart';
import 'package:dash_board/home/presentation/view/home_page_view.dart';
import 'package:dash_board/notifications/presentation/cubit/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/fcm_handler.dart';
import 'core/service_locator.dart';
import 'core/sound_service.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<HomeCubit>(
              create: (context) => HomeCubit()..fetchUsers(),
            ),
            BlocProvider<ChatCubit>(
              create: (context) => ChatCubit(),
            ),
            // BlocProvider<NotificationsCubit>(
            //   create: (context) => ServiceLocator.getIt<NotificationsCubit>(),
            // ),
          ],
          child: const HomePageView(),
        ),
      ),
    );
  }
}
