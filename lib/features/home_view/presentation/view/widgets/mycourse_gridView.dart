import 'package:flutter/material.dart';
import 'package:graduation/features/home_view/presentation/view/widgets/course_item.dart';

class MycourseGridView extends StatelessWidget {
  const MycourseGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        clipBehavior: Clip.none,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 5,
          childAspectRatio: .65,
          mainAxisSpacing: 0,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => const CourseItem(),
      ),
    );
  }
}
