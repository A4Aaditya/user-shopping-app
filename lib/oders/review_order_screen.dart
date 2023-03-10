import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_shop_app/dashboard/dashboard_screen.dart';
import 'package:new_user_shop_app/home/models/product_model.dart';
import 'package:new_user_shop_app/notification/bloc/notification_bloc.dart';
import 'package:new_user_shop_app/oders/bloc/order_bloc.dart';
import 'package:new_user_shop_app/profile/address/address_model.dart';
import 'package:new_user_shop_app/profile/address/bloc/address_bloc.dart';
import 'package:new_user_shop_app/widget/product_card.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ReviewOrderScreen extends StatefulWidget {
  const ReviewOrderScreen({
    super.key,
    required this.products,
  });
  final List<ProductModel> products;

  @override
  State<ReviewOrderScreen> createState() => _ReviewOrderScreenState();
}

class _ReviewOrderScreenState extends State<ReviewOrderScreen> {
  final _razorpay = Razorpay();
  bool isPaymentProcessing = false;
  AddressModel? address;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<OrderBloc>();
    bloc.add(InitiatePayment());
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, placeOrder);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, paymentError);
  }

  @override
  Widget build(BuildContext context) {
    final products = widget.products;
    final amount = products.fold(
      0.0,
      (previousValue, element) => previousValue + element.offerPrice,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Order'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    BlocBuilder<AddressBloc, AddressState>(
                      builder: (context, state) {
                        if (state is AddressSuccessState) {
                          final data = state.data;
                          return DropdownButton(
                            value: address,
                            items: data.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e.shortReadable()),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                address = value;
                              });
                            },
                          );
                        } else {
                          return const Text('No Address Found');
                        }
                      },
                    ),
                    ...products.map((product) {
                      return ProductCard(product: product);
                    }).toList(),
                  ],
                ),
              ),
              BlocConsumer<OrderBloc, OrderState>(
                listener: (context, state) {
                  if (state is OrderErrorState) {
                    showSnackBar(
                      message: state.message,
                      color: Colors.red,
                    );
                  } else if (state is OrdeSuccessState) {
                    context.read<OrderBloc>().add(OrderFetchEvent());
                    final event = SendBookingNotification(state.order);
                    context.read<NotificationBloc>().add(event);
                    showOrderSuccess(context);
                  }
                },
                builder: (context, state) {
                  if (state is OrderLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is PaymentProcessingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () => makePayment(amount),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text('Place Order $amount'),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void showOrderSuccess(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 50,
                    child: Icon(
                      Icons.check,
                      size: 60,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Order Success',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 10),
                Text(
                  'Your order has been succesully placed! We have sent you one confirmation e-mail also',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final route = MaterialPageRoute(
                      builder: (context) => const Dashboard(),
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      route,
                      (route) => false,
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Center(child: Text('Okay')),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void makePayment(double amount) {
    if (address == null) {
      showSnackBar(message: 'Please select a Address', color: Colors.red);
      return;
    }
    final bloc = context.read<OrderBloc>();
    bloc.add(OpenPaymentPage());
    var options = {
      'key': 'rzp_test_cAIoc3NUAOQT6k',
      'amount': (amount * 100).toInt(),
      'name': 'Aditya Kumar',
      'description': 'Order #2134',
      'prefill': {
        'contact': '9934692699',
        'email': 'adityakumarsinghlbh@gmail.com',
      }
    };
    _razorpay.open(options);
  }

  void paymentError(PaymentFailureResponse response) {
    showSnackBar(
      color: Colors.red,
      message: response.message ?? 'Payment Failed',
    );
  }

  void placeOrder(PaymentSuccessResponse response) async {
    final amount = widget.products.fold(
      0.0,
      (previousValue, element) => previousValue + element.offerPrice,
    );
    final payment = {
      'orderId': response.orderId,
      'paymentId': response.paymentId,
      'signature': response.signature,
      'amount': (amount * 100).toInt(),
    };
    final bloc = context.read<OrderBloc>();
    final data = {
      'payment': payment,
      ...body,
    };
    final event = OrderAddEvent(body: data);
    bloc.add(event);
  }

  void showSnackBar({required String message, required Color color}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void navigateToHomeScreen() {
    final route = MaterialPageRoute(builder: (context) {
      return const Dashboard();
    });

    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Map<String, dynamic> get body {
    final item = widget.products.map((e) {
      return e.toMap();
    }).toList();
    final createdBy = FirebaseAuth.instance.currentUser?.uid;
    return {
      'created_by': createdBy,
      'address': address?.toMap(),
      'items': item,
      'order_status': 'CREATED',
      'payment_type': 'COD',
      'updated_at': FieldValue.serverTimestamp(),
      'created_at': FieldValue.serverTimestamp(),
    };
  }
}
