// import 'package:flutter/material.dart';
//
// class GridViewItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;
//   final Color color;
//
//   const GridViewItem({
//     Key? key,
//     required this.icon,
//     required this.label,
//     required this.onTap,
//     required this.color,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(16),
//           // boxShadow: [
//           //   BoxShadow(
//           //     color: Colors.grey.shade300,
//           //     blurRadius: 6,
//           //     offset: Offset(2, 2),
//           //   ),
//           // ],
//         ),
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 40, color: color),
//             const SizedBox(height: 8),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: color,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:project/app/app_colors.dart';

class GridViewItem extends StatelessWidget {
  final Widget  icon;
  final String label; //
  final VoidCallback onTap;


  const GridViewItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              //color: AppColors.themeColor.withOpacity(0.12),
              color: AppColors.themeColor.withOpacity(0.09),
              borderRadius: BorderRadius.circular(8),
            ),
            child:  SizedBox(
              width: 50,
              height: 40,
              child: icon, // This can now be any widget, including Lottie
            ),
          ),
          const SizedBox(height: 4), // Spacing between icon and label
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              //color: AppColors.themeColor,
              color: AppColors.themeColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),

    );
  }
}