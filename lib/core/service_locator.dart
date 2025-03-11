
import 'package:dash_board/notifications/presentation/cubit/notification_cubit.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  static GetIt getIt = GetIt.instance;

  static void setObjects() {


    getIt.registerSingleton<NotificationsCubit>(
          NotificationsCubit(),
    );
  }
}
