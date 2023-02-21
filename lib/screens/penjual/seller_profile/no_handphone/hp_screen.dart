import 'package:flutter/material.dart';
import 'package:umik/screens/profile/no_handphone/components/hp_body.dart';
// import 'package:umik/screens/profile/components/nama/components/body.dart';

import '../seller_profile_screen.dart';

class SellerHpScreen extends StatelessWidget {
  static String routeName = "/seller_profile_hp";

  const SellerHpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ubah No.Handphone",
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        shadowColor: Colors.black45,
        elevation: 20,
        actions: <Widget>[
          TextButton(
            onPressed: () => {
              Navigator.pushNamed(context, SellerProfileScreen.routeName),
            },
            child: Text(
              "Simpan",
              style: TextStyle(
                color: Color(0xFF33691E),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      body: HpBody(),
      // body: SafeArea(
      //   child: SizedBox(
      //     width: double.infinity,
      //     child: SingleChildScrollView(
      //       child: Padding(
      //         padding: const EdgeInsets.all(10.0),
      //         child: Column(
      //           children: [
      //             CustomTextField(
      //               label: "No.Handphone Baru",
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}