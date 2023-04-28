import 'package:flutter/material.dart';

import '../../../core/models/user_data.dart';
import 'logged_user_profile.dart';

class DrawerWidget extends StatelessWidget {
  final UserData? userData;
  final VoidCallback onLogoutPressed;

  const DrawerWidget({
    super.key,
    required this.userData,
    required this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            LoggedUserProfile(
              user: userData,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: onLogoutPressed,
            ),
          ],
        ),
      ),
    );
  }
}
