import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class MeetLink extends StatefulWidget {
  const MeetLink({super.key});

  @override
  State<MeetLink> createState() => _MeetLinkState();
}

class _MeetLinkState extends State<MeetLink> {
  static const ANDROID_CLIENT_ID = "744230371015-1l0t6ae2762ruva9pois8pe89s5u3lek.apps.googleusercontent.com";
  static const IOS_CLIENT_ID = "83438011766-mdg2uuf0t4q5q9lgj4v4631vlrvcui2m.apps.googleusercontent.com";
  static const WEB_ID = "83438011766-dtelli22bbv5f7ql6lnpvgmv8tr93t14.apps.googleusercontent.com";
  String id = "";
  var calendar;

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      id = ANDROID_CLIENT_ID;
      print('Using app client ID');
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      id = IOS_CLIENT_ID;
    } else {
      id = WEB_ID;
      print('Using web client ID');
    }
    print('yay');
    List<EventAttendee> attendees = [
      EventAttendee(email: 'saimr036@gmail.com'),
      EventAttendee(email: 'saimur036@gmail.com')
    ];

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ElevatedButton(
              child: Text('Create Meet Link'),
              onPressed: () async {
                var _clientID = ClientId(id, "");
                const _scopes = [cal.CalendarApi.calendarEventsScope];
                void prompt(String url) async {
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }

                print('Attempting to authenticate');
                await clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) async {
                  calendar = cal.CalendarApi(client);
                  print('Authenticated successfully');
                }).catchError((error) {
                  print('Error during authentication: $error');
                });

                Event event = Event();
                event.description = "Therapy Class";
                event.location = "Online";
                event.start = EventDateTime(dateTime: DateTime(2024, 8, 4, 21, 0), timeZone: 'Pakistan/Islamabad');
                event.end = EventDateTime(dateTime: DateTime(2024, 8, 4, 21, 30), timeZone: 'Pakistan/Islamabad');
                event.conferenceData = ConferenceData(
                  createRequest: CreateConferenceRequest(
                    requestId: "sample123",
                    conferenceSolutionKey: ConferenceSolutionKey(type: "hangoutsMeet"),
                  ),
                );
                event.attendees = attendees;

                try {
                  await calendar.events.insert(event, "primary", conferenceDataVersion: 1, sendUpdates: "all").then((value) {
                    print("Event Status: ${value.status}");
                    if (value.status == "confirmed") {
                      var joiningLink = value.conferenceData?.entryPoints?.first.uri;
                      print("Joining Link: $joiningLink");
                    } else {
                      print("Unable to add event to Google Calendar");
                    }
                  });
                } catch (e) {
                  print('Error creating event: $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
