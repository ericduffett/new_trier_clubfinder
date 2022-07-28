import 'package:flutter/material.dart';
import 'club.dart';
import 'email_sponsor_button.dart';


class ClubDetailsPage extends StatelessWidget {

  final Club club;

  const ClubDetailsPage({Key? key, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(club.clubName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Text(club.campus,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(club.description,
                style: const TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text('This club meets on ${club.stringMeetingDays} from ${club.clubMeetingTime} in ${club.clubMeetingLocation} on the ${club.campus}.',
                style: const TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text('Sponsor(s)',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Text(club.clubSponsorInfo,
              ),
              const SizedBox(
                height: 12.0,
              ),
              EmailSponsorButton(club: club),
            ],
          ),
        ),
      ),
    );
  }
}
