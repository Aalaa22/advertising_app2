import 'package:advertising_app/data/model/user_model.dart';
import 'package:advertising_app/presentation/providers/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:advertising_app/constant/string.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/presentation/widget/custom_bottom_nav.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _userNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _whatsAppController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _advertiserNameController = TextEditingController();
  final _advertiserTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = context.read<AuthProvider>();
      // جلب البيانات فقط إذا لم تكن موجودة بالفعل
      if (authProvider.user == null) {
        // نستمع هنا للتأكد من تحديث الواجهة بعد الجلب
        context.read<AuthProvider>().fetchUserProfile();
      }
    });
  }

  void _updateTextFields(UserModel? user) {
    if (user != null) {
      _userNameController.text = user.username;
      _emailController.text = user.email;
      _phoneController.text = user.phone;
      _whatsAppController.text = user.whatsapp ?? '';
      _advertiserNameController.text = user.advertiserName ?? '';
      _advertiserTypeController.text = user.advertiserType ?? '';
      _passwordController.text = "••••••••";
    }
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _phoneController.dispose();
    _whatsAppController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _advertiserNameController.dispose();
    _advertiserTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // نملأ الحقول في كل مرة يتم فيها إعادة البناء بعد نجاح الجلب
        _updateTextFields(authProvider.user);

        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: const CustomBottomNav(currentIndex: 4),
          body: SafeArea(
            child: authProvider.isLoadingProfile
                ? const Center(child: CircularProgressIndicator())
                : authProvider.profileError != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Error: ${authProvider.profileError}", style: const TextStyle(color: Colors.red)),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => authProvider.fetchUserProfile(),
                              child: const Text("Try Again"),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            GestureDetector(
                              onTap: () => context.pop(),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.arrow_back_ios, color: KTextColor, size: 17.sp),
                                  Transform.translate(
                                    offset: Offset(-3.w, 0),
                                    child: Text(
                                      S.of(context).back,
                                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: KTextColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Text(
                                S.of(context).myProfile,
                                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500, color: KTextColor),
                              ),
                            ),
                            const SizedBox(height: 10),

                            _buildLabel(S.of(context).userName),
                            _buildEditableField(_userNameController, () => context.push('/profile')),
                            
                            _buildLabel(S.of(context).phone),
                            _buildPhoneField(_phoneController, () => context.push('/profile')),
                            
                            _buildLabel(S.of(context).whatsApp),
                            _buildPhoneField(_whatsAppController, () => context.push('/profile')),
                            
                            _buildLabel(S.of(context).password),
                            _buildEditableField(_passwordController, () => context.push('/profile'), isPassword: true),
                            
                            _buildLabel(S.of(context).email),
                            _buildEditableField(_emailController, () => context.push('/profile')),
                            
                            _buildLabel(S.of(context).advertiserName),
                            _buildEditableField(_advertiserNameController, () => context.push('/profile')),
                            
                            _buildLabel(S.of(context).advertiserType),
                            _buildEditableField(_advertiserTypeController, () => context.push('/profile')),
                            
                            _buildLabel(S.of(context).advertiserLogo),
                            GestureDetector(
                              onTap: () => _showEditPopup(() => context.push('/profile')),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color.fromRGBO(8, 194, 201, 1)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[50],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.camera_alt, color: KTextColor),
                                    const SizedBox(width: 5),
                                    Flexible(
                                      child: Text(
                                        S.of(context).uploadYourLogo,
                                        style: const TextStyle(color: KTextColor, fontSize: 15, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              S.of(context).advertiserLocation,
                              style: TextStyle(color: KTextColor, fontSize: 16.sp, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              S.of(context).address,
                              style: TextStyle(color: KTextColor, fontSize: 16.sp, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            _buildMapSection(context),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => context.push('/profile'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF01547E),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                ),
                                child: Text(S.of(context).editprof4),
                              ),
                            ),
                             const SizedBox(height: 20),
                          ],
                        ),
                      ),
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 6),
      child: Text(text, style: TextStyle(color: KTextColor, fontWeight: FontWeight.w500, fontSize: 16.sp)),
    );
  }

  Widget _buildEditableField(TextEditingController controller, VoidCallback onEdit, {bool isPassword = false}) {
    return GestureDetector(
      onTap: () => _showEditPopup(onEdit),
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          readOnly: true,
          obscureText: isPassword,
          style: TextStyle(
            color: KTextColor, // تحديد لون النص
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color.fromRGBO(8, 194, 201, 1))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color.fromRGBO(8, 194, 201, 1))),
          ),
        ),
      ),
    );
  }
  
  Widget _buildPhoneField(TextEditingController controller, VoidCallback onEdit) {
    return GestureDetector(
      onTap: () => _showEditPopup(onEdit),
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          readOnly: true,
          style: TextStyle(
            color: KTextColor, // تحديد لون النص
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            prefixIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: Text(
                '+971', // كود دولة ثابت للعرض فقط
                style: TextStyle(color: KTextColor, fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color.fromRGBO(8, 194, 201, 1))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color.fromRGBO(8, 194, 201, 1))),
          ),
        ),
      ),
    );
  }
  
  void _showEditPopup(VoidCallback onEdit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        elevation: 10,
        title: Row(
          children: [
            const Icon(Icons.edit, color: Color(0xFF01547E)),
            const SizedBox(width: 8),
            Text(S.of(context).editing1, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFF01547E))),
          ],
        ),
        content: Text(S.of(context).editit2, style: TextStyle(fontSize: 16.sp, color: KTextColor)),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context).cancel, style: TextStyle(color: Colors.grey[700], fontSize: 14)),
          ),
          ElevatedButton(
            onPressed: () { Navigator.pop(context); onEdit(); },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF01547E), foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Text(S.of(context).edit3),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMapSection(BuildContext context) {
    return SizedBox(
      height: 320, width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(child: Image.asset('assets/images/map.png', fit: BoxFit.cover)),
          const Positioned(top: 130, left: 0, right: 0, child: Icon(Icons.location_pin, color: Colors.red, size: 40)),
          Positioned(
            bottom: 30, left: 20, right: 20,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.location_on_outlined, color: Colors.white, size: 26),
              label: Text(S.of(context).locateMe, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF01547E), minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}