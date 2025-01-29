import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../home/home_list_view.dart';

void phoneDialog(BuildContext context) {
  List<TextEditingController> codeControllers =
      List.generate(6, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Code Sent'),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                'A verification code has been sent to your phone number.'),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 40,
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (event) {
                        if (event is RawKeyDownEvent) {
                          if (event.logicalKey ==
                                  LogicalKeyboardKey.backspace &&
                              codeControllers[index].text.isEmpty &&
                              index > 0) {
                            FocusScope.of(context)
                                .requestFocus(focusNodes[index - 1]);
                          }
                        }
                      },
                      child: TextField(
                        controller: codeControllers[index],
                        focusNode: focusNodes[index],
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          counterText: '',
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context)
                                .requestFocus(focusNodes[index + 1]);
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context)
                                .requestFocus(focusNodes[index - 1]);
                          }
                        },
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Logic to resend the code
              print('Resend code logic here');
            },
            child: const Text('Send Again'),
          ),
          TextButton(
            onPressed: () {
              // Logic to verify the code
              String enteredCode =
                  codeControllers.map((controller) => controller.text).join();
              print('Entered Code: $enteredCode');
              Navigator.of(context).pushNamedAndRemoveUntil(
                HomeListView.routeName,
                (Route<dynamic> route) => false,
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.green,
            ),
            child: const Text('Verify'),
          ),
        ],
      );
    },
  );
}