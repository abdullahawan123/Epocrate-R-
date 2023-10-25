import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rushd/helpers/helper.dart';
import 'package:rushd/helpers/style.dart';
import 'package:rushd/view/layouts/item_course_card.dart';
import 'package:sizer/sizer.dart';

import '../../models/batch.dart';

class LayoutSearch extends StatefulWidget {
  const LayoutSearch({Key? key}) : super(key: key);

  @override
  _LayoutSearchState createState() => _LayoutSearchState();
}

class _LayoutSearchState extends State<LayoutSearch> {
  TextEditingController _searchController = TextEditingController();
  List<Batch> filteredBatches = [];
  List<Batch> allBatches = [];

  @override
  void initState() {
    super.initState();
    fetchBatches();
  }

  Future<void> fetchBatches() async {
    final querySnapshot = await batchesRef.get();
    setState(() {
      allBatches = querySnapshot.docs.map((doc) => Batch.fromMap(doc.data() as Map<String, dynamic>)).toList();
      filteredBatches = List.from(allBatches); // Set filteredBatches to allBatches initially
    });
  }
  bool _activeOnly = false; // Define this variable
  bool _completedOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          Text("Search", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 1.h),
          Container(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _onSearchTextChanged(value); // Pass activeOnly and completedOnly
              },
              obscureText: false,
              decoration: InputDecoration(
                hintText: "Search Course",
                hintStyle: TextStyle(color: appTextColor),
                prefixIcon: Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Text("Search Results", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 2.h),
          Expanded(
            child:(filteredBatches.isEmpty)?Center(child: Text("No Course Found")): ListView.builder(
              itemCount: filteredBatches.length,
              itemBuilder: (context, index) {
                final batch = filteredBatches[index];
                return ItemCourseCard(batch: batch);
              },
            ),
          ),
        ],
      ).paddingAll(12.sp),
    );
  }
  // void _onSearchTextChanged(String searchText, bool activeOnly, bool completedOnly) {
  //   setState(() {
  //     filteredBatches = allBatches.where((batch) {
  //       final nameMatches = batch.name.toLowerCase().contains(searchText.toLowerCase());
  //       final isActive = batch.status == "Active";
  //       final isCompleted = batch.status == "Completed";
  //
  //       // Apply additional filters
  //       if (activeOnly && !isActive) {
  //         return false;
  //       }
  //       if (completedOnly && !isCompleted) {
  //         return false;
  //       }
  //
  //       return nameMatches;
  //     }).toList();
  //   });
  // }
  void _onSearchTextChanged(String searchText) {
    setState(() {
      filteredBatches = allBatches.where((batch) {
        final nameMatches = batch.name.toLowerCase().contains(searchText.toLowerCase());
        final isActive = batch.status == "Active";
        final isCompleted = batch.status == "Completed";

        // Apply additional filters
        if (_activeOnly && !isActive) {
          return false;
        }
        if (_completedOnly && !isCompleted) {
          return false;
        }

        return nameMatches;
      }).toList();
    });
  }
}
