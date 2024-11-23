import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mrt_native_support/platform_interface.dart';
import 'package:mrt_wallet/app/core.dart';
import 'package:mrt_wallet/future/widgets/custom_widgets.dart';
import 'package:mrt_wallet/future/state_managment/extension/extension.dart';
import 'package:mrt_wallet/future/constant/constant.dart';

class AbountWalletView extends StatelessWidget {
  const AbountWalletView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAssetsImgaeView(APPConst.logo),
          ],
        ),
        WidgetConstant.height20,
        Text(
          "About UU.COOL Wallet",
          style: context.textTheme.titleLarge,
        ),
        WidgetConstant.height8,
        const Text(
            "Welcome to UU.COOL Wallet, the open-source wallet designed for the decentralized future of finance. Our mission is to empower users with a secure and versatile solution that supports both Bitcoin mainnet and testnet, as well as networks such as Ripple, Ethereum, Tron Dogecoin, Litecoin, and Dash, with a roadmap set to embrace a broad spectrum of cryptocurrencies."),
        WidgetConstant.height20,
        Text(
          "Decentralized, Secure, and Open Source",
          style: context.textTheme.titleLarge,
        ),
        WidgetConstant.height8,
        RichText(
            text: TextSpan(style: context.textTheme.bodyMedium, children: [
          const TextSpan(
              text:
                  "At UU.COOL Wallet, we believe in the power of decentralization. Our commitment to decentralization is at the core of our design philosophy, providing you with full control over your assets. Your private keys remain in your hands, ensuring the highest level of security. We take pride in being fully open source. You can explore and audit our code on"),
          TextSpan(
            text: " Github ",
            style:
                context.textTheme.labelLarge?.copyWith(color: ColorConst.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                PlatformInterface.instance.launchUri(LinkConst.appGithub);
              },
          ),
          const TextSpan(
              text:
                  "under the Apache License 2.0. This commitment to transparency means that every line of code is accessible, empowering the community to verify the security and integrity of our wallet."),
        ])),
        WidgetConstant.height20,
        Text(
          "Bitcoin, Dogecoin, Litecoin, Dash Support — Mainnet and Testnet",
          style: context.textTheme.titleLarge,
        ),
        WidgetConstant.height8,
        const Text(
            "Whether you're navigating the robust Bitcoin mainnet for your financial transactions or experimenting on the testnet to fine-tune your strategies, UU.COOL Wallet is your reliable companion. Seamlessly switch between the secure environments of Bitcoin mainnet and testnet, and explore additional horizons with support for diverse cryptocurrencies like Ethereum, Tron, Dogecoin, Dash, Litecoin, and Ripple. UU.COOL Wallet empowers you to transact with confidence across a broad spectrum of digital assets"),
        WidgetConstant.height20,
        Text("Platform Support", style: context.textTheme.titleLarge),
        WidgetConstant.height8,
        RichText(
            text: TextSpan(style: context.textTheme.bodyMedium, children: [
          TextSpan(
            text: "Android: ",
            style: context.textTheme.labelLarge,
          ),
          const TextSpan(
              text:
                  "Take your wallet on the go with our Android app, ensuring you have secure access to your funds anytime, anywhere."),
        ])),
        WidgetConstant.height8,
        RichText(
            text: TextSpan(style: context.textTheme.bodyMedium, children: [
          TextSpan(
            text: "Windows: ",
            style: context.textTheme.labelLarge,
          ),
          const TextSpan(
              text:
                  "Enjoy the convenience of UU.COOL Wallet on your desktop. Our Windows version brings the power of decentralized finance to your fingertips."),
        ])),
        WidgetConstant.height8,
        RichText(
            text: TextSpan(style: context.textTheme.bodyMedium, children: [
          TextSpan(
            text: "Web: ",
            style: context.textTheme.labelLarge,
          ),
          const TextSpan(
              text:
                  "Access your wallet from any web browser with our web platform. Manage your assets with ease, all while enjoying the security and privacy UU.COOL Wallet provides.")
        ])),
        WidgetConstant.height20,
        Text(
          "Roadmap: Embracing a Diverse Crypto Landscape",
          style: context.textTheme.titleLarge,
        ),
        WidgetConstant.height8,
        const Text(
            "Our journey doesn't end with four networks. The UU.COOL Wallet roadmap is a dynamic chart that outlines our commitment to support a wide range of cryptocurrencies. We're dedicated to staying at the forefront of innovation, adapting to new technologies, and expanding our capabilities to serve the evolving needs of the crypto community."),
        WidgetConstant.height20,
        Text(
          "Community-Driven Development",
          style: context.textTheme.titleLarge,
        ),
        WidgetConstant.height8,
        const Text(
            "UU.COOL Wallet is not just a wallet; it's a community-driven project. We welcome collaboration, feedback, and contributions from the community. Together, we're building a decentralized future that prioritizes security, privacy, and inclusivity."),
        WidgetConstant.height20,
        Text(
          "Get Involved",
          style: context.textTheme.titleLarge,
        ),
        WidgetConstant.height8,
        RichText(
            text: TextSpan(style: context.textTheme.bodyMedium, children: [
          const TextSpan(
              text:
                  "Join us on our mission to redefine the landscape of decentralized finance. Contribute to our open-source project on"),
          TextSpan(
            style:
                context.textTheme.labelLarge?.copyWith(color: ColorConst.blue),
            text: " GitHub ",
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                PlatformInterface.instance.launchUri(LinkConst.appGithub);
              },
          ),
          const TextSpan(text: "or connect with our community on"),
          TextSpan(
            text: " Telegram.",
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                PlatformInterface.instance.launchUri(LinkConst.appTelegram);
              },
            style:
                context.textTheme.labelLarge?.copyWith(color: ColorConst.blue),
          )
        ])),
        WidgetConstant.height8,
        const Text(
            "Thank you for choosing UU.COOL Wallet as your trusted partner in the world of decentralized finance"),
        WidgetConstant.height20,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                PlatformInterface.instance.launchUri(LinkConst.appTelegram);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: context.colors.onSurface, shape: BoxShape.circle),
                child: CircleAssetsImgaeView(
                  APPConst.telegramLogo,
                  radius: 15,
                ),
              ),
            ),
            WidgetConstant.width8,
            InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                PlatformInterface.instance.launchUri(LinkConst.appGithub);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: context.colors.onSurface, shape: BoxShape.circle),
                child: CircleAssetsImgaeView(
                  APPConst.githubLogo,
                  radius: 15,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
