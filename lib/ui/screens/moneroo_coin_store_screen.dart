import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterquiz/commons/widgets/custom_snackbar.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';
import 'package:flutterquiz/features/auth/cubits/auth_cubit.dart';
import 'package:flutterquiz/features/in_app_purchase/services/moneroo_config_service.dart';
import 'package:flutterquiz/features/in_app_purchase/cubits/moneroo_payment_cubit.dart';
import 'package:flutterquiz/features/in_app_purchase/cubits/moneroo_payment_state.dart';
import 'package:flutterquiz/features/profile_management/cubits/user_details_cubit.dart';
import 'package:flutterquiz/ui/widgets/ibeere_buttons.dart';

class MonerooCoinStoreScreen extends StatefulWidget {
  const MonerooCoinStoreScreen({super.key});

  static const routeName = '/moneroo-coin-store';

  @override
  State<MonerooCoinStoreScreen> createState() => _MonerooCoinStoreScreenState();
}

class _MonerooCoinStoreScreenState extends State<MonerooCoinStoreScreen> {
  bool _isLoading = true;
  MonerooConfig? _monerooConfig;
  List<CoinPackage> _packages = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final config = await MonerooConfigService.fetchConfig();
      final packages = await MonerooConfigService.fetchCoinPackages();

      if (config.isConfigured && mounted) {
        context.read<MonerooPaymentCubit>().initialize(
              appId: config.appId,
              apiKey: config.apiKey ?? '',
              isTestMode: config.isTestMode,
            );
      }

      setState(() {
        _monerooConfig = config;
        _packages = packages;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
        _packages = MonerooConfigService._getDefaultPackages();
      });
    }
  }

  void _purchasePackage(CoinPackage package) {
    final authState = context.read<AuthCubit>().state;
    if (authState is! Authenticated || authState.isGuest) {
      showCustomSnackbar(
        context: context,
        message: 'Please login to purchase coins',
        type: SnackbarType.error,
      );
      return;
    }

    final userDetails = context.read<UserDetailsCubit>().getUserProfile();
    final cubit = context.read<MonerooPaymentCubit>();

    if (!cubit.isConfigured) {
      showCustomSnackbar(
        context: context,
        message: 'Payment gateway not configured',
        type: SnackbarType.error,
      );
      return;
    }

    cubit.createPayment(
      context: context,
      amount: package.price,
      currency: package.currency,
      coins: package.totalCoins,
      userId: userDetails.userId ?? '',
      userEmail: userDetails.email,
      userPhone: userDetails.mobileNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = context.watch<UserDetailsCubit>().getUserProfile();

    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        backgroundColor: DesignTokens.background,
        elevation: 0,
        title: Text(
          'Coin Store',
          style: TextStyle(
            color: DesignTokens.primary,
            fontWeight: DesignTokens.fontWeightBold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: DesignTokens.primary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(DesignTokens.spaceMd),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spaceMd,
                  vertical: DesignTokens.spaceSm,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Text('🪙', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 4),
                    Text(
                      '${userDetails.coins ?? 0}',
                      style: TextStyle(
                        color: Colors.orange[700],
                        fontWeight: DesignTokens.fontWeightBold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocListener<MonerooPaymentCubit, MonerooPaymentState>(
        listener: (context, state) {
          if (state is MonerooPaymentSuccess) {
            showCustomSnackbar(
              context: context,
              message: 'Payment successful! ${state.coins} coins added',
              type: SnackbarType.success,
            );
            context.read<UserDetailsCubit>().updateCoins(
                  addCoin: true,
                  coins: state.coins,
                );
          } else if (state is MonerooPaymentError) {
            showCustomSnackbar(
              context: context,
              message: 'Payment failed: ${state.error}',
              type: SnackbarType.error,
            );
          }
        },
        child: BlocBuilder<MonerooPaymentCubit, MonerooPaymentState>(
          builder: (context, paymentState) {
            if (paymentState is MonerooPaymentProcessing) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Processing payment...'),
                  ],
                ),
              );
            }

            if (_isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return RefreshIndicator(
              onRefresh: _loadData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(DesignTokens.spaceLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_error != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.orange[300]!),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline, color: Colors.orange[700]),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Using default packages',
                                style: TextStyle(color: Colors.orange[900]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (_monerooConfig?.isTestMode == true)
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.amber[300]!),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.warning_amber, color: Colors.amber[700]),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Test Mode: Payments will not be processed',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Text(
                      'Choose Your Package',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: DesignTokens.fontWeightBold,
                            color: DesignTokens.textPrimary,
                          ),
                    ),
                    const SizedBox(height: DesignTokens.spaceMd),
                    Text(
                      'Buy coins to unlock premium features',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: DesignTokens.textSecondary,
                          ),
                    ),
                    const SizedBox(height: DesignTokens.spaceLg),
                    ..._packages.map((package) => _buildPackageCard(package)),
                    const SizedBox(height: DesignTokens.spaceLg),
                    Container(
                      padding: const EdgeInsets.all(DesignTokens.spaceMd),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.security, color: Colors.blue[700]),
                              const SizedBox(width: 8),
                              Text(
                                'Secure Payment',
                                style: TextStyle(
                                  fontWeight: DesignTokens.fontWeightBold,
                                  color: Colors.blue[900],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Powered by Moneroo - Your payment information is encrypted and secure',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPackageCard(CoinPackage package) {
    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spaceMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: package.popular
            ? Border.all(color: DesignTokens.primary, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (package.popular)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: DesignTokens.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'POPULAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(DesignTokens.spaceLg),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '🪙',
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                const SizedBox(width: DesignTokens.spaceMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${package.totalCoins} Coins',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (package.bonus != null && package.bonus! > 0)
                        Text(
                          package.bonusDisplay,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        package.priceDisplay,
                        style: TextStyle(
                          fontSize: 16,
                          color: DesignTokens.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                IbeereButton(
                  text: 'Buy',
                  onPressed: () => _purchasePackage(package),
                  variant: package.popular
                      ? ButtonVariant.primary
                      : ButtonVariant.secondary,
                  size: ButtonSize.small,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
