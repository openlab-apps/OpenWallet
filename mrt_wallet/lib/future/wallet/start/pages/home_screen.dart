import 'package:flutter/material.dart';
import 'package:mrt_wallet/app/core.dart';
import 'package:mrt_wallet/future/theme/theme.dart';
import 'package:mrt_wallet/future/wallet/controller/controller.dart';
import 'package:mrt_wallet/future/wallet/controller/wallet/ui_wallet.dart';
import 'package:mrt_wallet/future/wallet/setting/color_selector.dart';
import 'package:mrt_wallet/future/widgets/custom_widgets.dart';
import 'package:mrt_wallet/wallet/models/others/models/status.dart';
import 'package:mrt_wallet/wallet/wallet.dart' show HDWallet;
import 'account_page.dart';
import 'login_page.dart';
import 'package:mrt_wallet/future/router/page_router.dart';
import 'setup.dart';
import 'package:mrt_wallet/future/state_managment/state_managment.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = context.watch<WalletProvider>(StateConst.main);
    return MrtViewBuilder<WalletProvider>(
      removable: false,
      controller: () => wallet,
      repositoryId: StateConst.main,
      builder: (model) {
        // UIWallet uiWallet = model.wallet;
        // uiWallet.network
        // print("传入数据1:${model.wallet.network.networkName}");
        return MaterialPageView(
          child: RefreshIndicator(
            key: wallet.wallet.refreshState,
            notificationPredicate: (notification) {
              return wallet.wallet.isOpen;
            },
            onRefresh: wallet.wallet.updateBalance,
            child: CustomScrollView(
              physics: WidgetConstant.noScrollPhysics,
              slivers: [
                _AccountAppBar(wallet),
                SliverFillRemaining(
                  child: PageProgress(
                    key: wallet.wallet.pageStatusHandler,
                    backToIdle: APPConst.oneSecoundDuration,
                    initialStatus: StreamWidgetStatus.progress,
                    initialWidget:
                        ProgressWithTextView(text: "launch_the_wallet".tr),
                    child: (c) => APPAnimatedSwitcher(
                        enable: wallet.wallet.homePageStatus,
                        widgets: {
                          WalletStatus.setup: (c) =>
                              const WalletSetupPageWidget(),
                          WalletStatus.ready: (c) => APPAnimatedSwitcher(
                                  enable: wallet.wallet.isOpen,
                                  widgets: {
                                    true: (c) =>
                                        NetworkAccountPageView(wallet: model),
                                    false: (c) => const WalletLoginPageView()
                                  }),
                        }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AccountAppBar extends StatelessWidget {
  const _AccountAppBar(this.wallet);
  final WalletProvider wallet;
  @override
  Widget build(BuildContext context) {
    bool isReady = wallet.wallet.homePageStatus.isReady;
    bool isLock = wallet.wallet.isLock;
    return SliverAppBar(
      centerTitle: false,
      toolbarHeight: isReady ? kToolbarHeight : 0,
      title: isReady ? Text(wallet.wallet.wallet.name) : null,
      pinned: true,
      actions: [
        if (isLock) ...[
          BrightnessToggleIcon(
              onToggleBrightness: () => wallet.toggleBrightness(),
              brightness: ThemeController.appTheme.brightness),
          ColorSelectorIconView(
            (p0) {
              if (p0 == null) return;
              return wallet.changeColor(p0);
            },
          ),
        ] else
          IconButton(
              onPressed: () {
                context.to(PageRouter.setting);
              },
              icon: const Icon(Icons.settings)),
        WidgetConstant.width8,
      ],
      leading: IconButton(
          onPressed: () {
            context
                .openSliverDialog<HDWallet>(
                    (c) => SwitchWalletView(
                          wallets: wallet.wallet.wallets,
                          selectedWallet: wallet.wallet.wallet,
                        ),
                    "switch_wallets".tr,
                    content: (c) => [
                          IconButton(
                              onPressed: () {
                                context.offTo(PageRouter.createWallet);
                              },
                              icon: const Icon(Icons.add))
                        ])
                .then(wallet.wallet.switchWallet);
          },
          icon: const Icon(Icons.account_balance_wallet_rounded)),
    );
  }
}

class SwitchWalletView extends StatelessWidget {
  const SwitchWalletView(
      {required this.wallets, required this.selectedWallet, Key? key})
      : super(key: key);
  final List<HDWallet> wallets;
  final HDWallet selectedWallet;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final wallet = wallets[index];
        final bool selected = selectedWallet.name == wallet.name;
        return ContainerWithBorder(
          onRemove: () {
            context.pop(wallet);
          },
          onTapWhenOnRemove: selected ? false : true,
          onRemoveWidget: selected
              ? const Icon(Icons.check_circle)
              : WidgetConstant.sizedBox,
          child: Row(
            children: [
              wallet.requiredPassword
                  ? const Icon(Icons.lock)
                  : const Icon(Icons.lock_open),
              WidgetConstant.width8,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(wallet.name, style: context.textTheme.labelLarge),
                    Text(wallet.created.toString(),
                        style: context.textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemCount: wallets.length,
      shrinkWrap: true,
    );
  }
}
