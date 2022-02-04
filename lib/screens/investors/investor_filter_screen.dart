// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_filter_controller.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_global_controller.dart';
import 'package:startupfunding/screens/investors/investor_home_screen.dart';

class InvestorFilterScreen extends StatefulWidget {
  const InvestorFilterScreen({Key? key}) : super(key: key);

  @override
  _InvestorFilterScreenState createState() => _InvestorFilterScreenState();
}

class _InvestorFilterScreenState extends State<InvestorFilterScreen> {
  late List<Object?> filterApplied = [];
  List<MultiSelectItem<String>> filterOptions = [
    MultiSelectItem("Advertising", "Advertising"),
    MultiSelectItem("Aerospace", "Aerospace"),
    MultiSelectItem("Agriculture", "Agriculture"),
    MultiSelectItem("AI", "AI"),
    MultiSelectItem(
      "Analytics",
      "Analytics",
    ),
    MultiSelectItem("AR/VR", "AR/VR"),
    MultiSelectItem("Architecture", "Architecture"),
    MultiSelectItem("Art & Photography", "Art & Photography"),
    MultiSelectItem("Automative", "Automative"),
    MultiSelectItem("Beauty", "Beauty"),
    MultiSelectItem("Big Data", "Big Data"),
    MultiSelectItem("Blockchain", "Blockchain"),
    MultiSelectItem("Careers", "Careers"),
    MultiSelectItem("Communication", "Communication"),
    MultiSelectItem("Computer Vision", "Computer Vision"),
    MultiSelectItem("Construction", "Construction"),
    MultiSelectItem("Consumer Goods", "Consumer Goods"),
    MultiSelectItem("Dating/Matrimonial", "Dating/Matrimonial"),
    MultiSelectItem("Defence", "Defence"),
    MultiSelectItem("Design", "Design"),
    MultiSelectItem("Education", "Education"),
    MultiSelectItem("Energy & Sustainability", "Energy & Sustainability"),
    MultiSelectItem("Enterprise Software", "Enterprise Software"),
    MultiSelectItem("Events", "Events"),
    MultiSelectItem("Fashion", "Fashion"),
    MultiSelectItem("FinTech", "FinTech"),
    MultiSelectItem("Food & Beverages", "Food & Beverages"),
    MultiSelectItem("Gaming", "Gaming"),
    MultiSelectItem("Gifting", "Gifting"),
    MultiSelectItem("Grocery", "Grocery"),
    MultiSelectItem("Hardware", "Hardware"),
    MultiSelectItem("Healthcare", "Healthcare"),
    MultiSelectItem("Human Resources", "Human Resources"),
    MultiSelectItem("Information/Tech", "Information/Tech"),
    MultiSelectItem("Internet of Things", "Internet of Things"),
    MultiSelectItem("IT Services", "IT Services"),
    MultiSelectItem("Legal", "Legal"),
    MultiSelectItem("Logistics", "Logistics"),
    MultiSelectItem("Manufacturing", "Manufacturing"),
    MultiSelectItem("Marketing", "Marketing"),
    MultiSelectItem("Media & Entertainment", "Media & Entertainment"),
    MultiSelectItem("Nanotechnology", "Nanotechnology"),
    MultiSelectItem("Networking", "Networking"),
    MultiSelectItem("Pets & Animals", "Pets & Animals"),
    MultiSelectItem("Printing", "Printing"),
    MultiSelectItem("Real Estate", "Real Estate"),
    MultiSelectItem("Retail", "Retail"),
    MultiSelectItem("Robotics", "Robotics"),
    MultiSelectItem("Safety", "Safety"),
    MultiSelectItem("Security", "Security"),
    MultiSelectItem("Services", "Services"),
    MultiSelectItem("Social Impact", "Social Impact"),
    MultiSelectItem("Social Network", "Social Network"),
    MultiSelectItem("Sports", "Sports"),
    MultiSelectItem("Storage", "Storage"),
    MultiSelectItem("Transportation", "Transportation"),
    MultiSelectItem("Travel & Tourism", "Travel & Tourism"),
  ];

  final InvestorFilterController investorFilterController =
      Get.put(InvestorFilterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Filter",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: "Cabin",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text(
              "Filter based on your expertise",
              style: TextStyle(
                fontFamily: "Cabin",
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MultiSelectDialogField(
                items: filterOptions,
                title: Text(
                  "Select",
                  style: TextStyle(
                      fontFamily: "Cabin", fontSize: 18, color: Colors.black),
                ),
                selectedColor: Theme.of(context).primaryColor,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                onConfirm: (results) {
                  investorFilterController.selectedFilters.value = results;
                },
                initialValue: investorFilterController.selectedFilters.value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 40,
                width: 230,
                child: ElevatedButton(
                  child: Text(
                    'Apply Filter',
                    style: TextStyle(fontFamily: "Cabin", fontSize: 18),
                  ),
                  onPressed: () {
                    Get.find<InvestorFilterController>().isFilterApplied.value =
                        true;
                    Get.find<InvestorGlobalController>().startupsList = [];
                    Get.find<InvestorGlobalController>().hasMoreData = true;
                    Get.find<InvestorGlobalController>().lastUser = null;
                    Get.find<InvestorGlobalController>().getStartupsForFeed();
                    Get.to(InvestorHomeScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 40,
                width: 230,
                child: ElevatedButton(
                  child: Text(
                    'Clear all Filters',
                    style: TextStyle(
                        fontFamily: "Cabin",
                        fontSize: 18,
                        color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Get.find<InvestorFilterController>().isFilterApplied.value =
                        false;
                    Get.find<InvestorGlobalController>().startupsList = [];
                    Get.find<InvestorGlobalController>().hasMoreData = true;
                    Get.find<InvestorGlobalController>().lastUser = null;

                    Get.find<InvestorGlobalController>().getStartupsForFeed();
                    Get.find<InvestorFilterController>().selectedFilters.value =
                        [];
                    Get.to(InvestorHomeScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
