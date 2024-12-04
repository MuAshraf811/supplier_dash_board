part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class ChangingSideBarState extends HomeState{} 
final class FetchingAllUsersState extends HomeState{} 
final class FetchingAllUsersSuccessState extends HomeState{} 
final class FetchingAllUsersErrorState extends HomeState{ 
  final String error;

  FetchingAllUsersErrorState({required this.error}); 

} 

final class FetchingClientOrdersState extends HomeState{} 
final class FetchingClientOrdersSuccessState extends HomeState{} 
final class FetchingClientOrdersErrorState extends HomeState{ 
  final String error;

  FetchingClientOrdersErrorState({required this.error}); 

}  


final class AcceptedOrderSuccessfullState extends HomeState{} 
final class AcceptedOrderErrorState extends HomeState{}