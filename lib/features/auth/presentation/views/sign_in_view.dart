import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/core.dart';
import 'package:flutter_chat_app/features/auth/auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignInView extends HookConsumerWidget {
  SignInView({super.key});

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final isObsecureText = useState(true);
    final errorText = useState("");

    ref.listen(authNotifierProvider, (previous, next) {
      if (next.runtimeType == AuthStateSuccess) {
        context.pushReplacement('/dashboard');
      } else if (next.runtimeType == AuthStateError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text((next as AuthStateError).error),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            Container(
              color: Colors.blueGrey,
              height: double.infinity,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: SizedBox(
                height: (MediaQuery.of(context).size.height -
                        -MediaQuery.of(context).viewInsets.bottom) *
                    0.58,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(top: 20),
                      children: [
                        Container(
                            alignment: Alignment.topLeft,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            // margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 23),
                              textAlign: TextAlign.center,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: UIEditText(
                            isShowBorderEnable: false,
                            isShowBorderFocused: false,
                            boxDecoration: BoxDecoration(
                                color: const Color(0xFFF7F7F7),
                                borderRadius: BorderRadius.circular(20)),
                            paddingLeft: 10,
                            paddingRight: 10,
                            controller: emailController,
                            labelText: "Email",
                            hintText: "e.g.: johndoe@example.com",
                            keyboardType: TextInputType.emailAddress,
                            suffixWidget: const Icon(Icons.mail),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@') ||
                                  !value.contains('.')) {
                                return 'Invalid Email';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: UIEditText(
                            isShowBorderEnable: false,
                            isShowBorderFocused: false,
                            boxDecoration: BoxDecoration(
                                color: const Color(0xFFF7F7F7),
                                borderRadius: BorderRadius.circular(20)),
                            paddingLeft: 10,
                            paddingRight: 10,
                            controller: passwordController,
                            labelText: "Password",
                            hintText: "e.g.: *********",
                            obsecureText: isObsecureText.value,
                            keyboardType: TextInputType.text,
                            suffixWidget: GestureDetector(
                              onTap: () {
                                // setState(() {
                                isObsecureText.value = !isObsecureText.value;
                                // });
                              },
                              child: Icon(isObsecureText.value
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Invalid Password';
                              }
                              return null;
                            },
                          ),
                        ),
                        // testFieldWidget('Password', true),
                        const SizedBox(
                          height: 30,
                        ),
                        errorText.value.isNotEmpty
                            ? Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  errorText.value,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: UiTextButton(
                            onPressedFn: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_formKey.currentState!.validate()) {
                                errorText.value = "";
                                // var firebaseAuth =
                                //     injector<FirebaseAuthService>();
                                // var result = await firebaseAuth
                                //     .signInWithEmailAndPassword(
                                //         email: emailController.text,
                                //         password: passwordController.text);
                                var result = ref
                                    .read(authNotifierProvider.notifier)
                                    .login(
                                        email: emailController.text,
                                        password: passwordController.text);
                                if (result != null) {
                                  // context.pushReplacement('/dashboard');
                                  log('sign in view: $result');
                                } else {
                                  errorText.value = "$result";
                                }
                              }
                            },
                            buttonSize: const Size(double.infinity, 56),
                            buttonBorderRadius: 20,
                            buttonText: "Sign In",
                            fontColor: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.push("/sign-up");
                                },
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.all(20),
                                  child: const Text(
                                    "Sign Up",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  margin: const EdgeInsets.all(20),
                                  child: const Text(
                                    "Forgot Password?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
