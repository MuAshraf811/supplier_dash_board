import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_board/home/model/orders_model.dart';
import 'package:dash_board/home/model/users_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  late List<UsersModel> users; 
    late List<OrdersModel> allOrders;

  int sideBarIndex = 0;
  void changeViewonSideBar({required int index}) {
    sideBarIndex = index;
    emit(ChangingSideBarState());
  }  

void deletSpacificOrder({required String id})async{  
  
    final instance = FirebaseFirestore.instance.collection("Users"); 
  await instance.doc(id).delete(); 
   fetchClientOrders();
 
   
 } 
 void acceptSpacificOrder({required String id})async{  
  
    final instance = FirebaseFirestore.instance.collection("Users"); 
  await instance.doc(id).delete(); 
   fetchClientOrders();
 
   
 }
  void fetchClientOrders() async {
    try {
      emit(FetchingClientOrdersState());
      final instance = FirebaseFirestore.instance.collection("Orders");
      final querySnapshot = await instance.get();
      allOrders =
          querySnapshot.docs.map((e) => OrdersModel.fromMap({
        ...e.data(),  // Spread the existing data
        'orderId': e.id, // Add docId to the data map
      })).toList();
      emit(FetchingClientOrdersSuccessState());
    } catch (e) { 
      log("**************************"); 
      log(e.toString());
      emit(FetchingClientOrdersErrorState(error: e.toString()));
    }
  }




void deletUser({required String id})async{  
  
    final instance = FirebaseFirestore.instance.collection("Users"); 
  await instance.doc(id).delete(); 
   fetchUsers();
 
   
 }
  void fetchUsers() async {
    try {
      emit(FetchingAllUsersState());
      final instance = FirebaseFirestore.instance.collection("Users");
      final querySnapshot = await instance.get();
      users =
          querySnapshot.docs.map((e) => UsersModel.fromMap({
        ...e.data(),  // Spread the existing data
        'docId': e.id, // Add docId to the data map
      })).toList();
      emit(FetchingAllUsersSuccessState());
    } catch (e) { 
      log("**************************"); 
      log(e.toString());
      emit(FetchingAllUsersErrorState(error: e.toString()));
    }
  }
}
