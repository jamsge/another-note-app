import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'phone_dialog.dart';

class DashTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.length > 3 && text.length <= 6 && text[3] != '-') {
      final newText = text.substring(0, 3) + '-' + text.substring(3);
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
    if (text.length > 6 && text[6] != '-') {
      final newText = text.substring(0, 3) + '-' + text.substring(3, 6) + '-' + text.substring(6);
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
    return newValue;
  }
}

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController phoneController = TextEditingController();
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      final phoneNumber = phoneController.text.replaceAll('-', '');
      isButtonEnabled.value = phoneNumber.length == 10;
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    isButtonEnabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Another Note App',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                DashTextInputFormatter(),
              ],
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.phone),
                prefix: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: const Text(
                    '+1',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ValueListenableBuilder<bool>(
              valueListenable: isButtonEnabled,
              builder: (context, isEnabled, child) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isEnabled
                        ? () {
                            phoneDialog(context);
                          }
                        : null,
                    child: const Text('Send code'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}