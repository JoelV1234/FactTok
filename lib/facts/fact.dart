import 'package:equatable/equatable.dart';

class Fact with EquatableMixin {
  final String id;
  final String title;
  final String description;
  final String? photourl;

  Fact({
    required this.id,
    required this.description,
    this.photourl,
    required this.title
  });

  factory Fact.fromJson(Map<String, dynamic> json) {
    return Fact(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      photourl: json['photourl']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'photourl': photourl
  };

  
  @override
  List<Object?> get props => [title];

}