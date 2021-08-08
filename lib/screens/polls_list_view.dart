import 'package:citizen_feedback/blocs/auth/auth_bloc.dart';
import 'package:citizen_feedback/blocs/polling/poll_bloc.dart';
import 'package:citizen_feedback/blocs/polling/poll_event.dart';
import 'package:citizen_feedback/blocs/polling/poll_state.dart';
import 'package:citizen_feedback/models/poll_model.dart';
import 'package:citizen_feedback/screens/questions_view.dart';
import 'package:citizen_feedback/services/auth_repository.dart';
import 'package:citizen_feedback/services/poll_repository.dart';
import 'package:citizen_feedback/shared/exceptions/app_exception.dart';
import 'package:citizen_feedback/theme/theme.dart';
import 'package:citizen_feedback/widgets/polls/list_polls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class PollingView extends StatefulWidget {
//
//   @override
//   _PollingViewState createState() => _PollingViewState();
// }
//
// class _PollingViewState extends State<PollingView> {
//   PollBloc _pollBloc;
//
//   void initState() {
//     super.initState();
//     _pollBloc = context.read<PollBloc>();
//   }
//
//   // _loadPolls() async {
//   //   context.bloc<PollBloc>().add(PollEvent.fetchPolls);
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Albums'),
//       ),
//       body: Container(
//         child: _body(),
//       ),
//     );
//   }
//
//   _body() {
//     return Column(
//       children: [
//         BlocBuilder<PollBloc, PollState>(
//             builder: (BuildContext context, PollState state) {
//               if (state is PollListError) {
//                 final error = state.errors;
//                 return Text(error.message);
//               }
//               if (state is PollLoadedState) {
//                 List<Poll> polls = state.polls;
//                 return _list(polls);
//               }
//               return CircularProgressIndicator();
//             })
//       ],
//     );
//   }
//
//   Widget _list(List<Poll> polls) {
//     return Expanded(
//         child: ListView.builder(
//             itemCount: polls.length,
//             itemBuilder: (_, index) {
//               Poll poll = polls[index];
//               return ListPoll(poll: poll);
//             }));
//   }
//   // Widget _loading(){
//   //
//   // }
// }


// class PollingView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider(
//       create: (context) => PollBloc(
//         // context.read<P>(),
//       ),
//       child: BlocBuilder<PollBloc, PollState>(builder: (context, state) {
//         return Container(
//           color: FaintBlue,
//           child: ListView.builder(
//             itemBuilder: (BuildContext context, int index) {
//               context.read<PollBloc>().add(PollEvent.fetchPolls);
//               if (state != null) {
//                 // if (index < state.polls.length)
//                 //   return _buildRow(state.polls[index], context);
//                 return throw NoPollsException('No Polls found!');
//               } else
//                 return throw NoPollsException('No Polls found!');
//             },
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget _buildRow(Poll poll, BuildContext context) {
//     return Container(
//       padding: new EdgeInsets.all(10.0),
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         elevation: 2,
//         shadowColor: FaintBlueDeeper,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             ListTile(
//               leading: Icon(Icons.ballot_outlined, size: 50, color: Turquoise),
//               title: Text(poll.title, style: TextStyle(color: AccentColor)),
//               subtitle: Text(poll.description),
//               onTap: () {
//                 handleClick(context, poll.questions);
//               },
//             ),
//             ButtonBar(
//               children: <Widget>[
//                 FlatButton(
//                   child: const Text('Edit', style: OutlineButtonStyle),
//                   onPressed: () {},
//                 ),
//                 FlatButton(
//                   child: const Text('Start', style: OutlineButtonStyle),
//                   onPressed: () {
//                     handleClick(context, poll.questions);
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void handleClick(BuildContext context, List<Question> questions) {
//     //BlocProvider.of<SessionCubit>(context);
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => QuestionsView(questions: questions),
//       ),
//     );
//   }
// }

class PollView extends StatefulWidget {

  @override
  _PollViewState createState() => _PollViewState();
}

class _PollViewState extends State<PollView> {
  PollBloc pollBloc;

  @override
  void initState() {
    super.initState();
    pollBloc = BlocProvider.of<PollBloc>(context);
    pollBloc.add(PollEvent.fetchPolls);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              body: Container(
                child: BlocListener<PollBloc, PollState>(
                  listener: (context, state) {
                    if (state is PollListError) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text(state.errors),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<PollBloc, PollState>(
                    builder: (context, state) {
                      if (state is PollInitialState) {
                        return buildLoading();
                      } else if (state is PollLoadingState) {
                        return buildLoading();
                      } else if (state is PollLoadedState) {
                        return buildPollList(state.polls);
                      } else if (state is PollListError) {
                        return buildErrorUi(state.errors);
                      }
                      throw Exception();
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildPollList(List<Poll> polls) {
    return ListView.builder(
      itemCount: polls.length,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(
              title: Text(polls[pos].title),
              subtitle: Text(polls[pos].description),
            ),
            onTap: () {
              navigateToAboutPage(context);
            },
          ),
        );
      },
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  // void navigateToArticleDetailPage(BuildContext context, Articles article) {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return ArticleDetailPage(
  //       article: article,
  //     );
  //   }));
  // }

  void navigateToAboutPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ListPoll();
    }));
  }

}
