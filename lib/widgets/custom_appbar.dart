import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/provider/navigation_provider.dart';
import '../constants/colors.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({super.key});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  // The selected index is now read from NavigationProvider to keep
  // the UI in sync with programmatic changes to navigation.

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return Container(
      width: double.infinity,
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 47),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LOGO
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Image.asset("assets/images/logo.png", height: 24),
                SizedBox(width: 8),
                Text(
                  "Wallpaper Studio",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          _buildNavItems(navigationProvider),
        ],
      ),
    );
  }

  Widget _buildNavItems(NavigationProvider navigationProvider) {
    final List<Map<String, dynamic>> navItems = [
      {'icon': Icons.home_outlined, 'label': 'Home'},
      {'icon': Icons.grid_on_outlined, 'label': 'Browse'},
      {'icon': Icons.favorite_border, 'label': 'Favorites'},
      {'icon': Icons.settings_outlined, 'label': 'Settings'},
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children:
          navItems.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> item = entry.value;
            bool isSelected = navigationProvider.selectedIndex == index;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  // Update provider; provider change will rebuild this widget
                  // and keep the visual indicator in sync.
                  context.read<NavigationProvider>().setSelectedIndex(index);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? Colors.grey.withOpacity(0.1)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Icon(
                        item['icon'] as IconData,
                        size: 20,
                        color: Colors.grey[700],
                      ),
                      SizedBox(width: 8),
                      Text(
                        item['label'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: AppColors.blackSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
