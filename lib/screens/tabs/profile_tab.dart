import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../models/models.dart';
import '../../widgets/shared_widgets.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _studentIdController;
  String? _selectedDepartment;
  String _selectedGender = mockUser.gender;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _nameController = TextEditingController(text: mockUser.fullName);
    _studentIdController = TextEditingController(text: mockUser.studentId);
    _selectedDepartment = mockUser.department;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _studentIdController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Profile updated successfully!'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ));
    }
  }

  void _handleCancel() {
    setState(() {
      _nameController.text = mockUser.fullName;
      _studentIdController.text = mockUser.studentId;
      _selectedDepartment = mockUser.department;
      _selectedGender = mockUser.gender;
    });
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile header banner
        _ProfileHeaderCard(user: mockUser),

        // TabBar
        Container(
          color: AppColors.cardBg,
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textMuted,
            labelStyle: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w700),
            unselectedLabelStyle: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w500),
            indicatorColor: AppColors.primary,
            indicatorWeight: 2.5,
            tabs: const [
              Tab(text: 'Personal Info'),
              Tab(text: 'My Listings'),
              Tab(text: 'Settings'),
            ],
          ),
        ),

        // TabBarView
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildPersonalInfoTab(),
              _buildMyListingsTab(),
              _buildSettingsTab(),
            ],
          ),
        ),
      ],
    );
  }

  // ── Tab 1: Personal Info ─────────────────────
  Widget _buildPersonalInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FormSectionTitle(
                title: 'Profile Identity', icon: Icons.person_outline),
            const SizedBox(height: 14),
            ProfileFormField(
              label: 'Full Name',
              controller: _nameController,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            ),
            const SizedBox(height: 14),
            ProfileFormField(
              label: 'Student ID',
              controller: _studentIdController,
              readOnly: true,
            ),
            const SizedBox(height: 14),
            _buildDepartmentDropdown(),
            const SizedBox(height: 20),
            const FormSectionTitle(
                title: 'Gender Identification', icon: Icons.wc_outlined),
            const SizedBox(height: 10),
            _buildGenderGroup(),
            const SizedBox(height: 20),
            _buildActionButtons(),
            const SizedBox(height: 20),
            _ProfileStrengthCard(strength: mockUser.profileStrength),
            const SizedBox(height: 14),
            const _PrivacyNoteCard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDepartmentDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Department Selection', style: AppTextStyles.label),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: _selectedDepartment,
          hint: const Text('Select department',
              style: TextStyle(fontSize: 14, color: AppColors.textMuted)),
          validator: (v) =>
              v == null ? 'Please select a department' : null,
          onChanged: (val) => setState(() => _selectedDepartment = val),
          style: const TextStyle(fontSize: 14, color: AppColors.textDark),
          icon: const Icon(Icons.keyboard_arrow_down,
              color: AppColors.textMuted),
          decoration: appInputDecoration(),
          items: departments
              .map((d) => DropdownMenuItem(
                    value: d,
                    child: Text(d, overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildGenderGroup() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3.5,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: genderOptions
            .map((g) => RadioListTile<String>(
                  value: g,
                  groupValue: _selectedGender,
                  onChanged: (val) =>
                      setState(() => _selectedGender = val!),
                  title: Text(g,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: _selectedGender == g
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: _selectedGender == g
                              ? AppColors.primary
                              : AppColors.textDark)),
                  activeColor: AppColors.primary,
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _handleCancel,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textDark,
              side: const BorderSide(color: AppColors.borderColor),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Cancel',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: _handleSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Save Changes',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }

  // ── Tab 2 & 3 placeholders ───────────────────
  Widget _buildMyListingsTab() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.storefront_outlined,
              size: 52, color: AppColors.primary.withOpacity(0.3)),
          const SizedBox(height: 12),
          const Text('No listings yet',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted)),
          const SizedBox(height: 6),
          const Text('Items you list will appear here.',
              style: TextStyle(fontSize: 13, color: AppColors.textMuted)),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.settings_outlined,
              size: 52, color: AppColors.primary.withOpacity(0.3)),
          const SizedBox(height: 12),
          const Text('Settings — Coming Soon',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  PROFILE HEADER CARD
// ─────────────────────────────────────────────
class _ProfileHeaderCard extends StatelessWidget {
  final AppUser user;
  const _ProfileHeaderCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white.withOpacity(0.25),
            child: Text(user.initials,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.fullName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 3),
                Text('${user.department} · ${user.classYear}',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8), fontSize: 11),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                const VerifiedBadge(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  PROFILE STRENGTH CARD
// ─────────────────────────────────────────────
class _ProfileStrengthCard extends StatelessWidget {
  final double strength;
  const _ProfileStrengthCard({required this.strength});

  @override
  Widget build(BuildContext context) {
    final percent = (strength * 100).toInt();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Profile Strength',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
              Text('$percent%',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: strength,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.25),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Complete your profile to unlock premium features like marketplace listings and campus alerts.',
            style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 11,
                height: 1.5),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  PRIVACY NOTE CARD
// ─────────────────────────────────────────────
class _PrivacyNoteCard extends StatelessWidget {
  const _PrivacyNoteCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.warningLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFCD34D)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 16, color: AppColors.warning),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Privacy Note: Your department information helps us tailor notifications to your faculty and campus events.',
              style: TextStyle(
                  fontSize: 11, color: Color(0xFF92400E), height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
