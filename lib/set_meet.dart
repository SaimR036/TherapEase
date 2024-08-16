  import 'package:flutter/material.dart';
  import 'package:flutter/src/widgets/framework.dart';
  import 'package:flutter/src/widgets/container.dart';
  import 'package:googleapis/authorizedbuyersmarketplace/v1.dart';
  import 'package:googleapis/calendar/v3.dart' as cal;
  import 'package:googleapis/calendar/v3.dart';
  import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

  import 'package:googleapis_auth/auth_io.dart';
  import 'package:url_launcher/url_launcher.dart';

  import 'dart:io' show Platform;

  import 'package:googleapis/tagmanager/v2.dart';

  class MeetLink extends StatefulWidget {
    const MeetLink({super.key});

    @override
    State<MeetLink> createState() => _MeetLinkState();
  }

  class _MeetLinkState extends State<MeetLink> {
    static const ANDROID_CLIENT_ID = "83438011766-cj0djbib4et1mfmmrfn76fp8ov4si25v.apps.googleusercontent.com";
    static const IOS_CLIENT_ID = "83438011766-mdg2uuf0t4q5q9lgj4v4631vlrvcui2m.apps.googleusercontent.com";
    static const WEB_ID ="83438011766-dtelli22bbv5f7ql6lnpvgmv8tr93t14.apps.googleusercontent.com";
    String id="";
    var calendar;
    @override
    Widget build(BuildContext context) {
      if (defaultTargetPlatform == TargetPlatform.android)
      {
        id  =ANDROID_CLIENT_ID;
      }
      else if (defaultTargetPlatform == TargetPlatform.iOS)
      {
        id = IOS_CLIENT_ID;
      }
      else{
        id = WEB_ID;
        print('adas');
      }
      
      List<EventAttendee> attendees = [EventAttendee(email: 'saimr036@gmail.com'),
      EventAttendee(email: 'saimur036@gmail.com')
      ];
      return Scaffold(
        body: Stack(
          children: [

            ElevatedButton(
            child: Text('asd'),
            onPressed: () async{
            var _clientID =  ClientId(id, "");
            const _scopes = const [cal.CalendarApi.calendarScope];
            void prompt(String url) async {
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            }
            print('ad');
            await clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) async {
              calendar = cal.CalendarApi(client);
            });
            // print('ads');
            // Event event = Event();
            // event.description = "Therapy Class";
            // event.location = "Online";
            // event.start = EventDateTime(dateTime: DateTime(2024, 8, 4, 21,0),timeZone: 'Pakistan/Islamabad');
            // event.end = EventDateTime(dateTime: DateTime(2024, 8, 4, 21,30),timeZone: 'Pakistan/Islamabad');
            // event.conferenceData = ConferenceData(conferenceId: "Abc",conferenceSolution: ConferenceSolution(name: "meet",key: ConferenceSolutionKey(type: "hangoutsMeet")));
            // event.attendees = attendees;
            // calendar.events.insert(event, "primary");
            },)        ]));
    }
  }