import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class ReferralRewardsScreen extends StatefulWidget {
  const ReferralRewardsScreen({super.key});

  static const String routeName = '/referral-rewards';

  @override
  State<ReferralRewardsScreen> createState() => _ReferralRewardsScreenState();
}

class _ReferralRewardsScreenState extends State<ReferralRewardsScreen> {
  String _referralCode = '';
  int _referrerBonus = 500;
  int _refereeBonus = 500;
  int _totalReferrals = 0;
  int _totalEarnings = 0;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchReferralSettings();
  }

  Future<void> _fetchReferralSettings() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.ibeere.fun/api/get_referral_settings'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['error'] == false && data['data'] != null) {
          final settings = data['data'];
          setState(() {
            _referrerBonus = int.tryParse(settings['referrer_bonus_kauris'] ?? '500') ?? 500;
            _refereeBonus = int.tryParse(settings['referee_bonus_kauris'] ?? '500') ?? 500;
            _referralCode = _generateDemoCode();
            _isLoading = false;
          });
        } else {
          setState(() {
            _referralCode = _generateDemoCode();
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _referralCode = _generateDemoCode();
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Network error';
        _referralCode = _generateDemoCode();
        _isLoading = false;
      });
    }
  }

  String _generateDemoCode() {
    return 'IBEERE${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
  }

  void _copyReferralCode() {
    Clipboard.setData(ClipboardData(text: _referralCode));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Referral code copied to clipboard!'),
        backgroundColor: IbeereDesignTokens.primaryPurple,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _shareReferralCode() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing referral code: $_referralCode'),
        backgroundColor: IbeereDesignTokens.primaryPurple,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Refer & Earn',
          style: TextStyle(
            color: IbeereDesignTokens.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              IbeereDesignTokens.primaryPurple,
                              IbeereDesignTokens.primaryPink,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: IbeereDesignTokens.primaryPurple.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.campaign, color: Colors.white, size: 32),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    'Refer your friends &\nEarn Kauris',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildBonusCard(
                                    'You Get',
                                    '$_referrerBonus Kauris',
                                    Icons.card_giftcard,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildBonusCard(
                                    'Friend Gets',
                                    '$_refereeBonus Kauris',
                                    Icons.people,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 20,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 30,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Your Referral Code',
                          style: TextStyle(
                            color: IbeereDesignTokens.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: IbeereDesignTokens.primaryPurple.withOpacity(0.2),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _referralCode,
                                style: TextStyle(
                                  color: IbeereDesignTokens.primaryPurple,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _copyReferralCode,
                                icon: const Icon(Icons.copy, size: 20),
                                label: const Text('Copy Code'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: IbeereDesignTokens.primaryPurple,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _shareReferralCode,
                                icon: const Icon(Icons.share, size: 20),
                                label: const Text('Share'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: IbeereDesignTokens.primaryPink,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        _buildStatsCard(),
                        const SizedBox(height: 24),
                        _buildHowItWorks(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildBonusCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Your Referral Stats',
            style: TextStyle(
              color: IbeereDesignTokens.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildStatItem('Total Referrals', _totalReferrals.toString(), Icons.people),
              ),
              Container(
                width: 1,
                height: 40,
                color: IbeereDesignTokens.textTertiary.withOpacity(0.2),
              ),
              Expanded(
                child: _buildStatItem('Total Earnings', '$_totalEarnings K', Icons.stars),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: IbeereDesignTokens.primaryPurple, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: IbeereDesignTokens.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: IbeereDesignTokens.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildHowItWorks() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How It Works',
            style: TextStyle(
              color: IbeereDesignTokens.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildStep('1', 'Share your referral code', Icons.share),
          const SizedBox(height: 12),
          _buildStep('2', 'Friend signs up with your code', Icons.person_add),
          const SizedBox(height: 12),
          _buildStep('3', 'Both get bonus Kauris!', Icons.celebration),
        ],
      ),
    );
  }

  Widget _buildStep(String number, String text, IconData icon) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                IbeereDesignTokens.primaryPurple,
                IbeereDesignTokens.primaryPink,
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: IbeereDesignTokens.textSecondary,
              fontSize: 14,
            ),
          ),
        ),
        Icon(icon, color: IbeereDesignTokens.primaryPurple.withOpacity(0.5), size: 20),
      ],
    );
  }
}
