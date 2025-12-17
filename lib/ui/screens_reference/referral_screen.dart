import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';
import '../widgets/ibeere_buttons.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({Key? key}) : super(key: key);

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  final List<Map<String, dynamic>> _referrals = [
    {
      'name': 'Alice Johnson',
      'status': 'Active',
      'joinedDate': '2025-01-15',
      'reward': '200',
    },
    {
      'name': 'Bob Smith',
      'status': 'Active',
      'joinedDate': '2025-01-20',
      'reward': '200',
    },
    {
      'name': 'Carol Davis',
      'status': 'Pending',
      'joinedDate': null,
      'reward': '0',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final activeReferrals = _referrals.where((r) => r['status'] == 'Active').length;
    final totalEarnings = int.parse(
      _referrals
          .where((r) => r['status'] == 'Active')
          .fold<int>(0, (sum, r) => sum + int.parse(r['reward']))
          .toString(),
    );

    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        backgroundColor: DesignTokens.background,
        elevation: 0,
        title: Text(
          'Refer & Earn',
          style: TextStyle(
            color: DesignTokens.primary,
            fontWeight: DesignTokens.fontWeightBold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: DesignTokens.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(DesignTokens.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              padding: EdgeInsets.all(DesignTokens.spaceLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [DesignTokens.primary, Colors.blue[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Refer & Earn',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeLg,
                      color: Colors.white,
                      fontWeight: DesignTokens.fontWeightBold,
                    ),
                  ),
                  SizedBox(height: DesignTokens.spaceSm),
                  Text(
                    'Invite friends and earn 200 coins per referral',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBase,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: DesignTokens.spaceXl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Active Referrals',
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeSm,
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            '$activeReferrals',
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeXl,
                              color: Colors.white,
                              fontWeight: DesignTokens.fontWeightBold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Total Earnings',
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeSm,
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            '$totalEarnings coins',
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeXl,
                              color: Colors.white,
                              fontWeight: DesignTokens.fontWeightBold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: DesignTokens.spaceXxl),

            // Referral Code
            Text(
              'Your Referral Code',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: DesignTokens.fontWeightBold,
              ),
            ),
            SizedBox(height: DesignTokens.spaceMd),
            Container(
              padding: EdgeInsets.all(DesignTokens.spaceMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                border: Border.all(color: Colors.grey[200] ?? Colors.grey),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Share this code with friends',
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeSm,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'JOHN2024',
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeLg,
                            fontWeight: DesignTokens.fontWeightBold,
                            color: DesignTokens.primary,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Code copied to clipboard!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(DesignTokens.spaceMd),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                      ),
                      child: Icon(Icons.copy, color: DesignTokens.primary),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: DesignTokens.spaceXl),

            IbeerePrimaryButton(
              label: 'Share Referral Link',
              isFullWidth: true,
              onPressed: () {},
            ),
            SizedBox(height: DesignTokens.spaceXxl),

            // Referrals List
            Text(
              'Your Referrals',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: DesignTokens.fontWeightBold,
              ),
            ),
            SizedBox(height: DesignTokens.spaceMd),
            ..._referrals.map((referral) {
              final isActive = referral['status'] == 'Active';
              return Container(
                margin: EdgeInsets.only(bottom: DesignTokens.spaceMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  border: Border.all(color: Colors.grey[200] ?? Colors.grey),
                ),
                child: Padding(
                  padding: EdgeInsets.all(DesignTokens.spaceMd),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isActive ? Colors.green[100] : Colors.orange[100],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.person_rounded,
                            color: isActive ? Colors.green[700] : Colors.orange[700],
                            size: 24,
                          ),
                        ),
                      ),
                      SizedBox(width: DesignTokens.spaceMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              referral['name'] as String,
                              style: TextStyle(
                                fontSize: DesignTokens.fontSizeBase,
                                fontWeight: DesignTokens.fontWeightBold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              isActive
                                  ? 'Joined ${referral['joinedDate']}'
                                  : 'Pending activation',
                              style: TextStyle(
                                fontSize: DesignTokens.fontSizeSm,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: DesignTokens.spaceSm,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isActive ? Colors.green[100] : Colors.orange[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '+${referral['reward']} coins',
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeSm,
                            color: isActive ? Colors.green[700] : Colors.orange[700],
                            fontWeight: DesignTokens.fontWeightBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
