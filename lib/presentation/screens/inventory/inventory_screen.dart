import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Sample data - will be replaced with actual data
  final List<Map<String, dynamic>> _primes = [
    {'value': 2, 'count': 5, 'usage': 25},
    {'value': 3, 'count': 3, 'usage': 18},
    {'value': 5, 'count': 2, 'usage': 12},
    {'value': 7, 'count': 1, 'usage': 8},
    {'value': 11, 'count': 1, 'usage': 5},
    {'value': 13, 'count': 0, 'usage': 3},
    {'value': 17, 'count': 1, 'usage': 2},
    {'value': 19, 'count': 0, 'usage': 1},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prime Inventory'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: Colors.white,
          unselectedLabelColor: AppColors.onSurfaceVariant,
          tabs: [
            Tab(
              icon: Icon(Icons.inventory, color: null), // Use tab bar's color scheme
              text: 'Inventory',
            ),
            Tab(
              icon: Icon(Icons.book, color: null), // Use tab bar's color scheme
              text: 'Collection',
            ),
            Tab(
              icon: Icon(Icons.analytics, color: null), // Use tab bar's color scheme
              text: 'Statistics',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildInventoryTab(),
          _buildCollectionTab(),
          _buildStatisticsTab(),
        ],
      ),
    );
  }

  Widget _buildInventoryTab() {
    final availablePrimes = _primes.where((p) => p['count'] > 0).toList();
    
    return Column(
      children: [
        // Summary card
        Container(
          margin: const EdgeInsets.all(Dimensions.paddingM),
          padding: const EdgeInsets.all(Dimensions.paddingL),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(Dimensions.radiusM),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem(
                'Total Primes',
                _primes.fold(0, (sum, p) => sum + (p['count'] as int)).toString(),
                Icons.numbers,
              ),
              _buildSummaryItem(
                'Unique',
                availablePrimes.length.toString(),
                Icons.category,
              ),
              _buildSummaryItem(
                'Available',
                availablePrimes.length.toString(),
                Icons.check_circle,
              ),
            ],
          ),
        ),
        
        // Prime list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingM),
            itemCount: _primes.length,
            itemBuilder: (context, index) {
              final prime = _primes[index];
              return _buildPrimeItem(prime);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCollectionTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(Dimensions.paddingM),
      itemCount: _primes.length,
      itemBuilder: (context, index) {
        final prime = _primes[index];
        final isUnlocked = prime['usage'] > 0;
        
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isUnlocked 
                  ? AppColors.primary 
                  : AppColors.surfaceVariant,
              child: Text(
                prime['value'].toString(),
                style: AppTextStyles.labelLarge.copyWith(
                  color: isUnlocked 
                      ? AppColors.onPrimary 
                      : AppColors.onSurfaceVariant,
                ),
              ),
            ),
            title: Text(
              'Prime ${prime['value']}',
              style: AppTextStyles.titleMedium.copyWith(
                color: isUnlocked 
                    ? AppColors.onSurface 
                    : AppColors.onSurfaceVariant,
              ),
            ),
            subtitle: Text(
              isUnlocked 
                  ? 'First obtained: 2 days ago'
                  : 'Not yet discovered',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.all(Dimensions.paddingXs),
              decoration: BoxDecoration(
                color: isUnlocked 
                    ? AppColors.victoryGreen.withOpacity(0.1)
                    : AppColors.surface,
                borderRadius: BorderRadius.circular(Dimensions.radiusS),
                border: Border.all(
                  color: isUnlocked 
                      ? AppColors.victoryGreen
                      : AppColors.outline,
                  width: 1,
                ),
              ),
              child: Icon(
                isUnlocked ? Icons.check_circle : Icons.lock,
                color: isUnlocked 
                    ? AppColors.victoryGreen
                    : AppColors.onSurfaceVariant,
                size: Dimensions.iconS,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatisticsTab() {
    final totalUsage = _primes.fold(0, (sum, p) => sum + (p['usage'] as int));
    final mostUsed = _primes.reduce((a, b) => 
        a['usage'] > b['usage'] ? a : b);
    
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Usage Statistics',
            style: AppTextStyles.headlineSmall,
          ),
          
          const SizedBox(height: Dimensions.spacingL),
          
          _buildStatCard(
            'Total Usage',
            totalUsage.toString(),
            'attacks made',
            Icons.gps_fixed,
            AppColors.primary,
          ),
          
          const SizedBox(height: Dimensions.spacingM),
          
          _buildStatCard(
            'Most Used Prime',
            mostUsed['value'].toString(),
            '${mostUsed['usage']} times',
            Icons.star,
            AppColors.victoryGreen,
          ),
          
          const SizedBox(height: Dimensions.spacingL),
          
          Text(
            'Prime Usage Chart',
            style: AppTextStyles.titleMedium,
          ),
          
          const SizedBox(height: Dimensions.spacingM),
          
          Expanded(
            child: ListView.builder(
              itemCount: _primes.length,
              itemBuilder: (context, index) {
                final prime = _primes[index];
                final usage = prime['usage'] as int;
                final percentage = totalUsage > 0 ? usage / totalUsage : 0.0;
                
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.spacingXs),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        child: Text(
                          prime['value'].toString(),
                          style: AppTextStyles.labelMedium,
                        ),
                      ),
                      
                      const SizedBox(width: Dimensions.spacingM),
                      
                      Expanded(
                        child: LinearProgressIndicator(
                          value: percentage,
                          backgroundColor: AppColors.surfaceVariant,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: Dimensions.spacingM),
                      
                      SizedBox(
                        width: 40,
                        child: Text(
                          usage.toString(),
                          style: AppTextStyles.labelMedium,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(Dimensions.paddingS),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(Dimensions.radiusS),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: Dimensions.iconM,
          ),
        ),
        const SizedBox(height: Dimensions.spacingXs),
        Text(
          value,
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.onPrimaryContainer,
          ),
        ),
      ],
    );
  }

  Widget _buildPrimeItem(Map<String, dynamic> prime) {
    final isAvailable = prime['count'] > 0;
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: Dimensions.spacingXs),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isAvailable ? AppColors.primary : AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(Dimensions.radiusM),
          ),
          child: Center(
            child: Text(
              prime['value'].toString(),
              style: AppTextStyles.titleMedium.copyWith(
                color: isAvailable ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title: Text(
          'Prime ${prime['value']}',
          style: AppTextStyles.titleMedium,
        ),
        subtitle: Text(
          'Used ${prime['usage']} times',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingM,
            vertical: Dimensions.paddingS,
          ),
          decoration: BoxDecoration(
            color: isAvailable 
                ? AppColors.primaryContainer 
                : AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(Dimensions.radiusS),
          ),
          child: Text(
            'x${prime['count']}',
            style: AppTextStyles.labelLarge.copyWith(
              color: isAvailable 
                  ? AppColors.onPrimaryContainer 
                  : AppColors.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingL),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(Dimensions.radiusM),
                border: Border.all(
                  color: color.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Icon(
                icon,
                color: color,
                size: Dimensions.iconL,
              ),
            ),
            
            const SizedBox(width: Dimensions.spacingL),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.titleMedium,
                  ),
                  const SizedBox(height: Dimensions.spacingXs),
                  Text(
                    value,
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}