import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../app_managers/assets_managers.dart';

class NoOffer extends StatefulWidget {
  final VoidCallback? onRetry;

  const NoOffer({super.key, this.onRetry});

  @override
  State<NoOffer> createState() => _NoOfferState();
}

class _NoOfferState extends State<NoOffer> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Image(
            //   width:200,
            //   image: AssetImage(
            //     AssetManager.noOffer,
            //   ),
            //   fit: BoxFit.cover,
            // ),
            Gap(12),
            Text(
              'No machine available',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF42526D),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'There are no any machines on this section',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF4A4A4A),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Gap(12),
          ],
        ),
      ),
    );
  }
}
