import 'package:advmobprog_midterms_tp03_amarille/model/add_ons.dart';
import 'package:advmobprog_midterms_tp03_amarille/model/cake.dart';
import 'package:advmobprog_midterms_tp03_amarille/model/cake_size.dart';
import 'package:advmobprog_midterms_tp03_amarille/model/payment_option.dart';

class Order {
  final String id;
  final String recipient;
  final String dedication;
  final String deliveryAddress;
  final Cake cake;
  final CakeSize size;
  final DateTime deliveryDay;
  final PaymentOption paymentOption;
  final List<AddOns> addOns;
  final double total;

  const Order({
    required this.id,
    required this.recipient,
    required this.dedication,
    required this.deliveryAddress,
    required this.cake,
    required this.size,
    required this.deliveryDay,
    required this.paymentOption,
    required this.addOns,
    required this.total,
  });
}
