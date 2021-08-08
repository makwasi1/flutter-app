import 'package:citizen_feedback/models/poll_model.dart';
import 'package:citizen_feedback/services/http_utils.dart';
import 'package:citizen_feedback/shared/exceptions/app_exception.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

abstract class PollRepository {
  Future<List<Poll>> getPolls();
}


class PollRepositoryImpl implements PollRepository {

  String urls  = "https://mocki.io/v1/68c58f63-f3f8-409b-ba1a-c5bd4b50c33e";
  // String endpoint = "/posts";

///get polls from the server
  @override
  Future<List<Poll>> getPolls() async {
    final response = await HttpUtils.getRequest(urls);
    // TODO: implement getPolls
    if(response.statusCode == 200) {
      FlutterSecureStorage storage = new FlutterSecureStorage();
      await storage.write(key: HttpUtils.keyForPolls, value: response.body);

      var data = json.decode(response.body);
      PollModel.fromJson(data);
       List<Poll> polls = PollModel.fromJson(data).polls;
       return polls;


      // List<Poll> pollObj = [];
      // var polls = JsonMapper.deserialize<List<Poll>>(response.body);
      // polls.forEach((poll) {
      //   List<Question> questionObj = [];
      //
      //
      //   var questions = JsonMapper.deserialize<Question>(poll['questions'].toString());
      //
      //   questions.forEach((question) {
      //     List<Choices> choicesObj = [];
      //     var choices = JsonMapper.deserialize<Choice>(question.choi.toString());
      //     choices.forEach((choice) {
      //       choicesObj.add(new Choices(id: choice['id'],));
      //     });
      //
      //     questionObj.add(new Questions(id: question['id'], qnsType: question['qns_type'], choices: choicesObj));
      //   });
      //
      //   pollObj.add(new Polls(id: poll['id'],title: poll['title'], description: poll['description'], questions: questionObj));
      // });
      // return pollObj;
    } else if (response.statusCode == 401) {
      throw UnknownResponseException('Failed to load polls');
    } else {
      throw Exception('Failed to load polls');
    }
  }

}