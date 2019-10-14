import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cdr_today/blocs/community.dart';
import 'package:cdr_today/pages/reddit.dart';
import 'package:cdr_today/pages/bucket.dart';
import 'package:cdr_today/widgets/name.dart';
import 'package:cdr_today/widgets/buttons.dart';
import 'package:cdr_today/widgets/drawer.dart';
import 'package:cdr_today/widgets/refresh.dart';
import 'package:cdr_today/widgets/sheets.dart';
import 'package:cdr_today/widgets/actions.dart';
import 'package:cdr_today/x/_style/color.dart';

class InitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityBloc, CommunityState>(
      builder: (context, state) {
        if ((state as Communities).current == '') {
          return Bucket();
        }

        return CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: <BottomNavigationBarItem> [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.conversation_bubble)
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.group)
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.profile_circled)
              )
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoTabView(
              builder: (BuildContext context) {
                return Container();
              }
            );
          }
        );
        
        return CupertinoPageScaffold(
          child: Reddit(
            appBar: CupertinoSliverNavigationBar(
              largeTitle: Container(),
              middle: RedditRefresher(widget: CommunityName(qr: true)),
              trailing: CtNoRipple(icon: Icons.edit)
            ),
          ),
          resizeToAvoidBottomInset: false,
        );
      }
    );
  }
}
