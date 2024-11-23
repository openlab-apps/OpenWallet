import 'package:flutter/material.dart';
import 'package:mrt_wallet/future/state_managment/extension/app_extensions/context.dart'
    show QuickContextAccsess;

class MaterialPageView extends StatelessWidget {
  const MaterialPageView({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.primary,
      child: SafeArea(
          child: Container(
        color: context.colors.surface,
        child: child,
      )),
    );
  }
}

class ScaffolPageView extends StatelessWidget {
  const ScaffolPageView(
      {required this.child,
      super.key,
      this.appBar,
      this.scaffoldKey,
      this.bottomNavigationBar,
      this.resizeToAvoidBottomInset = true});
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Key? scaffoldKey;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar,
        key: scaffoldKey,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: child,
        bottomNavigationBar: bottomNavigationBar);
  }
}
