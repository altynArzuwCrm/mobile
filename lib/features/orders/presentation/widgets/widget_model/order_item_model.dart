import 'package:flutter/material.dart';

class OrderItemModel {
  final TextEditingController productCtrl;
  final TextEditingController countCtrl;
  final TextEditingController priceCtrl;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime? deadline;
  String? selectedProductId;


  OrderItemModel({
    String? initialProduct,
    String? initialCount,
    String? initialPrice,
    this.deadline,
    this.selectedProductId,
  })  : productCtrl = TextEditingController(text: initialProduct),
        countCtrl = TextEditingController(text: initialCount),
        priceCtrl = TextEditingController(text: initialPrice);

  @override
  String toString() {
    return 'OrderItemModel{productCtrl: ${productCtrl.text}, countCtrl: ${countCtrl.text}, priceCtrl: ${priceCtrl.text}, deadline: $deadline, selectedProductId: $selectedProductId}';
  }
  Map<String, dynamic> toJson() {
    return {
      'product_id': selectedProductId ,
      'count': int.tryParse(countCtrl.text) ?? 0,
      'price': double.tryParse(priceCtrl.text) ?? 0.0,
      'deadline': deadline?.toIso8601String(),
    };
  }

}

