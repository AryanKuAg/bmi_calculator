import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:toast/toast.dart';

final String testID = 'donation_iap';

const bool kAutoConsume = true;

const List<String> _kProductIds = <String>['donate_iap'];

class MyDonation extends StatefulWidget {
  @override
  _MyDonationState createState() => _MyDonationState();
}

class _MyDonationState extends State<MyDonation> {
  final InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  bool _purchasePending = false;
  bool _loading = true;

  @override
  void initState() {
    Stream purchaseUpdated =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {});
    initStoreInfo();
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _connection.isAvailable();
    if (!isAvailable) {
      setState(() {
        _products = [];
        _purchases = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    ProductDetailsResponse productDetailsResponse =
        await _connection.queryProductDetails(_kProductIds.toSet());
    if (productDetailsResponse.error != null ||
        productDetailsResponse.productDetails.isEmpty) {
      setState(() {
        _products = productDetailsResponse.productDetails;
        _purchases = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final QueryPurchaseDetailsResponse purchaseResponse =
        await _connection.queryPastPurchases();
    if (purchaseResponse.error != null) {}
    final List<PurchaseDetails> verifiedPurchases = [];
    for (PurchaseDetails purchase in purchaseResponse.pastPurchases) {
      if (await _verifyPurchase(purchase)) {
        verifiedPurchases.add(purchase);
      }
    }

    setState(() {
      _products = productDetailsResponse.productDetails;
      _purchases = verifiedPurchases;
      _purchasePending = false;
      _loading = false;
    });
  }

  Card _buildProductList() {
    if (_loading) {
      return Card(
        child: ListTile(
          leading: CircularProgressIndicator(),
          title: Text('Fetching products...'),
        ),
      );
    }

    List<ListTile> productList = <ListTile>[];

    Map<String, PurchaseDetails> purchases =
        Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));
    productList.addAll(_products.map((ProductDetails productDetails) {
      PurchaseDetails previousPurchase = purchases[productDetails.id];
      return ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(productDetails.title),
        subtitle: Text(productDetails.description),
        trailing: FlatButton(
          child: Text(productDetails.price),
          color: Colors.green[800],
          textColor: Colors.white,
          onPressed: () {
            PurchaseParam purchaseParam = PurchaseParam(
                productDetails: productDetails,
                applicationUserName: null,
                sandboxTesting: true);
            _connection.buyConsumable(
                purchaseParam: purchaseParam,
                autoConsume: kAutoConsume || Platform.isIOS);
          },
        ),
      );
    }));

    return Card(
        child: Column(
      children: <Widget>[] + productList,
    ));
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    return Future<bool>.value(true);
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error);
          //show toast
          Toast.show('Purchase Error!', context);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            //toast
            Toast.show('Donation Complete, Thank you!', context, duration: 6);
          } else {
            // handleI(purchaseDetails);
            return;
          }
        }
        if (Platform.isAndroid) {
          await InAppPurchaseConnection.instance
              .consumePurchase(purchaseDetails);
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchaseConnection.instance
              .completePurchase(purchaseDetails);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.monetization_on),
        ),
        title: Text('Donation'),
      ),
      body: _buildProductList(),
    );
  }
}
