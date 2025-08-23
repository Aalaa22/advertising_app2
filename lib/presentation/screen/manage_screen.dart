import 'package:advertising_app/constant/string.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/presentation/widget/custom_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ManageScreen extends StatefulWidget {
  final Function(Locale) onLanguageChange;

  const ManageScreen({Key? key, required this.onLanguageChange})
      : super(key: key);

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  String _selectedFilter = 'All'; // لتحديد الفلتر النشط
  String? _selectedAction; // لتتبع زر الإجراء النشط

  // --- دالة جديدة لتحديث الصفحة ---
  void _refreshPage() {
    setState(() {
      // استدعاء setState فارغًا يجبر Flutter على إعادة بناء الواجهة،
      // مما يؤدي إلى "تحديث" مرئي للصفحة.
      // إذا كنت بحاجة لجلب بيانات جديدة من الإنترنت، يمكنك وضع الكود هنا.
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    _selectedAction ??= s.upgrade;

    final Color primaryColor = Color.fromRGBO(1, 84, 126, 1);
    final Color borderColor = Color.fromRGBO(8, 194, 201, 1);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNav(currentIndex: 3),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 25.h),
              Center(
                child: Text(
                  s.manageAds,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.sp,
                    color: KTextColor,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              _buildFilterButtons(s, primaryColor),
              SizedBox(height: 8.h),
              _buildBalanceTable(s, primaryColor),
              SizedBox(height: 5.h),
              _buildAdCard(s, primaryColor, borderColor),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButtons(S s, Color primaryColor) {
    final filters = {
      s.all: "All",
      s.valid: "Valid",
      s.pending: "Pending",
      s.expired: "Expired",
      s.rejected: "Rejected"
    };
    return Row(
      children: filters.entries.map((entry) {
        final isSelected = _selectedFilter == entry.value;
        Widget buttonChild = ElevatedButton(
          onPressed: () => setState(() => _selectedFilter = entry.value),
          child: Text(entry.key,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: isSelected ? Colors.white : primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp)),
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? primaryColor : Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 2.w),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
          ),
        );
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: isSelected
                ? buttonChild
                : Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                            colors: [Color(0xFFE4F8F6), Color(0xFFC9F8FE)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: buttonChild),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBalanceTable(S s, Color primaryColor) {
    Widget buildCell(Widget child,
        {bool isHeader = false, Alignment alignment = Alignment.center}) {
      return Container(
        padding: EdgeInsets.all(8.h),
        alignment: alignment,
        child: DefaultTextStyle(
            style: TextStyle(
                color: KTextColor,
                fontSize: 12.sp,
                fontWeight: isHeader ? FontWeight.w600 : FontWeight.w500),
            child: child),
      );
    }

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(8, 194, 201, 1)),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Table(
            border: TableBorder(
                horizontalInside: BorderSide(
                    color: Color.fromRGBO(8, 194, 201, 1), width: 1),
                verticalInside:
                    BorderSide(color: Colors.grey.shade300, width: 1)),
            columnWidths: const {
              0: FlexColumnWidth(1.5),
              1: FlexColumnWidth(1.2),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
            },
            children: [
              TableRow(children: [
                buildCell(Text(s.adsType),
                    isHeader: true, alignment: Alignment.centerLeft),
                buildCell(
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(s.premium,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(width: 2.w),
                          Icon(Icons.star,
                              color: Color(0xFFF7C325), size: 14.sp)
                        ]),
                    isHeader: true),
                buildCell(Text(s.premium), isHeader: true),
                buildCell(Text(s.featured), isHeader: true),
              ]),
              TableRow(
                  decoration: BoxDecoration(color: Color(0xFFF9FAFB)),
                  children: [
                    buildCell(Text(s.totalAds),
                        alignment: Alignment.centerLeft),
                    buildCell(Text("100")),
                    buildCell(Text("50")),
                    buildCell(Text("50")),
                  ]),
              TableRow(children: [
                buildCell(Text(s.balance), alignment: Alignment.centerLeft),
                buildCell(Text("60")),
                buildCell(Text("30")),
                buildCell(Text("20")),
              ])
            ],
          ),
          Divider(height: 1, color: Color.fromRGBO(8, 194, 201, 1)),
          Padding(
            padding: EdgeInsets.all(10.h),
            child: Text('${s.contractExpire}:00/00/0000',
                style: TextStyle(
                    color: KTextColor,
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w500)),
          )
        ],
      ),
    );
  }

  Widget _buildAdCard(S s, Color primaryColor, Color borderColor) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3))
          ]),
      child: Column(
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              width: 140.w,
              height: 95.h,
              child: GestureDetector(
                onTap: () {},
                child: Stack(children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset('assets/images/car.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity)),
                  Positioned(
                    top: 4.h,
                    left: 7.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(201, 248, 254, 1),
                              Color.fromRGBO(8, 194, 201, 1)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(s.premium,
                          style: TextStyle(
                              color: KTextColor,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Positioned(
                    bottom: 4.h,
                    left: 4.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, .49),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text("300,000 AED",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold)),
                    ),
                  )
                ]),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
                child: Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Audi S5 TSFI",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: KTextColor)),
                SizedBox(height: 28.h),
                Text(s.valid,
                    style: TextStyle(
                        color: Color.fromRGBO(36, 150, 17, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp)),
                SizedBox(height: 4.h),
                Text('${s.postDate}:25/3/2025',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400)),
                SizedBox(height: 2.h),
                Text('${s.expiresIn} 10 Days',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400))
              ]),
              IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/deleted.svg',
                      width: 20.w, height: 22.h))
            ]))
          ]),
          SizedBox(height: 3.h),
          Row(children: [
            Icon(Icons.visibility_outlined,
                color: Color.fromRGBO(8, 194, 201, 1), size: 16.sp),
            SizedBox(width: 4.w),
            Text('${s.views} 20',
                style: TextStyle(
                    color: Color.fromRGBO(8, 194, 201, 1),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400))
          ]),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionButton(s.refresh, primaryColor, borderColor, s),
              _buildActionButton(s.edit, primaryColor, borderColor, s),
              _buildActionButton(s.renew, primaryColor, borderColor, s),
              _buildActionButton(s.upgrade, primaryColor, borderColor, s),
            ],
          ),
          SizedBox(height: 8.h),
          _buildPaymentRow(s.activeOffersBox, "20", "100", s.pay,
              primaryColor, borderColor, s)
        ],
      ),
    );
  }

  // --- تم تعديل هذه الدالة ---
  Widget _buildActionButton(
      String label, Color primaryColor, Color borderColor, S s) {
    final bool isSelected = _selectedAction == label;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedAction = label;
            });

            // *** منطق جديد للتحقق من الزر ***
            if (label == s.refresh) {
              // إذا كان الزر هو "Refresh"، قم فقط بتحديث الصفحة
              _refreshPage();
            } else if (label == s.renew || label == s.upgrade) {
              // بقية الأزرار تحتفظ بسلوكها السابق
              context.push('/car_sales_ads');
            } else { // هذا يغطي زر "Edit"
              context.push('/car_sales_save_ads');
            }
          },
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? primaryColor : Colors.white,
            side: BorderSide(color: isSelected ? primaryColor : borderColor),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.symmetric(vertical: 8.h),
            elevation: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentRow(String label, String days, String amount, String pay,
      Color primaryColor, Color borderColor, S s) {
    final labelStyle = TextStyle(
        color: KTextColor, fontSize: 11.sp, fontWeight: FontWeight.w500);

    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Expanded(
          flex: 3,
          child: ElevatedButton(
              onPressed: () {},
              child: Text(label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h)))),
      SizedBox(width: 2.w),
      Expanded(
          flex: 1,
          child: Column(children: [
            Text(s.days, style: labelStyle),
            SizedBox(height: 4.h),
            Container(
                padding: EdgeInsets.symmetric(vertical: 11.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: Text(days,
                        style: TextStyle(
                            color: KTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp))))
          ])),
      SizedBox(width: 2.w),
      Expanded(
          flex: 1,
          child: Column(children: [
            Text(s.amount, style: labelStyle),
            SizedBox(height: 4.h),
            Container(
                padding: EdgeInsets.symmetric(vertical: 11.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: Text(amount,
                        style: TextStyle(
                            color: KTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp))))
          ])),
      SizedBox(width: 4.w),
      Expanded(
          flex: 2,
          child: ElevatedButton(
              onPressed: () {},
              child: Text(pay,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(vertical: 11.h))))
    ]);
  }
}