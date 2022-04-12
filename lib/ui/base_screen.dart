import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/colors.dart';

class BaseScreen extends StatefulWidget {
  final Widget? child;
  final FloatingActionButton? floatingActionButton;
  const BaseScreen({
    Key? key,
    this.child,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
          child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          floatingActionButton: widget.floatingActionButton,
          appBar: AppBar(
            backgroundColor: cPrimaryColor,
            actions: [
              Container(
                alignment: Alignment.center,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  onTap: () {
                    onChangeLanguage(context);
                  },
                  child: Image.asset(
                    context.locale == const Locale("pl")
                        ? 'assets/images/flag_pl.png'
                        : 'assets/images/flag_en.png',
                    height: 36,
                  ),
                ),
              ),
              const SizedBox(width: 24),
            ],
            title: Text(
              "Car garage",
              style: GoogleFonts.fredokaOne(fontSize: 24),
            ),
          ),
          body: widget.child,
        ),
      )),
    );
  }

  void onChangeLanguage(BuildContext context) {
    EasyLocalization.of(context)?.setLocale(context.locale == const Locale("pl")
        ? const Locale("en")
        : const Locale("pl"));
  }
}
