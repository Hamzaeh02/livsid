import 'package:get/get.dart';
import 'package:flutter/material.dart';

class WelcomeControllers extends GetxController {
  var selectedIndex = 0.obs;
  var currentQuery = "".obs;
  var isSearching = false.obs;

  var nearbyOffers = <Map<String, dynamic>>[
    {
      "name": "Bistro & Market",
      "location": "Mission Beach",
      "time": "Open until 9:00 PM",
      "rating": "4.5 Rating",
      "description": "Crispy fried chicken & zinger burgers.",
      "price": "low",
      "category": "deal",
      "image1": "assets/png/searchscreenimg.png",
      "image2": "assets/png/foodimg4.png",
      "image3": "assets/png/foodimg3.png",
    },
    {
      "name": "Sweet Desserts",
      "location": "San Diego",
      "time": "Open until 10:00 PM",
      "rating": "4.7 Rating",
      "description": "Delicious cakes, cupcakes and pastries.",
      "price": "high",
      "category": "nightlife",
      "image1": "assets/png/searchscreenimg.png",
      "image2": "assets/png/foodimg4.png",
      "image3": "assets/png/foodimg3.png",
    },
    {
      "name": "Pizza Corner",
      "location": "La Jolla",
      "time": "Open until 11:00 PM",
      "rating": "4.2 Rating",
      "description": "Hot and cheesy pizzas with fresh ingredients.",
      "price": "low",
      "category": "deal",
      "image1": "assets/png/searchscreenimg.png",
      "image2": "assets/png/foodimg4.png",
      "image3": "assets/png/foodimg3.png",
    },
  ].obs;

  var filteredOffers = <Map<String, dynamic>>[].obs;
  var previousSearches = <String>[].obs;

  /// TextEditingController for search bar
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    filteredOffers.value = nearbyOffers;
  }
  RxString searchText = ''.obs;

  void onSearchChanged(String value) {
    searchText.value = value;

    if (value.isNotEmpty) {
      isSearching.value = true;
    } else {
      isSearching.value = false;
    }
  }

  /// Select filter category
  void selectCategory(int index) {
    selectedIndex.value = index;
    currentQuery.value = "";
    isSearching.value = false;
    searchController.clear(); // clear search bar on category change

    switch (index) {
      case 0:
        filteredOffers.value = nearbyOffers;
        break;
      case 1:
        filteredOffers.value =
            nearbyOffers.where((o) => o["price"] == "low").toList();
        break;
      case 2:
        filteredOffers.value =
            nearbyOffers.where((o) => o["category"] == "deal").toList();
        break;
      case 3:
        filteredOffers.value =
            nearbyOffers.where((o) => o["category"] == "nightlife").toList();
        break;
    }
  }
  var showHistory = false.obs;

  void setShowHistory(bool val) => showHistory.value = val;

  void executeSearch(String query) {
    currentQuery.value = query;
    isSearching.value = true;
    showHistory.value = false; // hide history on search submit

    if(query.trim().isEmpty){
      selectCategory(selectedIndex.value);
      return;
    }

    if(!previousSearches.contains(query.trim())){
      previousSearches.add(query.trim());
    }

    filteredOffers.value = nearbyOffers
        .where((offer) =>
    offer["name"].toLowerCase().contains(query.trim().toLowerCase()) &&
        _matchesCategory(offer))
        .toList();
  }




  /// Search functionality (real-time filter)
  void searchNearby(String query) {
    currentQuery.value = query;
    isSearching.value = true;

    if (query.trim().isEmpty) {
      // reset to selected category if search empty
      filteredOffers.value = _getCategoryOffers();
      return;
    }

    // Filter offers based on query and selected category
    filteredOffers.value = nearbyOffers
        .where(
          (offer) =>
      offer["name"]
          .toLowerCase()
          .contains(query.trim().toLowerCase()) &&
          _matchesCategory(offer),
    )
        .toList();
  }

  bool _matchesCategory(Map<String, dynamic> offer) {
    switch (selectedIndex.value) {
      case 0:
        return true;
      case 1:
        return offer["price"] == "low";
      case 2:
        return offer["category"] == "deal";
      case 3:
        return offer["category"] == "nightlife";
      default:
        return true;
    }
  }

  List<Map<String, dynamic>> _getCategoryOffers() {
    switch (selectedIndex.value) {
      case 0:
        return nearbyOffers;
      case 1:
        return nearbyOffers.where((o) => o["price"] == "low").toList();
      case 2:
        return nearbyOffers.where((o) => o["category"] == "deal").toList();
      case 3:
        return nearbyOffers
            .where((o) => o["category"] == "nightlife")
            .toList();
      default:
        return nearbyOffers;
    }
  }

  /// Clear search input and reset
  void clearSearch() {
    searchController.clear();
    currentQuery.value = "";
    isSearching.value = false;
    filteredOffers.value = _getCategoryOffers();
  }
}
