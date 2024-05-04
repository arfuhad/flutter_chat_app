import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/commons/commons.dart';
import 'package:flutter_chat_app/features/auth/auth.dart';
import 'package:flutter_chat_app/features/dashboard/dashboard.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DashboardView extends HookConsumerWidget {
//   const DashboardView({super.key});

//   @override
//   State<DashboardView> createState() => _DashboardViewState();
// }

// class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = useState(0);
    return Scaffold(
      appBar: AppBar(
        title: Text(pageIndex.value == 0 ? 'Dashboard' : 'Settings'),
      ),
      body: pageIndex.value == 0
          ? DashboardUserWidget()
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UiTextButton(
                    onPressedFn: () {
                      ref.read(authNotifierProvider.notifier).signOut();
                      context.pushReplacement('/sign-in');
                    },
                    buttonText: "Logout",
                    fontColor: Colors.white,
                  )
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          pageIndex.value = value;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
