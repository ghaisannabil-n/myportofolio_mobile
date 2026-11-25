import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/experience.dart';

class ExperienceDetailScreen extends StatelessWidget {
  const ExperienceDetailScreen({required this.experience, super.key});

  final Experience experience;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final categoryLabel = experience.categoryDisplay.isNotEmpty
        ? experience.categoryDisplay
        : experience.category;
    final imageUrl = experience.thumbnail.isNotEmpty
        ? experience.thumbnail
        : experience.experienceImg;

    return Scaffold(
      appBar: AppBar(title: Text(experience.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl.isNotEmpty)
                Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const SizedBox.shrink(),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience.title,
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),
                    _DetailRow(
                      icon: Icons.category_outlined,
                      label: 'Category',
                      value: categoryLabel,
                    ),
                    const SizedBox(height: 8),
                    _DetailRow(
                      icon: Icons.timelapse_outlined,
                      label: 'Status',
                      value: experience.isOngoing ? 'Ongoing' : 'Completed',
                    ),
                    const SizedBox(height: 8),
                    _DetailRow(
                      icon: Icons.star_outline,
                      label: 'Stars',
                      value:
                          '${experience.starCount}'
                          '${experience.isStarred ? ' (Starred by you)' : ''}',
                    ),
                    if (experience.starredByNames.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      _DetailRow(
                        icon: Icons.people_outline,
                        label: 'Starred By',
                        value: experience.starredByNames,
                      ),
                    ],
                    const Divider(height: 28),
                    Text(
                      'Description',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      experience.description.isEmpty
                          ? 'No description provided.'
                          : experience.description,
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
