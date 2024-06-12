// Notifications Tab  
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stay_travel_v3/bloc/messages/messages_bloc.dart';
import 'package:stay_travel_v3/bloc/messages/messages_event.dart';
import 'package:stay_travel_v3/bloc/messages/messages_state.dart';
import 'package:stay_travel_v3/models/message.dart';
import 'package:stay_travel_v3/widgets/notification_card.dart';

class NotificationsTab extends StatefulWidget {
  const NotificationsTab({super.key});

  @override
  State<NotificationsTab> createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab> {

  @override
  void initState() {
    context.read<MessagesBloc>().add(FetchMessages());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Уведомления'),
        actions: [
          IconButton(onPressed: () {

          }, icon: const Icon(Icons.clear_all)),
          IconButton(onPressed: () {
                context.read<MessagesBloc>().add(FetchMessages());

          }, icon: const Icon(Icons.refresh))
        ],
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MessagesBloc, MessageState>(builder: (context, state) {
          if (state is MessageLoaded) {
            return CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverList(delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    Message message = state.messages[index];
                    
                    NotificationType type = message.status == 'active' ? NotificationType.success : message.status == 'notApproved' ? NotificationType.warning : NotificationType.information;


                    return NotificationCard(
                      notificationType: type, 
                      notificationText: message.message
                    );
        
                  },
                  childCount: state.messages.length
                ))
              ],
            );
          } else if (state is MessageLoading) {
            return Center(child: SizedBox(
              width: 50,
              height: 50,
              child: LoadingIndicator(indicatorType: Indicator.ballSpinFadeLoader)));
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}