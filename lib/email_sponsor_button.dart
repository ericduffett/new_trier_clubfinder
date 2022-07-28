import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'club.dart';

class EmailSponsorButton extends StatelessWidget {

  final Club club;

  const EmailSponsorButton({Key? key, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(0, 6, 6, 6))
      ),
      child: const Text('Email Sponsor'),
      onPressed: () async {
        final Email email = Email(
          body: 'I found your club on the New Trier Club Finder app. Can you please send me more information about ${club.clubName} including information about the next meeting?\n\nThank you!',
          subject: 'Interested in ${club.clubName}',
          recipients: [club.sponsor1Email ?? ''],
        );

        await FlutterEmailSender.send(email);

      },
    );
  }
}
