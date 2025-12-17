import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutterquiz/core/constants/api_exception.dart';
import 'package:flutterquiz/core/constants/constants.dart';

class MonerooConfigService {
  static const String _getMonerooSettingsUrl = '$baseUrl/get_moneroo_settings';

  static Future<MonerooConfig> fetchConfig() async {
    try {
      final response = await http.get(
        Uri.parse(_getMonerooSettingsUrl),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        
        if (data['error'] == true || data['error'] == 1) {
          throw ApiException(data['message']?.toString() ?? 'Failed to fetch Moneroo config');
        }

        final configData = data['data'] as Map<String, dynamic>? ?? {};
        return MonerooConfig.fromJson(configData);
      } else {
        throw ApiException('Server error: ${response.statusCode}');
      }
    } on SocketException {
      throw const ApiException(errorCodeNoInternet);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Failed to load Moneroo config: ${e.toString()}');
    }
  }

  static Future<List<CoinPackage>> fetchCoinPackages() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/get_coin_store'),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        
        if (data['error'] == true || data['error'] == 1) {
          return _getDefaultPackages();
        }

        final packagesData = data['data'] as List<dynamic>? ?? [];
        return packagesData
            .map((item) => CoinPackage.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        return _getDefaultPackages();
      }
    } catch (e) {
      return _getDefaultPackages();
    }
  }

  static List<CoinPackage> _getDefaultPackages() {
    return [
      CoinPackage(
        id: '1',
        coins: 100,
        price: 1.99,
        currency: 'USD',
        productId: 'coins_100',
      ),
      CoinPackage(
        id: '2',
        coins: 500,
        price: 8.99,
        currency: 'USD',
        productId: 'coins_500',
        popular: true,
      ),
      CoinPackage(
        id: '3',
        coins: 1000,
        price: 15.99,
        currency: 'USD',
        productId: 'coins_1000',
      ),
      CoinPackage(
        id: '4',
        coins: 2500,
        price: 34.99,
        currency: 'USD',
        productId: 'coins_2500',
      ),
    ];
  }
}

class MonerooConfig {
  final String appId;
  final String? apiKey;
  final bool isTestMode;
  final bool isEnabled;
  final String webhookUrl;

  MonerooConfig({
    required this.appId,
    this.apiKey,
    required this.isTestMode,
    required this.isEnabled,
    required this.webhookUrl,
  });

  factory MonerooConfig.fromJson(Map<String, dynamic> json) {
    final mode = json['moneroo_mode']?.toString() ?? 'test';
    final isTest = mode == 'test';

    return MonerooConfig(
      appId: isTest
          ? (json['moneroo_test_app_id']?.toString() ?? '')
          : (json['moneroo_app_id']?.toString() ?? ''),
      apiKey: isTest
          ? json['moneroo_test_api_key']?.toString()
          : json['moneroo_api_key']?.toString(),
      isTestMode: isTest,
      isEnabled: true,
      webhookUrl: json['moneroo_webhook_url']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'app_id': appId,
      'is_test_mode': isTestMode,
      'is_enabled': isEnabled,
      'webhook_url': webhookUrl,
    };
  }

  bool get isConfigured => appId.isNotEmpty;
}

class CoinPackage {
  final String id;
  final int coins;
  final double price;
  final String currency;
  final String productId;
  final bool popular;
  final int? bonus;

  CoinPackage({
    required this.id,
    required this.coins,
    required this.price,
    required this.currency,
    required this.productId,
    this.popular = false,
    this.bonus,
  });

  factory CoinPackage.fromJson(Map<String, dynamic> json) {
    return CoinPackage(
      id: json['id']?.toString() ?? '',
      coins: int.tryParse(json['coins']?.toString() ?? '0') ?? 0,
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      currency: json['currency']?.toString() ?? 'USD',
      productId: json['product_id']?.toString() ?? '',
      popular: json['popular'] == '1' || json['popular'] == true,
      bonus: json['bonus'] != null ? int.tryParse(json['bonus'].toString()) : null,
    );
  }

  String get priceDisplay => '$currency ${price.toStringAsFixed(2)}';
  
  int get totalCoins => coins + (bonus ?? 0);
  
  String get bonusDisplay => bonus != null && bonus! > 0 ? '+$bonus bonus' : '';
}
