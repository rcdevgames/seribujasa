import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:seribujasa/model/area_dropdown_model.dart';
import 'package:seribujasa/model/country_dropdown_model.dart';
import 'package:seribujasa/model/states_dropdown_model.dart';
import 'package:seribujasa/view/utils/others_helper.dart';

class CountryStatesService with ChangeNotifier {
  var countryDropdownList = [];
  var countryDropdownIndexList = [];
  var selectedCountry;
  var selectedCountryId;

  var statesDropdownList = [];
  var statesDropdownIndexList = [];
  var selectedState;
  var selectedStateId;

  var areaDropdownList = [];
  var areaDropdownIndexList = [];
  var selectedArea;
  var selectedAreaId;

  bool isLoading = false;

  setCountryValue(value) {
    selectedCountry = value;
    notifyListeners();
  }

  setStatesValue(value) {
    selectedState = value;
    notifyListeners();
  }

  setAreaValue(value) {
    selectedArea = value;
    notifyListeners();
  }

  setSelectedCountryId(value) {
    selectedCountryId = value;
    print('selected country id $value');
    notifyListeners();
  }

  setSelectedStatesId(value) {
    selectedStateId = value;
    print('selected state id $value');
    notifyListeners();
  }

  setSelectedAreaId(value) {
    selectedAreaId = value;
    print('selected area id $value');
    notifyListeners();
  }

  setLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  // makeAreaListEmpty(){

  // }

  fetchCountries() async {
    if (countryDropdownList.isEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setLoadingTrue();
      });
      var response = await http.get(Uri.parse('$baseApi/country'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = CountryDropdownModel.fromJson(jsonDecode(response.body));
        for (int i = 0; i < data.countries.length; i++) {
          countryDropdownList.add(data.countries[i].country);
          countryDropdownIndexList.add(data.countries[i].id);
        }

        selectedCountry = data.countries[0].country;
        selectedCountryId = data.countries[0].id;
        notifyListeners();
        fetchStates(selectedCountryId);
      } else {
        //error fetching data
        countryDropdownList = [];
        notifyListeners();
      }
    } else {
      //country list already loaded from api
    }
  }

  fetchStates(countryId) async {
    //make states list empty first
    statesDropdownList = [];
    statesDropdownIndexList = [];
    notifyListeners();

    var response = await http.get(Uri.parse('$baseApi/country/service-city/$countryId'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = StatesDropdownModel.fromJson(jsonDecode(response.body));
      for (int i = 0; i < data.serviceCities.length; i++) {
        statesDropdownList.add(data.serviceCities[i].serviceCity);
        statesDropdownIndexList.add(data.serviceCities[i].id);
      }

      selectedState = data.serviceCities[0].serviceCity;
      selectedStateId = data.serviceCities[0].id;
      notifyListeners();
      fetchArea(countryId, selectedStateId);
    } else {
      //error fetching data
      statesDropdownList = [];
      notifyListeners();
    }
  }

  fetchArea(countryId, stateId) async {
    //make states list empty first
    areaDropdownList = [];
    areaDropdownIndexList = [];
    notifyListeners();

    var response = await http.get(Uri.parse('$baseApi/country/service-city/service-area/$countryId/$stateId'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = AreaDropdownModel.fromJson(jsonDecode(response.body));
      for (int i = 0; i < data.serviceAreas.length; i++) {
        areaDropdownList.add(data.serviceAreas[i].serviceArea);
        areaDropdownIndexList.add(data.serviceAreas[i].id);
      }

      selectedArea = data.serviceAreas[0].serviceArea;
      selectedAreaId = data.serviceAreas[0].id;
      notifyListeners();
    } else {
      //error fetching data
      areaDropdownList = [];
      notifyListeners();
    }
  }
}
