import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rushd/helpers/helper.dart';
import 'package:rushd/models/batch.dart';
import 'package:rushd/models/payment.dart';
import 'package:rushd/widgets/custom_listview_builder.dart';

class ScreenMyPurchase extends StatelessWidget {
  const ScreenMyPurchase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("My Payments"),
    ),
    body: StreamBuilder<QuerySnapshot>(
      stream: paymentRef.where("user_id",isEqualTo: uid).snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState==ConnectionState.waiting) {
          return CircularProgressIndicator.adaptive();
        }
        List<Payment> payments=snapshot.data!.docs.map((e) => Payment.fromMap(e.data()as Map<String,dynamic>)).toList();
      return CustomListviewBuilder( itemCount: payments.length, scrollDirection: CustomDirection.vertical, itemBuilder: (BuildContext context, int index) {

      Payment payment=payments[index];
        return StreamBuilder<DocumentSnapshot>(
          stream: batchesRef.doc(payment.batch_id).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState==ConnectionState.waiting) {
              return Text("");
            }
            Batch batch=Batch.fromMap(snapshot.data!.data() as Map<String,dynamic>);
            return ListTile(
              title: Text(batch.name),
              subtitle: Text(batch.price.toString()),
            );
          }
        );
      },);
    },),
    );
  }
}
