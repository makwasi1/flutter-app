class PollModel {
  List<Poll> polls;

  PollModel({this.polls});

  PollModel.fromJson(List<dynamic> json) {
    if (json != null) {
      polls = <Poll>[];
      json.forEach((v) {
        polls.add(new Poll.fromJson(v));
      });
    }
  }


  List<dynamic> toJson() {
     List<dynamic> data = new List<dynamic>();
    data = this.polls;
    if (this.polls != null) {
      data = this.polls.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Poll {
  int id;
  int author;
  String title;
  String startDate;
  String endDate;
  String description;
  bool isActive;
  List<Question> questions;

  Poll(
      {this.id,
      this.author,
      this.title,
      this.startDate,
      this.endDate,
      this.description,
      this.isActive,
      this.questions});

  Poll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    title = json['title'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    isActive = json['is_active'];
    if (json['questions'] != null) {
      questions = <Question>[];
      json['questions'].forEach((v) {
        questions.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author'] = this.author;
    data['title'] = this.title;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  int id;
  int poll;
  String qns;
  int qnsType;
  List<Choice> choices;

  Question({this.id, this.poll, this.qns, this.qnsType, this.choices});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    poll = json['poll'];
    qns = json['qns'];
    qnsType = json['qns_type'];
    if (json['choices'] != null) {
      choices = <Choice>[];
      json['choices'].forEach((v) {
        choices.add(new Choice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['poll'] = this.poll;
    data['qns'] = this.qns;
    data['qns_type'] = this.qnsType;
    if (this.choices != null) {
      data['choices'] = this.choices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Choice {
  int id;
  int qns;
  String text;
  int voteCounter;
  bool selected;

  Choice({this.id, this.qns, this.text, this.voteCounter, this.selected});

  Choice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qns = json['qns'];
    text = json['text'];
    voteCounter = json['vote_counter'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qns'] = this.qns;
    data['text'] = this.text;
    data['vote_counter'] = this.voteCounter;
    data['selected'] = this.selected;
    return data;
  }
}
