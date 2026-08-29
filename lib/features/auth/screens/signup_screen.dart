import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/core/widgets/app_background.dart';
import 'package:weather_app/core/widgets/custom_text_field.dart';
import 'package:weather_app/features/auth/screens/login_screen.dart';
import 'package:weather_app/features/auth/services/auth_services.dart';
import 'package:weather_app/features/home/screens/home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthServices _authServices = AuthServices();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedCountryFlag = '🇩🇿';
  String selectedCountryCode = '+213';
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    dobController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark=Theme.of(context).brightness==Brightness.dark;
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constaints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constaints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                constraints: const BoxConstraints(),
                                onPressed: () => Navigator.pop(context),
                                icon:  Icon(
                                  Icons.arrow_back,
                                  color:isDark?Colors.white: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 40),
                              Text('Register', style: TextStyles.Heading1.copyWith(
                                color:isDark?Colors.white:Colors.black
                              )),
                              const SizedBox(height: 10),
                              const Text(
                                'Create an account to continue! ',
                                style: TextStyles.subHeading,
                              ),
                              const SizedBox(height: 32),
                              CustomTextField(
                                controller: firstNameController,
                                hintText: 'First name',
                              ),
                              const SizedBox(height: 14),

                              CustomTextField(
                                controller: lastNameController,
                                hintText: 'Last name',
                              ),
                              const SizedBox(height: 14),

                              CustomTextField(
                                controller: emailController,
                                hintText: 'Email',
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter your email";
                                  }
                                  final emailRegex = RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                  );
                                  if (!emailRegex.hasMatch(value.trim())) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null; //for correct email
                                },
                              ),
                              const SizedBox(height: 14),

                              CustomTextField(
                                controller: dobController,
                                hintText: 'dd/mm/yyyy',
                                readOnly: true,
                                suffixIcon: const Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(2026),
                                    firstDate: DateTime(1920),
                                    lastDate: DateTime.now(),
                                  );
                                  if (pickedDate != null) {
                                    dobController.text =
                                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                  }
                                },
                              ),
                              const SizedBox(height: 14),

                              CustomTextField(
                                controller: phoneController,
                                hintText: '726-0592',
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  if (value.trim().length < 8 ||
                                      value.trim().length > 11) {
                                    return 'Please enter a valid phone number';
                                  }
                                  return null;
                                },
                                prefixIcon: IntrinsicHeight(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(width: 14),
                                      GestureDetector(
                                        onTap: () {
                                          showCountryPicker(
                                            context: context,
                                            showPhoneCode: true,
                                            countryListTheme: CountryListThemeData(
                                              bottomSheetHeight:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.height *
                                                  0.55,
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                    top: Radius.circular(20),
                                                  ),
                                              inputDecoration: InputDecoration(
                                                hintText:
                                                    'Search for countries',
                                                prefixIcon: const Icon(
                                                  Icons.search,
                                                ),
                                              ),
                                            ),

                                            onSelect: (Country country) {
                                              setState(() {
                                                selectedCountryFlag =
                                                    country.flagEmoji;
                                                selectedCountryCode =
                                                    '+${country.phoneCode}';
                                              });
                                            },
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              selectedCountryFlag,
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            const Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color: Colors.grey,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1.2,
                                        indent: 12,
                                        endIndent: 12,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        selectedCountryCode,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),

                              CustomTextField(
                                controller: passwordController,
                                hintText: '*******',
                                obscureText: _obscurePassword,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  if (value.length < 8) {
                                    return 'Password must be at least 8 characters';
                                  }
                                  if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
                                    return 'Password must contain at least one letter';
                                  }
                                  if (!RegExp(r'[0-9]').hasMatch(value)) {
                                    return 'Password must contain at least one number';
                                  }
                                  if (!RegExp(
                                    r'[!@#$%^&*(),.?":{}|<>]',
                                  ).hasMatch(value)) {
                                    return 'Password must contain at least one special character';
                                  }
                                  return null;
                                },
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _isLoading
                                      ? null
                                      : () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() => _isLoading = true);
                                            try {
                                              final fullPhone =
                                                  '$selectedCountryCode${phoneController.text.trim()}';

                                              await _authServices.signUp(
                                                firstName:
                                                    firstNameController.text,
                                                lastName:
                                                    lastNameController.text,
                                                email: emailController.text,
                                                dob: dobController.text,
                                                fullPhoneNumber: fullPhone,
                                                password:
                                                    passwordController.text,
                                              );
                                              if (!mounted) return;

                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Account created successfully!',
                                                  ),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                              Navigator.pushAndRemoveUntil(
                                                context, 
                                                MaterialPageRoute(
                                                  builder: (context)=>const HomeScreen(),
                                                  ), 
                                                (route)=>false);
                                            } catch (e) {
                                              if (!mounted) return;
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(e.toString()),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            } finally {
                                              if (mounted) {
                                                setState(
                                                  () => _isLoading = false,
                                                );
                                              }
                                            }
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.blueColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          'Register',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Colors.white,
                                            fontSize: 14,
                                            height: 1.4,
                                            letterSpacing: -0.32,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 24.0,
                              bottom: 8.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    height: 1.4,
                                    letterSpacing: -0.32,
                                    color: AppColors.GreyColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Log in',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      height: 1.4,
                                      letterSpacing: -0.32,
                                      color: AppColors.blueColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
