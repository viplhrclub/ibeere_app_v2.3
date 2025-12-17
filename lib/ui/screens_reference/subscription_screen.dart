import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';
import '../widgets/ibeere_buttons.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String _selectedPlan = 'pro';
  bool _isAnnual = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        backgroundColor: DesignTokens.background,
        elevation: 0,
        title: Text(
          'Premium Membership',
          style: TextStyle(
            color: DesignTokens.primary,
            fontWeight: DesignTokens.fontWeightBold,
            fontSize: DesignTokens.fontSizeLg,
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
            // Billing Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Monthly',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase,
                    fontWeight: _isAnnual ? DesignTokens.fontWeightRegular : DesignTokens.fontWeightBold,
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _isAnnual = !_isAnnual),
                  child: Container(
                    width: 60,
                    height: 32,
                    decoration: BoxDecoration(
                      color: _isAnnual ? DesignTokens.primary : Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedPositioned(
                          left: _isAnnual ? 32 : 2,
                          duration: Duration(milliseconds: 200),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Yearly',
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeBase,
                        fontWeight: !_isAnnual ? DesignTokens.fontWeightRegular : DesignTokens.fontWeightBold,
                      ),
                    ),
                    if (_isAnnual)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: DesignTokens.spaceSm,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Save 30%',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: DesignTokens.fontWeightBold,
                            color: Colors.red[700],
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(height: DesignTokens.spaceXxl),

            // Plans
            _buildPlanCard(
              title: 'Free',
              price: '₹0',
              period: 'Forever',
              isSelected: _selectedPlan == 'free',
              features: [
                'Unlimited quizzes',
                'Basic categories',
                'Community support',
                'Limited analytics',
              ],
              onTap: () => setState(() => _selectedPlan = 'free'),
            ),
            SizedBox(height: DesignTokens.spaceLg),

            _buildPlanCard(
              title: 'Pro',
              price: _isAnnual ? '₹1,999' : '₹299',
              period: _isAnnual ? 'per year' : 'per month',
              isSelected: _selectedPlan == 'pro',
              features: [
                'Everything in Free +',
                'Ad-free experience',
                'Premium content',
                'Detailed analytics',
                'Offline access',
                'Priority support',
              ],
              highlight: true,
              onTap: () => setState(() => _selectedPlan = 'pro'),
            ),
            SizedBox(height: DesignTokens.spaceLg),

            _buildPlanCard(
              title: 'Expert',
              price: _isAnnual ? '₹4,999' : '₹599',
              period: _isAnnual ? 'per year' : 'per month',
              isSelected: _selectedPlan == 'expert',
              features: [
                'Everything in Pro +',
                'Expert interviews',
                'Custom content',
                'One-on-one tutoring',
                'Certificate programs',
                'Dedicated support',
              ],
              onTap: () => setState(() => _selectedPlan = 'expert'),
            ),
            SizedBox(height: DesignTokens.spaceXxl),

            // Continue Button
            IbeerePrimaryButton(
              label: _selectedPlan == 'free' ? 'Keep Free Plan' : 'Subscribe Now',
              isFullWidth: true,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Plan selection: $_selectedPlan'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            SizedBox(height: DesignTokens.spaceLg),

            // Terms
            Center(
              child: Text(
                'Subscription renews automatically. Cancel anytime.',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeSm,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required String period,
    required bool isSelected,
    required List<String> features,
    required VoidCallback onTap,
    bool highlight = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? DesignTokens.primary : Colors.grey[300] ?? Colors.grey,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          boxShadow: highlight
              ? [
            BoxShadow(
              color: DesignTokens.primary.withOpacity(0.1),
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ]
              : null,
        ),
        child: Stack(
          children: [
            if (highlight)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      DesignTokens.primary.withOpacity(0.05),
                      Colors.transparent,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(DesignTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: DesignTokens.fontSizeLg,
                          fontWeight: DesignTokens.fontWeightBold,
                        ),
                      ),
                      if (isSelected)
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: DesignTokens.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: DesignTokens.spaceMd),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: price,
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeXxl,
                            fontWeight: DesignTokens.fontWeightBold,
                            color: DesignTokens.primary,
                          ),
                        ),
                        TextSpan(
                          text: ' / $period',
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeSm,
                            color: Colors.grey[600],
                            fontWeight: DesignTokens.fontWeightMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: DesignTokens.spaceLg),
                  ...features.map((feature) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: DesignTokens.spaceMd),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: DesignTokens.primary,
                            size: 20,
                          ),
                          SizedBox(width: DesignTokens.spaceMd),
                          Expanded(
                            child: Text(
                              feature,
                              style: TextStyle(
                                fontSize: DesignTokens.fontSizeBase,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
