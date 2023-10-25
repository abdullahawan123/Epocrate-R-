import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../helpers/helper.dart';

class CartItem {
  final String courseId;
  final String courseName;
  final double price;

  CartItem({
    required this.courseId,
    required this.courseName,
    required this.price,
  });
}

class CartScreen extends StatefulWidget {


  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CollectionReference usersRef = FirebaseFirestore.instance.collection("users");
  final CollectionReference coursesRef = FirebaseFirestore.instance.collection("courses");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersRef.doc(uid).collection("cart").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<CartItem> cartItems = snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return CartItem(
              courseId: data['courseId'],
              courseName: data['courseName'],
              price: data['price'],
            );
          }).toList();

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              CartItem cartItem = cartItems[index];

              return ListTile(
                title: Text(cartItem.courseName),
                subtitle: Text("Price: \$${cartItem.price.toStringAsFixed(2)}"),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    removeFromCart(cartItem.courseId);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void removeFromCart(String courseId) {
    // Remove the course from the cart
    usersRef.doc(uid).collection("cart").doc(courseId).delete().then((_) {
      // Update the UI or show a success message
      setState(() {
        // Cart item removed
      });
    });
  }

}


