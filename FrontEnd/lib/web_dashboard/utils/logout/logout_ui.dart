import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter/material.dart';

class LogoutPopup extends StatelessWidget {
  final VoidCallback onLogout;

  LogoutPopup({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        width: 500.0,
        height: 350.0,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30.0),
            const Icon(
              Icons.logout, // Use your desired logout icon
              size: 80.0,
              color: MyColors.primary, // Set icon color
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Are you sure you want',
              style: TextStyle(fontSize: 22.0, fontFamily: fontFamily),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'to log out?',
              style: TextStyle(fontSize: 18.0, fontFamily: fontFamily),
            ),
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onLogout,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent, // Changed color to green
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    minimumSize: const Size(150.0, 50), // Set minimum width
                  ),
                  child: const Text('Logout',
                      style: TextStyle(
                          color: Colors.white, fontFamily: fontFamily)),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Changed color to green
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    minimumSize: const Size(150.0, 50), // Set minimum width
                  ),
                  child: const Text('Cancel',
                      style: TextStyle(
                          color: Colors.white, fontFamily: fontFamily)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
