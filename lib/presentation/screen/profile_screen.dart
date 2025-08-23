import 'package:advertising_app/data/model/user_model.dart';
import 'package:advertising_app/presentation/providers/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:advertising_app/constant/string.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/presentation/widget/custom_bottom_nav.dart';
import 'package:advertising_app/presentation/widget/custom_phone_field.dart';
import 'package:advertising_app/presentation/widget/custom_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _userNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _whatsAppController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _advertiserNameController = TextEditingController();
  String? _selectedAdvertiserType;
  final List<String> advertiserTypes = [
    'Dealer / Showroom', 'Personal Owner', 'Real Estate Agent', 'Recruiter'
  ];

  @override
  void initState() {
    super.initState();
    // جلب البيانات وملء الحقول فور فتح الشاشة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = context.read<AuthProvider>();
      authProvider.fetchUserProfile().then((_) {
        if (mounted && authProvider.user != null) {
          _updateTextFields(authProvider.user!);
        }
      });
    });
  }

  void _updateTextFields(UserModel user) {
    _userNameController.text = user.username;
    _phoneController.text = user.phone;
    _whatsAppController.text = user.whatsapp ?? '';
    _emailController.text = user.email;
    _advertiserNameController.text = user.advertiserName ?? '';
    setState(() {
      _selectedAdvertiserType = user.advertiserType;
    });
  }
  
  @override
  void dispose() {
    _userNameController.dispose(); _phoneController.dispose(); _whatsAppController.dispose();
    _newPasswordController.dispose(); _currentPasswordController.dispose(); _emailController.dispose();
    _advertiserNameController.dispose();
    super.dispose();
  }

  // دالة الحفظ المحدثة (بدون validation)
  Future<void> _saveProfile() async {
    final provider = context.read<AuthProvider>();
    
    // تحديث البروفايل بالبيانات الحالية في الـ controllers
    bool profileSuccess = await provider.updateUserProfile(
      username: _userNameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      whatsapp: _whatsAppController.text,
      advertiserName: _advertiserNameController.text,
      advertiserType: _selectedAdvertiserType,
    );
    
    // تحديث كلمة المرور فقط إذا تم كتابة شيء في الحقول
    bool passwordSuccess = true;
    if (_newPasswordController.text.isNotEmpty && _currentPasswordController.text.isNotEmpty) {
       passwordSuccess = await provider.updateUserPassword(
         currentPassword: _currentPasswordController.text,
         newPassword: _newPasswordController.text,
       );
    }

    if (!mounted) return;
    if (profileSuccess && passwordSuccess) {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile saved successfully!'), backgroundColor: Colors.green));
       context.pop();
    } else {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.updateError ?? "Failed to save profile."), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const CustomBottomNav(currentIndex: 4),
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            // أثناء التحميل لأول مرة، نعرض مؤشر تحميل
            if (provider.isLoadingProfile && provider.user == null) {
              return const Center(child: CircularProgressIndicator());
            }

            // في حالة وجود خطأ عند التحميل الأول
            if (provider.profileError != null && provider.user == null) {
              return Center(child: Text("Error: ${provider.profileError}"));
            }

            // نعرض الواجهة دائمًا بمجرد وجود بيانات
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back_ios, color: KTextColor, size: 17.sp),
                        Transform.translate(offset: Offset(-3.w, 0), child: Text(S.of(context).back, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: KTextColor))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(child: Text(S.of(context).myProfile, style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500, color: KTextColor))),
                  const SizedBox(height: 5),

                  _buildLabel(S.of(context).userName),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: CustomTextField(controller: _userNameController, hintText: "Username")),

                  _buildLabel(S.of(context).phone),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: CustomPhoneField(controller: _phoneController)),
                  
                  _buildLabel(S.of(context).whatsApp),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: CustomPhoneField(controller: _whatsAppController)),
                  
                  _buildLabel("Current Password (for changing)"),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: CustomTextField(controller: _currentPasswordController, hintText: 'Current password', isPassword: true)),

                  _buildLabel("New Password (leave empty to not change)"),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: CustomTextField(controller: _newPasswordController, hintText: 'New password', isPassword: true)),
                  
                  _buildLabel(S.of(context).email),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: CustomTextField(controller: _emailController, hintText: 'Email', keyboardType: TextInputType.emailAddress)),
                  
                  _buildLabel(S.of(context).advertiserName),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: CustomTextField(controller: _advertiserNameController, hintText: S.of(context).optional)),
                  
                  _buildLabel(S.of(context).advertiserType),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: S.of(context).optional,
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color.fromRGBO(8, 194, 201, 1))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: KTextColor, width: 1.5)),
                      ),
                      value: _selectedAdvertiserType, isExpanded: true, icon: const Icon(Icons.keyboard_arrow_down, color: KTextColor),
                      items: advertiserTypes.map((v) => DropdownMenuItem<String>(value: v, child: Text(v, style: const TextStyle(color: KTextColor)))).toList(),
                      onChanged: (v) => setState(() => _selectedAdvertiserType = v),
                    ),
                  ),

                  // ... (باقي واجهة المستخدم)
                  _buildLabel(S.of(context).advertiserLogo),
                  // ...
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(child: OutlinedButton(onPressed: () => context.pop(), child: Text(S.of(context).cancel), style: OutlinedButton.styleFrom(foregroundColor: KTextColor, side: const BorderSide(color: Color.fromRGBO(8, 194, 201, 1)), padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)))),
                        const SizedBox(width: 10),
                        Expanded(
                          child: provider.isUpdating
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(onPressed: _saveProfile, child: Text(S.of(context).save), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF01547E), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16))),
                        ),
                      ],
                    ),
                  ),
                   const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

   Widget _buildLabel(String text) => Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: Text(text, style: TextStyle(color: KTextColor, fontWeight: FontWeight.w500, fontSize: 16.sp)));
   Widget _buildMapSection(BuildContext context) => const SizedBox(height: 200, child: Center(child: Text("Map Placeholder")));
}