import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/core/widgets/app_background.dart';
import 'package:weather_app/core/widgets/custom_text_field.dart';
import 'package:weather_app/features/auth/screens/signup_screen.dart';
import 'package:weather_app/features/auth/services/auth_services.dart';
import 'package:weather_app/features/home/screens/home_screen.dart';
import 'package:weather_app/features/onboarding/screens/welcome_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
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
                            Text(
                              'Sign in to your\n Account',
                              style: TextStyles.Heading1,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Enter your email and password to log in ',
                              style: TextStyles.subHeading,
                            ),
                            const SizedBox(height: 32),
                    
                            CustomTextField(
                              controller: emailController,
                              hintText: 'Enter your email',
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your email';
                                }
                                final emailRegex = RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                );
                                if (!emailRegex.hasMatch(value.trim())) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                    
                            const SizedBox(height: 16),
                            CustomTextField(
                              controller: passwordController,
                              hintText: 'Enter your password',
                              obscureText: _obscurePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                    
                            Row(
                              children: [
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Checkbox(
                                    value: _rememberMe,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    side: const BorderSide(
                                      color: AppColors.GreyColor,
                                    ),
                                    activeColor: const Color(0xFF2E6FF2),
                                    onChanged: (val) {
                                      setState(() {
                                        _rememberMe = val ?? false;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Remember me',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    height: 1.5,
                                    letterSpacing: -0.32,
                                    color: AppColors.GreyColor,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    'Forget password?',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      letterSpacing: -0.32,
                                      height: 1.4,
                                      color: AppColors.blueColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 28),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                // onPressed: () {
                                //   Navigator.pushAndRemoveUntil(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => const HomeScreen(),
                                //     ),
                                //     (route) => false,
                                //   );
                                // },
                                onPressed:loader
                                ? null
                                :() async{
                                  if(_formKey.currentState!.validate()){
                                    setState(()=>loader=true);
                                    try {
                                      await AuthServices().logIn(
                                        email: emailController.text.trim(),
                                        password: passwordController.text,
                                      );
                                      if(!mounted)return;
                    
                                      Navigator.pushAndRemoveUntil(
                                        context, 
                                        MaterialPageRoute(builder: (context)=>HomeScreen()), 
                                        (route)=>false);
                                    } catch (e) {
                                      if(!mounted)return;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                         SnackBar(
                                          content: Text(e.toString()),
                                          backgroundColor: Colors.redAccent,
                                          ),
                                      );
                                    
                                    }finally{
                                     if(mounted){
                                      setState(() => loader=false,);
                                     }
                                    }
                                      
                                    
                                  }
                                },
                               
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.blueColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                // child: const Text(
                                //   'Log In',
                                //   style: TextStyle(
                                //     fontFamily: 'Inter',
                                //     color: Colors.white,
                                //     fontSize: 14,
                                //     height: 1.4,
                                //     letterSpacing: -0.32,
                                //   ),
                                // ),
                                child: loader
                                ?const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color:Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                :const Text(
                                            'Log In',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                              fontSize: 14,
                                              height: 1.4,
                                              letterSpacing: -0.32,
                                            ),
                                          ),
                              ),
                            ),
                            const SizedBox(height: 24),
                    
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: AppColors.GreyColor,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Text(
                                    'Or',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: AppColors.GreyColor,
                                      fontSize: 12,
                                      height: 1.5,
                                      letterSpacing: -0.32,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: AppColors.GreyColor,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                    
                            _buildSocialButton(
                              text: 'Continue with Google',
                              icon: Image.asset(
                                'assets/images/google-icon-removebg-preview.png',
                                height: 22,
                                width: 22,
                              ),
                              onTap: () async {
                                try {
                                  final userCredential = AuthServices()
                                      .signInWithGoogle();
                    
                                  if (userCredential != null && context.mounted) {
                                    // Navigator.pushReplacementNamed(context, '/home');
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const WelcomeScreen(),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(e.toString()),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                            const SizedBox(height: 14),
                            _buildSocialButton(
                              text: 'Continue with Facebook',
                              icon: const Icon(
                                Icons.facebook,
                                color: Color(0xFF1877F2),
                                size: 22,
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account?',
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignupScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign Up',
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
    );
  }
 
  Widget _buildSocialButton({
    required String text,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                height: 1.4,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.32,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
