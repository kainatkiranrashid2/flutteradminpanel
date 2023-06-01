import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final int id;
  final int customerId;
  final List<int> productIds;
  final double deliveryFee;
  final double subTotal;
  final double total;
  final bool isAccepted;
  final bool isDelivered;
  final bool isCancelled;
  final DateTime createdAt;

  const Order(
      {required this.id,
      required this.customerId,
      required this.productIds,
      required this.deliveryFee,
      required this.subTotal,
      required this.total,
      required this.isAccepted,
      required this.isDelivered,
      required this.isCancelled,
      required this.createdAt});

  Order copyWith({
    int? id,
    int? customerId,
    List<int>? productIds,
    double? deliveryFee,
    double? subTotal,
    double? total,
    bool? isAccepted,
    bool? isDelivered,
    bool? isCancelled,
    DateTime? createdAt,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      productIds: productIds ?? this.productIds,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      subTotal: subTotal ?? this.subTotal,
      total: total ?? this.total,
      isAccepted: isAccepted ?? this.isAccepted,
      isDelivered: isDelivered ?? this.isDelivered,
      isCancelled: isCancelled ?? this.isCancelled,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'productIds': productIds,
      'deliveryFee': deliveryFee,
      'subtotal': subTotal,
      'total': total,
      'isAccepted': isAccepted,
      'isDelivered': isDelivered,
      'isCancelled': isCancelled,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Order.fromSnapshot(DocumentSnapshot snap) {
      Timestamp timestamp = snap.get('createdAt') as Timestamp;

    print(snap);
    return Order(
      id: snap.get('id'),
      customerId: snap.get('customerId'),
      productIds: List<int>.from(snap.get('productIds')),
      deliveryFee: snap.get('deliveryFee'),
      subTotal: snap.get('subTotal'),
      total: snap.get('total'),
      isAccepted: snap.get('isAccepted'),
      isDelivered: snap.get('isDelivered'),
      isCancelled: snap.get('isCancelled'),
      createdAt: timestamp.toDate(),
    );
  }
  String toJson() => json.encode(toMap());

  @override
  List<Object> props() {
    return [
      id,
      customerId,
      productIds,
      deliveryFee,
      subTotal,
      total,
      isAccepted,
      isCancelled,
      isDelivered,
      createdAt,
    ];
  }

  static List<Order> orders = [
    Order(
      id: 1,
      customerId: 2345,
      productIds: const [1, 2],
      deliveryFee: 10,
      subTotal: 20,
      total: 30,
      isAccepted: false,
      isDelivered: false,
      isCancelled: false,
      createdAt: DateTime.now(),
    ),
    Order(
      id: 2,
      customerId: 23,
      productIds: const [1, 2, 3],
      deliveryFee: 10,
      subTotal: 30,
      total: 30,
      isAccepted: false,
      isCancelled: false,
      isDelivered: false,
      createdAt: DateTime.now(),
    ),
  ];
}
