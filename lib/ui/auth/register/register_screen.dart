import 'package:flutter/material.dart';
import 'package:pokedex/model/form/register.dart';
import 'package:pokedex/ui/auth/register/provider/register_provider.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:pokedex/utils/route/routes.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            //LOGO
            Center(child: Image.asset(pokemonLogo, height: 150, width: 150)),
            const SizedBox(height: kDefaultPadding / 2),

            //FORM
            _SectionForm(),
            const SizedBox(height: kDefaultPadding),

            //BUTTON
            _SectionButton(),
          ],
        ),
      ),
    );
  }
}

class _SectionForm extends StatelessWidget {
  const _SectionForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Consumer<RegisterProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //USERNAME
              Text(
                'Username',
                style: kTextPoppinsMed12.copyWith(fontSize: 13),
              ),
              const SizedBox(height: kDefaultPadding / 5),
              TextField(
                style: kTextPoppinsReg12,
                onChanged: (val) {
                  value.updateValue(RegisterForm.USERNAME, val);
                },
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Please input your name',
                  hintStyle: kTextPoppinsReg12.copyWith(color: Colors.grey),
                  errorText: value.getErrorMessage(RegisterForm.USERNAME),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: kBlackColor1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding),

              //EMAIL
              Text(
                'Email',
                style: kTextPoppinsMed12.copyWith(fontSize: 13),
              ),
              const SizedBox(height: kDefaultPadding / 5),
              TextField(
                style: kTextPoppinsReg12,
                onChanged: (val) {
                  value.updateValue(RegisterForm.EMAIL, val);
                },
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Please input your email',
                  hintStyle: kTextPoppinsReg12.copyWith(color: Colors.grey),
                  errorText: value.getErrorMessage(RegisterForm.EMAIL),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: kBlackColor1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding),

              //PASSWORD
              Text(
                'Password',
                style: kTextPoppinsMed12.copyWith(fontSize: 13),
              ),
              const SizedBox(height: kDefaultPadding / 5),
              Stack(
                children: [
                  TextField(
                    style: kTextPoppinsReg12,
                    obscureText: !value.togglePassword,
                    onChanged: (val) {
                      value.updateValue(RegisterForm.PASSWORD, val);
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Please input your password',
                      hintStyle: kTextPoppinsReg12.copyWith(color: Colors.grey),
                      errorText: value.getErrorMessage(RegisterForm.PASSWORD),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: kBlackColor1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                      onPressed: () => value.toggle(),
                      icon: value.togglePassword == true
                          ? const Icon(Icons.remove_red_eye_outlined)
                          : const Icon(Icons.remove_red_eye, color: steelColor),
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SectionButton extends StatelessWidget {
  const _SectionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Consumer<RegisterProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return Column(
            children: [
              //LOGIN
              ElevatedButton(
                onPressed: () => value.doRegister(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(size.width, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'REGISTER',
                  style: kTextPoppinsMed12.copyWith(color: kWhiteColor),
                ),
              ),
              const SizedBox(height: kDefaultPadding / 2),

              Text(
                '- Or -\n- already have an account ? -',
                style: kTextPoppinsReg12.copyWith(color: kBlackColor1),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: kDefaultPadding / 5 * 2),

              //REGISTER
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, loginRoute),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(size.width, 40),
                  backgroundColor: steelColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'LOGIN',
                  style: kTextPoppinsMed12.copyWith(color: kWhiteColor),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
