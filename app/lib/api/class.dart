class Location{
  final String street;
  final String city;
  final String state;
  final String country;
  final String timezone;

  const Location({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.timezone,
  });

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(
      street:json['street'],
      city:json['city'],
      state:json['state'],
      country:json['country'],
      timezone:json['timezon'],
    );
  }

}

class User{
  final String id;
  final String title;
  final String firstName;
  final String lastName;
  //final String gender;
  //final String email;
  //final String dateOfBirth;
  //final String registerDate;
  //final String phone;
  final String picture;
  //final Object location;


  const User({
    required  this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    //required  this.gender,
    //required this.email,
    //required this.dateOfBirth,
    //required this.registerDate,
    //required  this.phone,
    required this.picture,
    //required this.location,

  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id:json['id'],
      title:json['title'],
      firstName:json['firstName'],
      lastName:json['lastName'],
      //gender:json['gender'],
      //email:json['email'],
      //dateOfBirth:json['dateOfBirth'],
      //registerDate:json['registerDate'],
      //phone:json['phone'],
      picture:json['picture'],
      //location:json['location'],
    );
  }

}

class Post{
  final String id;
  final String text;
  final String image;
  final int likes;
  //final String link;
  final List<dynamic> tags;
  final String publishDate;
  final User owner;

  const Post({
    required  this.id,
    required this.text,
    required this.image,
    required  this.likes,
    //required this.link,
    required  this.tags,
    required this.publishDate,
    required this.owner,
  });

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      id:json['id'] as String,
      text:json['text'] as String,
      image:json['image'] as String,
      likes:json['likes'] as int,
      //link:json['link'] as String,
      tags:json['tags'] as List<dynamic>,
      publishDate:json['publishDate'] as String,
      owner:User.fromJson(json['owner']), //subList.map((item) => item.toJson()).toList(),// as Object, User.fromJson(jsonDecode(json['owner']))
    );
  }

}