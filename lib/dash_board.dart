import 'package:dash_board/home/presentation/controller/cubit/chat_cubit.dart';
import 'package:dash_board/home/presentation/controller/home_cubit.dart';
import 'package:dash_board/home/presentation/view/home_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

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
          ],
          child: const HomePageView(),
        ),
      ),
    );
  }
}
