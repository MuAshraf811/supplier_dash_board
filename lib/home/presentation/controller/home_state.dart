part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ChangingSideBarState extends HomeState {}

final class FetchingAllUsersState extends HomeState {}

final class FetchingAllUsersSuccessState extends HomeState {}

final class FetchingAllUsersErrorState extends HomeState {
  final String error;

  FetchingAllUsersErrorState({required this.error});
}

final class FetchingClientOrdersState extends HomeState {}

final class FetchingClientOrdersSuccessState extends HomeState {}

final class FetchingClientOrdersErrorState extends HomeState {
  final String error;

  FetchingClientOrdersErrorState({required this.error});
}

final class FetchingSupplierOffersState extends HomeState {}

final class FetchingSupplierOffersSuccessState extends HomeState {}

final class FetchinSupplierOffersErrorState extends HomeState {
  final String error;

  FetchinSupplierOffersErrorState({required this.error});
}

final class FetchingClientAcceptedOrdersState extends HomeState {}

final class FetchingClientAcceptedOrdersSuccessState extends HomeState {}

final class FetchingClientAcceptedOrdersErrorState extends HomeState {
  final String error;

  FetchingClientAcceptedOrdersErrorState({required this.error});
}

final class AcceptedOrderSuccessfullState extends HomeState {}

final class AcceptedOrderErrorState extends HomeState {}

final class FetchingAllSuppliersState extends HomeState {}

final class FetchingAllSuppliersSuccessState extends HomeState {}

final class FetchingAllSuppliersErrorState extends HomeState {
  final String error;

  FetchingAllSuppliersErrorState({required this.error});
}

final class FetchingSupplierAcceptedOffersState extends HomeState {}

final class FetchingSupplierAcceptedOffersSuccessState extends HomeState {}

final class FetchingSupplierAcceptedOffersErrorState extends HomeState {
  final String error;

  FetchingSupplierAcceptedOffersErrorState({required this.error});
}

final class FetchingClientApprovalsState extends HomeState {}

final class FetchingClientApprovalsSuccessState extends HomeState {}

final class FetchingClientApprovalsErrorState extends HomeState {
  final String error;

  FetchingClientApprovalsErrorState({required this.error});
}
final class FetchingNotificationState extends HomeState{}
final class FetchingNotificationSuccessState extends HomeState{}
final class EmptyNotificationsState extends HomeState{}
class FetchingNotificationErrorState extends HomeState {
  final String error;
  FetchingNotificationErrorState(this.error);
}