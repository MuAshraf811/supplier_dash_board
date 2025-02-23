import 'package:dash_board/home/presentation/controller/cubit/chat_cubit.dart';
import 'package:dash_board/home/presentation/controller/home_cubit.dart';
import 'package:dash_board/home/presentation/view/home_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/fcm_handler.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  @override
  void initState() {

    // NotificationService.sendNotification(
    //     userToken:  "eHMgfBowAE1vn7TBN5d04o:APA91bFiTKBVPsVMbG3bK7qJZ05ooNTgs-VsNGpTx9Om3CdyLK99zdC59lvWBfaVCnLd8r9csymjaffJypEix3OwguFto-Q59yc2nA2M1PnVDuWMzpl8u9o",
    //     title: "New Offer",
    //     body:  "Description: new desc,\nAmounts: 5, \nRate: 7.5, \nQuantity: 12 \nVat%: 3% \ntotal: 100",
    //     data: {
    //       // 'quotationDescription': "offer.offerDescription",
    //       // 'quotationDate': "offer.offerDate",
    //       // 'amount': "offer.amount",
    //       // 'rate': "offer.rate",
    //       // 'quantity': "offer.quantity",
    //       "offerSupplierId": "FS4OR3-6CEs2Qei4Vib5ra-9DWLm",
    //       "date": "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} at: ${DateTime.now().hour}:${DateTime.now().minute}"
    //     }
    // );
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
          ],
          child: const HomePageView(),
        ),
      ),
    );
  }
}
