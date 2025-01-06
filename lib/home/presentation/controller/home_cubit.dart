import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_board/core/fcm_handler.dart';
import 'package:dash_board/home/model/accepted_orders_model.dart';
import 'package:dash_board/home/model/offers_model.dart';
import 'package:dash_board/home/model/orders_model.dart';
import 'package:dash_board/home/model/supplier_model.dart';
import 'package:dash_board/home/model/users_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  late List<UsersModel> users;
  late List<SupplierModel> suppliers;
  late List<OrdersModel> allOrders;
  late List<OffersModel> allOffers;
  late List<OffersModel> allAcceptedOffers;

  late List<AcceptedOrdersModel> allAcceptedOrders;

  int sideBarIndex = 0;
  void changeViewonSideBar({required int index}) {
    sideBarIndex = index;
    emit(ChangingSideBarState());
  }

  void deletSpacificOffer(
      {required String id, required String collection}) async {
    final instance = FirebaseFirestore.instance.collection(collection);
    await instance.doc(id).delete();
    collection == "quotations"
        ? fetchSupplierOffers()
        : fetchClientAcceptedOrders();
  }

  void fetchClientAcceptedOfferss() async {
    try {
      emit(FetchingSupplierAcceptedOffersState());
      final instance = FirebaseFirestore.instance.collection("accepted_offers");
      final querySnapshot = await instance.get();
      allAcceptedOffers = querySnapshot.docs
          .map((e) => OffersModel.fromMap({
                ...e.data(), // Spread the existing data
                'offerId': e.id, // Add docId to the data map
              }))
          .toList();

      emit(FetchingSupplierAcceptedOffersSuccessState());
    } catch (e) {
      log("**************************");
      log(e.toString());
      emit(FetchingSupplierAcceptedOffersErrorState(error: e.toString()));
    }
  }

  void acceptSpacificOffer({required OffersModel offer}) async {
    try {
      final instance = FirebaseFirestore.instance.collection("accepted_offers");
      await instance.add({
        'quotationDescription': offer.offerDescription,
        'quotationDate': offer.offerDate,
        'supplierName': offer.supplierName,
        'supplierId': offer.supplierId,
        'rate': offer.rate,
        'quantity': offer.quantity,
        'orderNumber': offer.orderNumber,
        'amount': offer.amount,
        'email': offer.emial,
        'mobile': offer.mobile,
        'city': offer.city
      });
      await FirebaseFirestore.instance
          .collection("quotation")
          .doc(offer.offerId)
          .delete();
      fetchSupplierOffers();
    } catch (e) {
      emit(FetchinSupplierOffersErrorState(error: e.toString()));
    }
  }

  void fetchSupplierOffers() async {
    try {
      emit(FetchingSupplierOffersState());
      final instance = FirebaseFirestore.instance.collection("quotations");
      final querySnapshot = await instance.get();
      allOffers = querySnapshot.docs
          .map((e) => OffersModel.fromMap({
                ...e.data(), // Spread the existing data
                'offerId': e.id, // Add docId to the data map
              }))
          .toList();
      log("**************************");
      log(allOffers.length.toString());
      emit(FetchingSupplierOffersSuccessState());
    } catch (e) {
      log("**************************");
      log(e.toString());
      emit(FetchinSupplierOffersErrorState(error: e.toString()));
    }
  }

  void deletSpacificOrder(
      {required String id, required String collection}) async {
    final instance = FirebaseFirestore.instance.collection(collection);
    await instance.doc(id).delete();
    collection == "Orders" ? fetchClientOrders() : fetchClientAcceptedOrders();
  }

  void acceptSpacificOrder({required OrdersModel order}) async {
    try {
      final instance = FirebaseFirestore.instance.collection("accepted_orders");
      await instance.add({
        'details': order.details,
        'extra_etails': order.extea_details,
        'date': order.date,
        'category': order.category,
        'orderType': order.orderType,
        'userId': order.userId,
        'orderId': order.orderId,
        'name': order.name,
        'address': order.address,
        'mobile': order.mobile,
        'email': order.email
      });
      await FirebaseFirestore.instance
          .collection("Orders")
          .doc(order.orderId)
          .delete();
      fetchClientOrders();
      FCMHandler.sendNotification(
          "fGDlT9IsZk4duMkTF1FDBJ:APA91bHlWJD0Pingyiu9tRdzEd7PL4DD_5UM37IqZzSNooGyM4cCScbMQ66coIsrWy7qfTRPxpegEx-g76OCgZb2MMIKvYy6xP3k2VTzxtbA7ip8qpXlVZk",
          "Congratulation! accepted Order/Offer",
          "Your order/offer has been accepted successfully");
      emit(AcceptedOrderSuccessfullState());
    } catch (e) {
      AcceptedOrderErrorState();
    }
  }

  void fetchClientOrders() async {
    try {
      emit(FetchingClientOrdersState());
      final instance = FirebaseFirestore.instance.collection("Orders");
      final querySnapshot = await instance.get();
      allOrders = querySnapshot.docs
          .map((e) => OrdersModel.fromMap({
                ...e.data(), // Spread the existing data
                'orderId': e.id, // Add docId to the data map
              }))
          .toList();
      log("**************************");
      log(allOrders.length.toString());
      emit(FetchingClientOrdersSuccessState());
    } catch (e) {
      log("**************************");
      log(e.toString());
      emit(FetchingClientOrdersErrorState(error: e.toString()));
    }
  }

  void fetchClientAcceptedOrders() async {
    try {
      emit(FetchingClientAcceptedOrdersState());
      final instance = FirebaseFirestore.instance.collection("accepted_orders");
      final querySnapshot = await instance.get();
      allAcceptedOrders = querySnapshot.docs
          .map((e) => AcceptedOrdersModel.fromMap({
                ...e.data(), // Spread the existing data
                'orderId': e.id, // Add docId to the data map
              }))
          .toList();

      emit(FetchingClientAcceptedOrdersSuccessState());
    } catch (e) {
      log("**************************");
      log(e.toString());
      emit(FetchingClientAcceptedOrdersErrorState(error: e.toString()));
    }
  }

  void deletUser({required String id}) async {
    final instance = FirebaseFirestore.instance.collection("Users");
    await instance.doc(id).delete();
    fetchUsers();
  }

  void fetchUsers() async {
    try {
      emit(FetchingAllUsersState());
      final instance = FirebaseFirestore.instance.collection("Users");
      final querySnapshot = await instance.get();
      users = querySnapshot.docs
          .map((e) => UsersModel.fromMap({
                ...e.data(), // Spread the existing data
                'docId': e.id, // Add docId to the data map
              }))
          .toList();
      emit(FetchingAllUsersSuccessState());
    } catch (e) {
      log("**************************");
      log(e.toString());
      emit(FetchingAllUsersErrorState(error: e.toString()));
    }
  }

  void fetchSuppliers() async {
    try {
      emit(FetchingAllSuppliersState());
      final instance = FirebaseFirestore.instance.collection("Suppliers");
      final querySnapshot = await instance.get();
      suppliers = querySnapshot.docs
          .map((e) => SupplierModel.fromMap({
                ...e.data(), // Spread the existing data
                'docId': e.id, // Add docId to the data map
              }))
          .toList();
      emit(FetchingAllSuppliersSuccessState());
    } catch (e) {
      log("**************************");
      log(e.toString());
      emit(FetchingAllSuppliersErrorState(error: e.toString()));
    }
  }
}
