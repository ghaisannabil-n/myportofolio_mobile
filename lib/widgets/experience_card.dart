import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/experience_list_screen.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard(this.item, {super.key});

  final ItemHomepage item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          if (item.name == 'Lihat Experience') {
            await Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const ExperienceListScreen(),
              ),
            );
            return;
          }

          if (item.name == 'Tambah Experience') {
            final ok = await ensureLoggedIn(context);
            if (!context.mounted || !ok) return;
            await Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const ExperienceFormPage(),
              ),
            );
            return;
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
