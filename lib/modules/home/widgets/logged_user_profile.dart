import 'package:flutter/material.dart';
import 'package:challenge/core/models/user_data.dart';

class LoggedUserProfile extends StatelessWidget {
  final UserData? user;

  const LoggedUserProfile({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return UserAccountsDrawerHeader(
        accountName: Text(user?.name ?? 'User'),
        accountEmail: Text(user?.login ?? 'Login'),
        currentAccountPicture: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            user?.avatarUrl ?? 'https://picsum.photos/500/500',
            loadingBuilder: (context, widget, loadingProgress) {
              if (loadingProgress == null) return widget;
              return const CircularProgressIndicator.adaptive();
            },
          ),
        ),
      );
    } else {
      return UserAccountsDrawerHeader(
        accountName: const Text('Search'),
        accountEmail: const Text('Search user'),
        currentAccountPicture: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            'https://picsum.photos/500/500',
            loadingBuilder: (context, widget, loadingProgress) {
              if (loadingProgress == null) return widget;
              return const CircularProgressIndicator.adaptive();
            },
          ),
        ),
      );
    }
  }
}
