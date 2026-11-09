import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    this.onTap,
  });

  final int id;
  final String title;
  final String description;
  final String? image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const imageWidth = 100.0;
    const imageHeight = 150.0;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: SizedBox(
        height: imageHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                image ?? '',
                height: imageHeight,
                width: imageWidth,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: imageHeight,
                    width: imageWidth,
                    color: Colors.grey.shade300,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image_not_supported,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Text(
                      description,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
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
