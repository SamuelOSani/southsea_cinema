import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/models/user_settings.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

// Stable keys for the four editable cinema profile preferences.
const String prefName = 'cinema_profile_name';
const String prefEmail = 'cinema_profile_email';
const String prefPhone = 'cinema_profile_phone';
const String prefNewsletter = 'cinema_profile_newsletter';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  bool _receiveNewsletter = false;
  String _confirmationMessage = '';

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();

    _loadSettings();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  Future<void> _loadSettings() async {
    try {
      final SharedPreferencesAsync prefs = SharedPreferencesAsync();
      final String name = await prefs.getString(prefName) ?? '';
      final String email = await prefs.getString(prefEmail) ?? '';
      final String phone = await prefs.getString(prefPhone) ?? '';
      final bool newsletter = await prefs.getBool(prefNewsletter) ?? false;

      if (!mounted) {
        return;
      }

      setState(() {
        _nameController.text = name;
        _emailController.text = email;
        _phoneController.text = phone;
        _receiveNewsletter = newsletter;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _confirmationMessage = 'Could not load settings: $error';
      });
    }
  }

  Future<void> _saveSettings() async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String phone = _phoneController.text.trim();
    final bool newsletter = _receiveNewsletter;

    try {
      final SharedPreferencesAsync prefs = SharedPreferencesAsync();
      await prefs.setString(prefName, name);
      await prefs.setString(prefEmail, email);
      await prefs.setString(prefPhone, phone);
      await prefs.setBool(prefNewsletter, newsletter);
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _confirmationMessage = 'Could not save settings: $error';
      });
      return;
    }

    final UserSettings settings = UserSettings(
      name: name,
      email: email,
      phone: phone,
      receiveNewsletter: newsletter,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _confirmationMessage = 'Settings saved for ${settings.name}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Settings'),
      ),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customer Profile',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full name',
                hintText: 'Enter your full name',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email address',
                hintText: 'Enter your email address',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone number',
                hintText: 'Enter your phone number',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Text('Receive cinema news and offers'),
                ),
                Switch(
                  value: _receiveNewsletter,
                  onChanged: (bool value) {
                    setState(() {
                      _receiveNewsletter = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                label: 'Save Settings',
                onPressed: _saveSettings,
              ),
            ),
            if (_confirmationMessage.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                _confirmationMessage,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
