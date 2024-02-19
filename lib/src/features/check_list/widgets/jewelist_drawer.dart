import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jewelist/src/constants/constants.dart';
import 'package:jewelist/src/core/core.dart';
import 'package:jewelist/src/features/check_list/controllers/controllers.dart';
import 'package:transparent_image/transparent_image.dart';

class JewelistDrawer extends ConsumerWidget {
  const JewelistDrawer({super.key});

  void showLicense(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: AppConstants.applicationName,
      applicationVersion: AppConstants.applicationVersion,
      applicationLegalese: AppConstants.applicationLegalese,
      applicationIcon: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            width: 12,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage.memoryNetwork(
            image: resizeCloudinaryImage(AppConstants.devProfilePic),
            placeholder: kTransparentImage,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) => const Icon(
              Icons.inventory_2_outlined,
              size: 56,
            ),
          ),
        ),
      ),
    );
  }

  void deleteAllItems(BuildContext context, WidgetRef ref) {
    ref.read(checklistControllerProvider.notifier).deleteAllItems(context);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.list_alt_outlined,
                    size: 80,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.delete_outline),
                  title: const Text('Clear List'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: SizedBox(
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Delete all items?',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Back'),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).colorScheme.error,
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                      onPressed: () =>
                                          deleteAllItems(context, ref),
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25.0),
            child: ListTile(
              leading: const Icon(Icons.verified_outlined),
              title: const Text('License'),
              onTap: () => showLicense(context),
            ),
          ),
        ],
      ),
    );
  }
}
