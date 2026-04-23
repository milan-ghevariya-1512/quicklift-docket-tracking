import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import 'common_widget.dart';

class CustomGooglePlaceAutoCompleteField extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final String googleAPIKey;
  final InputDecoration inputDecoration;
  final TextStyle textStyle;
  final BoxDecoration boxDecoration;
  final bool isLatLngRequired;
  final bool isCrossBtnShown;
  final double containerHorizontalPadding;
  final String language;
  final Widget seperatedBuilder;

  final Function(
      String lat,
      String lng,
      String address,
      String? city,
      String? state,
      String? country,
      String? pincode,
      String? area,
      )? onPlaceSelected;

  const CustomGooglePlaceAutoCompleteField({
    super.key,
    required this.focusNode,
    required this.textEditingController,
    required this.googleAPIKey,
    required this.inputDecoration,
    required this.textStyle,
    required this.boxDecoration,
    this.isLatLngRequired = false,
    this.isCrossBtnShown = true,
    this.containerHorizontalPadding = 0,
    this.language = 'en',
    required this.seperatedBuilder,
    this.onPlaceSelected,
  });

  @override
  State<CustomGooglePlaceAutoCompleteField> createState() =>
      _CustomGooglePlaceAutoCompleteFieldState();
}

class _CustomGooglePlaceAutoCompleteFieldState
    extends State<CustomGooglePlaceAutoCompleteField> {
  List<dynamic> _predictions = [];
  final _uuid = const Uuid();
  String? _sessionToken;
  Timer? _debounce;
  bool isSelected = false;

  void _onTextChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 700), () {
      if (widget.textEditingController.text.length < 4) {
        setState(() {
          _predictions = [];
        });
        return;
      }

      _sessionToken ??= _uuid.v4();

      _getSuggestions(widget.textEditingController.text);
    });
  }

  Future<void> _getSuggestions(String input) async {
    if (isSelected) return;
    final String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json"
        "?input=$input"
        "&key=${widget.googleAPIKey}"
        "&sessiontoken=$_sessionToken"
        "&language=${widget.language}";

    try {
      final response = await http.get(Uri.parse(url));
      logData(
        url: url,
        response: response,
        method: 'GET',
        header: {"Content-Type": "application/json"},
        model: {"input": input},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          setState(() {
            _predictions = data['predictions'];
          });
        } else {
          setState(() {
            _predictions = [];
          });
        }
      } else {
        setState(() {
          _predictions = [];
        });
      }
    } catch (e) {
      log("Error in _getSuggestions: $e");
    }
  }

  Future<void> _getPlaceDetails(String placeId) async {
    if (!widget.isLatLngRequired || _sessionToken == null) return;
    if (isSelected) return;

    final String detailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json"
        "?place_id=$placeId"
        "&key=${widget.googleAPIKey}"
        "&sessiontoken=$_sessionToken"
        "&language=${widget.language}";

    try {
      final response = await http.get(Uri.parse(detailsUrl));
      logData(
        url: detailsUrl,
        response: response,
        method: 'GET',
        header: {"Content-Type": "application/json"},
        model: {"place_id": placeId},
      );

      if (response.statusCode == 200) {
        final details = json.decode(response.body);
        if (details['status'] == 'OK') {
          final location = details['result']['geometry']['location'];
          String lat = location['lat'].toString();
          String lng = location['lng'].toString();
          String address = details['result']['formatted_address'] ?? '';
          String? city, state, country, pincode, area;
          for (var component in details['result']['address_components']) {
            List types = component['types'];

            if (types.contains('locality')) {
              city = component['long_name'];
            }

            if (types.contains('administrative_area_level_1')) {
              state = component['long_name'];
            }

            if (types.contains('country')) {
              country = component['long_name'];
            }

            if (types.contains('postal_code')) {
              pincode = component['long_name'];
            }

            if (types.contains('sublocality') || types.contains('sublocality_level_1')) {
              area = component['long_name'];
            }

            if (city == null && types.contains('administrative_area_level_2')) {
              city = component['long_name'];
            }
          }

          area ??= city;

          print("Lat: $lat, Lng: $lng");
          print("Address: $address");
          print("City: $city, State: $state, Country: $country");
          print("Pincode: $pincode, Area: $area");

          if (widget.onPlaceSelected != null) {
            widget.onPlaceSelected!(
              lat,
              lng,
              address,
              city,
              state,
              country,
              pincode,
              area,
            );
          }
          setState(() {
            isSelected = true;
          });
        }
      }
    } catch (e) {
      log("Error in _getPlaceDetails: $e");
    }
    _sessionToken = null;
  }

  logData({
    required String url,
    required http.Response response,
    required String method,
    model,
    header,
  }) {
    log("url: $url");
    log("model: $model");
    log("status code: ${response.statusCode}");
    log("response: ${response.body}");
    log("method: $method");
    log("header: $header");
  }

  @override
  void initState() {
    super.initState();
    widget.textEditingController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    widget.textEditingController.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: widget.boxDecoration,
          padding:
          EdgeInsets.symmetric(horizontal: widget.containerHorizontalPadding),
          child: Row(
            children: [
              WBox(Get.width*0.035),
              Image.asset(AppImage.locationIcon,height: Get.height*0.03,fit: BoxFit.cover,color: AppColors.greyColor),
              Expanded(
                child: TextField(
                  focusNode: widget.focusNode,
                  controller: widget.textEditingController,
                  decoration: widget.inputDecoration,
                  style: widget.textStyle,
                  onChanged: (value) {
                    if(value.isEmpty){
                      setState(() {
                        isSelected = false;
                        _predictions = [];
                      });
                    }
                  },
                ),
              ),
              if (widget.isCrossBtnShown)
                Padding(
                  padding: EdgeInsets.only(right: Get.width * 0.02),
                  child: IconButton(
                    icon: const Icon(Icons.clear, size: 20),
                    onPressed: () {
                      widget.textEditingController.clear();
                      setState(() {
                        isSelected = false;
                        _predictions = [];
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
        if (_predictions.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            margin: EdgeInsets.only(top: Get.height*0.001),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            constraints: const BoxConstraints(
              maxHeight: 250,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: _predictions.length,
              padding: EdgeInsets.zero,
              separatorBuilder: (_, __) => widget.seperatedBuilder,
              itemBuilder: (context, index) {
                final prediction = _predictions[index];
                return InkWell(
                  onTap: () {
                    String description = prediction['description'];
                    String placeId = prediction['place_id'];
                    widget.textEditingController.text = description;
                    widget.textEditingController.selection =
                        TextSelection.fromPosition(
                          TextPosition(offset: description.length),
                        );
                    _getPlaceDetails(placeId);
                    setState(() {
                      _predictions = [];
                    });
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Text(
                      prediction['description'] ?? "",
                      style: widget.textStyle,
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
