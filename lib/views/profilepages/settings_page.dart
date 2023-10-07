
// settings_page.dart
import 'package:bennu_app/viewmodels/profile_viewmodel.dart';
import 'package:bennu_app/views/settingpages/rules_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bennu_app/views/settingpages/deleteAccount_page.dart';
import 'package:bennu_app/views/settingpages/edit_address_page.dart';
import 'package:bennu_app/views/settingpages/edit_email_page.dart';
import 'package:bennu_app/views/settingpages/logout_page.dart';
import 'package:bennu_app/views/settingpages/bank_account_page.dart';
import 'package:bennu_app/views/settingpages/contact_support_page.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel()..fetchProfileDetails(),
      child: Consumer<ProfileViewModel>(
        builder: (_, viewModel, __) {
          Scaffold(
            appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 90, 0, 0),
            title: const Text('SETTINGS', style: TextStyle(color: Colors.white)),
          ),
            backgroundColor: Colors.white,
            body: Consumer (
              builder: (context, viewModel, child) {
                return ListView(
                children: [
                ListTile(
                  title: const Text('Bennu Rules', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RulesPage()));
                  }
                ),
                ListTile(
                  title: const Text('Email', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EditEmailPage()));
                  }
                ),
                ListTile(
                  title: const Text('Bank Account', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BankAccountSetupPage()));
                  },
                ),
                ListTile(
                  title: const Text('Address', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressSetPage()));
                  },
                ),
                const ListTile(
                  title: Text('AUTH004', style: TextStyle(color: Color.fromARGB(180, 60, 0, 0))),
                ),
                SwitchListTile(
                  title: const Text('Account Closed'),
                  value: viewModel?.isAccountClosed ?? false,
                  onChanged: (value) {
                    Consumer<ProfileViewModel>(
                      builder: (_, viewModel, __) {
                        return SwitchListTile(
                          title: const Text('Account Closed'),
                          value: viewModel?.isAccountClosed ?? false,
                          onChanged: (value) {
                            viewModel?.toggleAccountClosed(value);
                          },
                          inactiveTrackColor: const Color.fromARGB(108, 84, 74, 70),
                          activeColor: const Color.fromARGB(255, 0, 255, 8),
                        );
                      },
                    ),
                  },
                  inactiveTrackColor: const Color.fromARGB(108, 84, 74, 70),
                  activeColor: const Color.fromARGB(255, 0, 255, 8),
                ),
                ListTile(
                  title: const Text('Contacts'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactPage()));
                  },
                ),
                ListTile(
                  title: const Text('Development'),
                  onTap: () async {
                    const url = 'https://github.com/brief69/bennu_app';
                    if (await canLaunchUrl(Uri.parse(url))) {
                       await launchUrl(Uri.parse(url));
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                ElevatedButton(
                  child: const Text('Log Out', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LogoutPage()));
                  }
                ),
                ElevatedButton(
                  child: const Text('Delete Account', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const DeleteAccountPage()));
                  }
                ),
              ],
            );
          },
        ),
      );
    }
  }
}