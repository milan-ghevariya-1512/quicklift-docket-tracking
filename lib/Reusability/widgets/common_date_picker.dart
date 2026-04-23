import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_textstyle.dart';
import 'common_widget.dart';

class CommonRangeDatePicker extends StatelessWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Function(DateTime?, DateTime?) onSelectionChanged;

  const CommonRangeDatePicker({
    super.key,
    this.initialStartDate,
    this.initialEndDate,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.whiteColor,
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select Date Range",
                  style: AppTextStyle.regularTextStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: AppColors.textBlackColor),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Get.back(),
                )
              ],
            ),
            Divider(color: AppColors.borderColor),
            SfDateRangePicker(
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is PickerDateRange) {
                  final DateTime? startDate = args.value.startDate;
                  final DateTime? endDate = args.value.endDate;
                  onSelectionChanged(startDate, endDate);
                }
              },
              selectionMode: DateRangePickerSelectionMode.range,
              maxDate: DateTime.now(),
              initialSelectedRange: PickerDateRange(
                  initialStartDate ?? DateTime.now(),
                  initialEndDate ?? DateTime.now()),
              backgroundColor: Colors.transparent,
              headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor: Colors.transparent,
                  textStyle: AppTextStyle.regularTextStyle.copyWith(fontWeight: FontWeight.w700)
              ),
              startRangeSelectionColor: AppColors.primaryColor,
              endRangeSelectionColor: AppColors.primaryColor,
              rangeSelectionColor: AppColors.primaryColor.withOpacity(0.1),
              todayHighlightColor: AppColors.primaryColor,
              selectionTextStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.whiteColor),
              rangeTextStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor),
            ),
          ],
        ),
      ),
    );
  }
}

class CommonDateTimePicker extends StatefulWidget {
  final DateTime? initialDateTime;
  final DateTime? minDate;
  final DateTime? maxDate;
  final Function(DateTime?) onDateTimeSelected;

  const CommonDateTimePicker({
    super.key,
    this.initialDateTime,
    this.minDate,
    this.maxDate,
    required this.onDateTimeSelected,
  });

  @override
  State<CommonDateTimePicker> createState() => _CommonDateTimePickerState();
}

class _CommonDateTimePickerState extends State<CommonDateTimePicker> {

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();

    final initial = widget.initialDateTime ?? DateTime.now();

    selectedDate = initial;
    selectedTime = TimeOfDay.fromDateTime(initial);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:
      EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.whiteColor,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select Date & Time",
                  style: AppTextStyle.regularTextStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppColors.textBlackColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                )
              ],
            ),
            Divider(color: AppColors.borderColor),
            SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.single,
              initialSelectedDate: selectedDate,
              maxDate: widget.maxDate ?? DateTime.now(),
              minDate: widget.minDate,
              backgroundColor: Colors.transparent,
              headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor: Colors.transparent,
                  textStyle: AppTextStyle.regularTextStyle.copyWith(fontWeight: FontWeight.w700)
              ),
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is DateTime) {
                  setState(() {
                    selectedDate = args.value;
                  });
                }
              },
              selectionColor: AppColors.primaryColor,

              todayHighlightColor: AppColors.primaryColor,
            ),

            const SizedBox(height: 12),

            /// 🔹 Time Picker Button
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime:
                  selectedTime ?? TimeOfDay.now(),
                );

                if (time != null) {
                  setState(() {
                    selectedTime = time;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: AppColors.borderColor),
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedTime == null
                          ? "Select Time"
                          : selectedTime!.format(context),
                      style: AppTextStyle.regularTextStyle,
                    ),
                    Image.asset(AppImage.orderTimeIcon, height: Get.height * 0.026, width: Get.height * 0.026, fit: BoxFit.contain)
                  ],
                ),
              ),
            ),
            HBox(Get.height * 0.015),
            CommonButton(
              textVal: "Confirm",
              onPressed: () {
                if (selectedDate != null &&
                    selectedTime != null) {
                  final finalDateTime = DateTime(
                    selectedDate!.year,
                    selectedDate!.month,
                    selectedDate!.day,
                    selectedTime!.hour,
                    selectedTime!.minute,
                  );

                  widget.onDateTimeSelected(finalDateTime);
                  Get.back();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class CommonDatePicker extends StatelessWidget {
  final DateTime? initialDate;
  final DateTime? maxDate;
  final Function(DateTime) onSelectionChanged;

  const CommonDatePicker({
    super.key,
    this.initialDate,
    this.maxDate,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.whiteColor,
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select Date",
                  style: AppTextStyle.regularTextStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: AppColors.textBlackColor),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Get.back(),
                )
              ],
            ),
            Divider(color: AppColors.borderColor),
            SfDateRangePicker(
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is DateTime) {
                  final DateTime selectedDate = args.value;
                  onSelectionChanged(selectedDate);
                }
              },
              selectionMode: DateRangePickerSelectionMode.single,
              maxDate: maxDate ?? DateTime.now(),
              initialSelectedDate: initialDate ?? DateTime.now(),
              backgroundColor: Colors.transparent,
              headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor: Colors.transparent,
                  textStyle: AppTextStyle.regularTextStyle.copyWith(fontWeight: FontWeight.w700)
              ),
              startRangeSelectionColor: AppColors.primaryColor,
              endRangeSelectionColor: AppColors.primaryColor,
              rangeSelectionColor: AppColors.primaryColor.withOpacity(0.1),
              todayHighlightColor: AppColors.primaryColor,
              selectionTextStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.whiteColor),
              rangeTextStyle: AppTextStyle.regularTextStyle.copyWith(color: AppColors.textBlackColor),
            ),
          ],
        ),
      ),
    );
  }
}