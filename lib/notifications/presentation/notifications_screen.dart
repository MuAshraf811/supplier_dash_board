import 'package:dash_board/home/presentation/controller/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/constants.dart';
import '../../core/notification_service.dart';
import '../../core/service_locator.dart';
import '../../core/sound_service.dart';
import '../../core/widgets/spacers.dart';
import '../data/models/notifications_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _AdminNotificationDashboardState createState() =>
      _AdminNotificationDashboardState();
}

class _AdminNotificationDashboardState extends State<NotificationsScreen> {
  // notificationService =
  //     NotificationService(userId: 'admin');
  List<NotificationModel> _notifications = [];
  // int _previousCount = 0;

  @override
  void initState() {
    super.initState();
    _listenToNotifications();
    notificationService.getAllNotificationsStream();
  }

  void _listenToNotifications() {
    notificationService.getAllNotificationsStream().listen((notifications) {
      setState(() {
        // Check if we have new notifications
        // if (_previousCount > 0 && notifications.length > _previousCount) {
        //   _showNewNotificationAlert();
        // }
        notifications.sort((a, b) => b.date.compareTo(a.date));
        // _previousCount = notifications.length;
        _notifications = notifications;
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
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.7,
      child: SizedBox(
          width: MediaQuery.of(context).size.width*0.7,
          child: Column(
            children: [
              const Text('Dashboard Notification',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),),
              Expanded(
                child: ListView.builder(
                  itemCount: _notifications.length,
                  itemBuilder: (context, index) {
                    final notification = _notifications[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(notification.title),
                        subtitle: Text(notification.body),
                        trailing: Text(
                          notification.date.toIso8601String().substring(0,19).replaceFirst('T', ' at '),
                        ),
                        leading: notification.isRead
                            ? const Icon(Icons.notifications_none)
                            : const Icon(Icons.notifications_active,
                                color: Colors.red),
                        onTap: () {
                          if (!notification.isRead) {
                            notificationService.markAsRead(notification.id);
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       _showSendNotificationDialog();
              //     },
              //     child: const Text('Send New Notification'),
              //   ),
              // ),
            ],
          ),
        ),

    );
  }

  void _showSendNotificationDialog() {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();
    final recipientController = TextEditingController(text: 'all');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send New Notification'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(labelText: 'Message'),
              maxLines: 3,
            ),
            TextField(
              controller: recipientController,
              decoration: const InputDecoration(
                  labelText: 'Recipient ID (use "all" for everyone)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  bodyController.text.isNotEmpty) {
                notificationService.createNotification(
                  title: titleController.text,
                  body: bodyController.text,
                  recipientId: recipientController.text,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}

//   const NotificationsScreen({super.key});
//
//   @override
//   State<NotificationsScreen> createState() => _NotificationsScreenState();
// }
//
// class _NotificationsScreenState extends State<NotificationsScreen> {
//
//
//   final NotificationService _notificationService =
//   NotificationService(userId: 'admin');
//   List<NotificationModel> _notifications = [];
//   int _previousCount = 0;
//
//
//   @override void initState() {
//     // ServiceLocator.getIt<NotificationsCubit>().loadNotifications();
//     super.initState();
//     _listenToNotifications();
//   }
//
//   void _listenToNotifications() {
//     _notificationService.getAllNotificationsStream().listen((notifications) {
//       setState(() {
//         // Check if we have new notifications
//         if (_previousCount > 0 && notifications.length > _previousCount) {
//           _showNewNotificationAlert();
//         }
//         _previousCount = notifications.length;
//         _notifications = notifications;
//       });
//     });
//   }
//
//   void _showNewNotificationAlert() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Text('New notification received!'),
//         backgroundColor: Colors.green,
//         duration: const Duration(seconds: 3),
//         action: SnackBarAction(
//           label: 'View',
//           onPressed: () {
//             // Navigate to notifications view or expand notifications panel
//           },
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<HomeCubit,HomeState>(
//       listener: (context, state) {
//
//       },
//       builder: (context, state) {
//         if (state is FetchingNotificationState) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is FetchingNotificationSuccessState) {
//           final List<NotificationModel> notifications = HomeCubit.adminNotifications.reversed.toList();
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const VerticalSpacer(space: 16),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width*0.7,
//                   child: const Center(
//                     child: Text(
//                       'Notifications',
//                       style:
//                       TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//                   ),
//                 ),
//                 const VerticalSpacer(space: 20),
//                 HomeCubit.adminNotifications.isNotEmpty?
//                   Expanded(
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width*0.7,
//                     child: ListView.builder(
//                       itemCount: _notifications.length,
//                       itemBuilder: (context, index) {
//                         return NotificationItem(
//                         notificationTitle: notifications[index].title,
//                         notificationDate: notifications[index].date.toString(),
//                         notificationBody: notifications[index].body,
//                         offerSupplierId: notifications[index].offerSupplierId,
//                         offerId: notifications[index].offerId,
//                         orderId: notifications[index].orderId,
//                       );
//                       }
//                     ),
//                   ),
//                 ) :
//                   const Center(child: Text('No Notifications'),),
//               ],
//             ),
//           );
//         } else if (state is FetchingNotificationErrorState) {
//           return Center(child: Text(state.error));
//         }
//         print(state);
//         return Container();
//       },
//     );
//   }
// }
//
// class NotificationItem extends StatelessWidget {
//   const NotificationItem({
//     super.key,
//     required this.notificationTitle,
//     required this.notificationBody,
//     required this.notificationDate,
//     this.offerSupplierId,
//     this.offerId,
//     this.orderId,
//   });
//   final String notificationTitle;
//   final String notificationBody;
//   final String notificationDate;
//   final String? offerSupplierId;
//   final String? offerId;
//   final String? orderId;
//   @override
//   Widget build(BuildContext context) {
//     print(notificationBody);
//     print("---------------------------");
//     return Container(
//       width: MediaQuery.of(context).size.width*0.7,
//       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
//       margin: EdgeInsets.only(bottom: 16.h),
//       decoration: BoxDecoration(
//           border: Border.all(color:Colors.grey),
//           borderRadius: BorderRadius.circular(12.r)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           FittedBox(
//             child: Text(
//               notificationTitle,
//               style: const TextStyle(
//                   fontSize: 16, color: Colors.black,),
//             ),
//           ),
//           const VerticalSpacer(space: 8),
//           FittedBox(
//             child: Text(
//               notificationBody,
//               maxLines: 10,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(fontSize: 14, color: Colors.grey),
//             ),
//           ),
//           FittedBox(
//             child: Text(
//               notificationDate,//.split(' ')[0],
//               style: const TextStyle(
//                   fontSize: 14, color: Colors.blue),
//             ),
//           ),
//           // if(offerSupplierId !=null && offerSupplierId!.isNotEmpty)
//           // Row(
//           //   children: [
//           //     BlocProvider(
//           //       create:(context) =>  ServiceLocator.getIt<ChatCubit>(),
//           //       child: ElevatedButton(onPressed: () {
//           //         // context.read<ChatCubit>().messageController.text = ;
//           //         showTermsAndConditionsDialog(context, false,
//           //           offerSupplierId: offerSupplierId,
//           //           offerId: offerId,
//           //           orderId: orderId,
//           //         );
//           //       }, child: Text(S.of(context).accept)
//           //       ),
//           //     ),
//           //   ],
//           // )
//         ],
//       ),
//     );
//   }
// }
// /*
//
// [
// {"title":"Congratulation! accepted Offer","body":"Your offer has been accepted successfully","data":{"date":"2025-1-17 at: 15:37","offerSupplierId":""}},
// {"title":"Congratulation! accepted Offer","body":"Your offer has been accepted successfully","data":{"date":"2025-1-17 at: 16:18","offerSupplierId":""}},
// {"title":"Congratulation! accepted Offer","body":"Your offer has been accepted successfully","data":{"date":"2025-1-25 at: 18:51","offerSupplierId":""}}
// ]
//
//
//   */
