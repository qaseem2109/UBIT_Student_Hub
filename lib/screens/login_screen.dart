import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/shared_widgets.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$');
    if (!regex.hasMatch(value.trim())) return 'Enter a valid email address';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Navigate to MainScreen and replace login (can't go back)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                children: [
                  _buildCard(),
                  const SizedBox(height: 20),
                  const _FooterLinks(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: UbitLogo()),
            const SizedBox(height: 24),
            const Text('Welcome Back', style: AppTextStyles.heading),
            const SizedBox(height: 6),
            const Text(
              'Please enter your details to sign in',
              style: TextStyle(
                  fontSize: 14, color: AppColors.textMuted, height: 1.5),
            ),
            const SizedBox(height: 24),

            // Email
            const FieldLabel('University Email'),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
              style: const TextStyle(fontSize: 14, color: AppColors.textDark),
              decoration: appInputDecoration(
                hintText: 'name@university.edu',
                prefixIcon: const Icon(Icons.email_outlined,
                    size: 18, color: AppColors.textMuted),
              ),
            ),
            const SizedBox(height: 16),

            // Password label row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const FieldLabel('Password'),
                GestureDetector(
                  onTap: () {},
                  child: const Text('Forgot Password?',
                      style: AppTextStyles.link),
                ),
              ],
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              validator: _validatePassword,
              style: const TextStyle(fontSize: 14, color: AppColors.textDark),
              decoration: appInputDecoration(
                hintText: '••••••••',
                prefixIcon: const Icon(Icons.lock_outline,
                    size: 18, color: AppColors.textMuted),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 18,
                    color: AppColors.textMuted,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Remember Me
            Transform.translate(
              offset: const Offset(-8, 0),
              child: CheckboxListTile(
                value: _rememberMe,
                onChanged: (val) =>
                    setState(() => _rememberMe = val ?? false),
                title: const Text('Remember Me',
                    style:
                        TextStyle(fontSize: 13, color: AppColors.textDark)),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                activeColor: AppColors.primary,
                dense: true,
                visualDensity: VisualDensity.compact,
              ),
            ),
            const SizedBox(height: 20),

            // Login button
            PrimaryButton(
              label: 'Login',
              icon: Icons.arrow_forward,
              onPressed: _handleLogin,
            ),
            const SizedBox(height: 20),

            // Create account
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textMuted),
                  children: [
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text('Create an account',
                            style: AppTextStyles.link),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  FOOTER LINKS
// ─────────────────────────────────────────────
class _FooterLinks extends StatelessWidget {
  const _FooterLinks();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('© 2024 UBIT Hub. All rights reserved.',
            style: AppTextStyles.footerText),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: Text('Privacy Policy',
                  style: AppTextStyles.footerText.copyWith(
                      decoration: TextDecoration.underline)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text('·', style: AppTextStyles.footerText),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: Text('Terms of Service',
                  style: AppTextStyles.footerText.copyWith(
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ],
    );
  }
}
