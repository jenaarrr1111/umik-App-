import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:umik/constants.dart';
import 'package:umik/screens/home/home_screen.dart';
import 'package:umik/screens/penjual/home/home_screen.dart';
import 'package:umik/screens/penjual/seller_profile/nama/seller_nama_screen.dart';
import 'package:umik/screens/sign_out/sign_out.dart';
import 'package:umik/services/storage_service.dart';
import 'package:umik/size_config.dart';

import '../no_handphone/Seller_hp_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class SellerProfileBody extends StatefulWidget {
  const SellerProfileBody({super.key});

  @override
  State<SellerProfileBody> createState() => _SellerProfileBodyState();
}

class _SellerProfileBodyState extends State<SellerProfileBody> {
  // initialize storage
  final StorageService storage = StorageService();
  String username = '';
  String nama = '';
  String noTelp = '';
  String email = '';
  String userId = '';
  String umkmId = '';
  String userToken = '';

  Future _readUserIdAndToken() async {
    try {
      final String usrId = await storage.readSecureData('user_id') ?? '';
      final String token = await storage.readSecureData('token') ?? '';
      setState(() {
        userId = usrId;
        userToken = token;
      });
      print('read success: $userId, $userToken');
      _getUserData();
    } catch (e) {
      print(e);
    }
  }

  Future _getUserData() async {
    try {
      var url = '$kApiBaseUrl/users/$userId';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        setState(() {
          username = data['username'];
          nama = data['nama'];
          noTelp = data['no_tlp'];
          email = data['email'];
          umkmId = data['umkm_id'].toString();
        });
        print('fetch success: $username, $nama, $noTelp, $email, $umkmId');
        await storage.writeSecureData('umkm_id', umkmId);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _readUserIdAndToken();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          // SizedBox(height: getProportionateScreenHeight(20)),
          Text(
            "Profile Kamu",
            style: heading1Style,
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          const ProfilePic(),
          SizedBox(height: getProportionateScreenHeight(10)),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Edit Foto",
              style: TextStyle(
                // fontSize: getProportionateScreenWidth(15),
                color: kTextSecondColor,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "Nama",
            fieldValue: nama,
            press: () => {
              Navigator.pushNamed(context, SellerNamaScreen.routeName),
            },
          ),
          ProfileMenu2(
            text: "Username",
            fieldValue: username,
            press: () {},
          ),
          ProfileMenu(
            text: "Handphone",
            fieldValue: noTelp,
            press: () => {
              Navigator.pushNamed(context, SellerHpScreen.routeName),
            },
          ),
          ProfileMenu2(
            text: "Email",
            fieldValue: email,
            press: () {},
          ),

          const SizedBox(height: 20),
          ProfileMenu3(
            text: "Lihat Toko Saya",
            press: () => {
              Navigator.pushNamed(context, SellerHomeScreen.routeName),
            },
          ),
          ProfileMenu3(
            text: "Rekap Penjualan",
            press: () => {
              // Navigator.pushNamed(context, SellerHomeScreen.routeName),
            },
          ),
          const SizedBox(height: 20),
          ProfileMenu3(
            text: "Beranda User",
            press: () => {Navigator.pushNamed(context, HomeScreen.routeName)},
          ),
          ProfileMenu3(
            text: "Logout",
            press: () => Navigator.pushNamedAndRemoveUntil(
                context, SignOut.routeName, (route) => false),
          ),
        ],
      ),
    );
  }
}
