import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/core.dart';
import 'package:flutter_chat_app/features/auth/auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpView extends HookConsumerWidget {
  SignUpView({super.key});

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final confirmPasswordController = useTextEditingController(text: '');
    final isPasswordObsecureText = useState(true);
    final isConfirmPasswordObsecureText = useState(true);
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
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              UiHeader(
                leftWidget: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Center(
                      child: Icon(
                        Icons.chevron_left_rounded,
                        size: 30,
                      ),
                    )),
              ),
              Container(
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: const Text(
                  "Let's sign you up",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: const Text(
                  "Enter your information below or continue with your social account.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                // child: UIEditText(
                //   basicUiPackage: widget.basicUiPackage,
                //   controller: widget.emailFieldController,
                //   labelText: widget.emailLabelText ?? "Email",
                //   labelColor: widget.emailLabelTextColor,
                //   labelFontSize: widget.emailFontSize,
                //   hintText: widget.emailHintText ?? "e.g.: johndoe@example.com",
                //   hintColor: widget.emailHintTextColor,
                //   hintFontSize: widget.emailHintFontSize,
                //   fontColor: widget.emailTextColor,
                //   fontSize: widget.emailFontSize,
                // ),
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
                height: 15,
              ),
              // textFieldWidget('Password', true),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
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
                  obsecureText: isPasswordObsecureText.value,
                  keyboardType: TextInputType.text,
                  suffixWidget: GestureDetector(
                    onTap: () {
                      // setState(() {
                      isPasswordObsecureText.value =
                          !isPasswordObsecureText.value;
                      // });
                    },
                    child: Icon(isPasswordObsecureText.value
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
              const SizedBox(
                height: 15,
              ),
              // textFieldWidget('Confirm Password', true),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: UIEditText(
                  isShowBorderEnable: false,
                  isShowBorderFocused: false,
                  boxDecoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(20)),
                  paddingLeft: 10,
                  paddingRight: 10,
                  controller: confirmPasswordController,
                  labelText: "Confirm Password",
                  hintText: "e.g.: *********",
                  obsecureText: isConfirmPasswordObsecureText.value,
                  keyboardType: TextInputType.text,
                  suffixWidget: GestureDetector(
                    onTap: () {
                      // setState(() {
                      isConfirmPasswordObsecureText.value =
                          !isConfirmPasswordObsecureText.value;
                      // });
                    },
                    child: Icon(isConfirmPasswordObsecureText.value
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
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: UiTextButton(
                  onPressedFn: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (_formKey.currentState!.validate()) {
                      errorText.value = "";
                      // var firebaseAuth = injector<FirebaseAuthService>();
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        // var result =
                        //     await firebaseAuth.signUpWithEmailAndPassword(
                        //         email: emailController.text,
                        //         password: passwordController.text);
                        var result = ref
                            .read(authNotifierProvider.notifier)
                            .signup(
                                email: emailController.text,
                                password: passwordController.text);
                        if (result != null) {
                          // context.pushReplacement('/dashboard');
                          log('sign up view: $result');
                        } else {
                          errorText.value = "$result";
                        }
                      } else {
                        errorText.value =
                            "Password and confirm password must be same.";
                      }
                    }
                  },
                  buttonSize: const Size(double.infinity, 56),
                  buttonBorderRadius: 20,
                  buttonText: "Sign Up",
                  fontColor: Colors.white,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Sign in here.",
                        textAlign: TextAlign.center,
                        // color: ColorUtil.signUpColor,
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
