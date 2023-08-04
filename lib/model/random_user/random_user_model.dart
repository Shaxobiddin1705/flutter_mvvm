import 'package:json_annotation/json_annotation.dart';

part 'random_user_model.g.dart';

@JsonSerializable()
class RandomUserModel {
  @JsonKey(name:"results")
  final List<RandomUser> users;
  @JsonKey(name:"info")
  final Info info;

  RandomUserModel({
    required this.users,
    required this.info,
  });

  factory RandomUserModel.fromJson(Map<String, dynamic> json) => _$RandomUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$RandomUserModelToJson(this);
}

@JsonSerializable()
class Info {
  @JsonKey(name:"seed")
  final String seed;
  @JsonKey(name:"results")
  final int results;
  @JsonKey(name:"page")
  final int page;
  @JsonKey(name:"version")
  final String version;

  Info({
    required this.seed,
    required this.results,
    required this.page,
    required this.version,
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable()
class RandomUser {
  @JsonKey(name:"gender")
  final String gender;
  @JsonKey(name:"name")
  final Name name;
  @JsonKey(name:"location")
  final Location location;
  @JsonKey(name:"email")
  final String email;
  @JsonKey(name:"login")
  final Login login;
  @JsonKey(name:"dob")
  final Dob dob;
  @JsonKey(name:"registered")
  final Dob registered;
  @JsonKey(name:"phone")
  final String phone;
  @JsonKey(name:"cell")
  final String cell;
  @JsonKey(name:"id")
  final Id id;
  @JsonKey(name:"picture")
  final Picture picture;
  @JsonKey(name:"nat")
  final String nat;

  RandomUser({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.login,
    required this.dob,
    required this.registered,
    required this.phone,
    required this.cell,
    required this.id,
    required this.picture,
    required this.nat,
  });

  factory RandomUser.fromJson(Map<String, dynamic> json) => _$RandomUserFromJson(json);

  Map<String, dynamic> toJson() => _$RandomUserToJson(this);
}

@JsonSerializable()
class Dob {
  @JsonKey(name:"date")
  final String date;
  @JsonKey(name:"age")
  final int age;

  Dob({
    required this.date,
    required this.age,
  });

  factory Dob.fromJson(Map<String, dynamic> json) => _$DobFromJson(json);

  Map<String, dynamic> toJson() => _$DobToJson(this);
}

@JsonSerializable()
class Id {
  @JsonKey(name:"name")
  final String name;
  @JsonKey(name:"value")
  final String value;

  Id({
    required this.name,
    required this.value,
  });

  factory Id.fromJson(Map<String, dynamic> json) => _$IdFromJson(json);

  Map<String, dynamic> toJson() => _$IdToJson(this);
}

@JsonSerializable()
class Location {
  @JsonKey(name:"street")
  final Street street;
  @JsonKey(name:"city")
  final String city;
  @JsonKey(name:"state")
  final String state;
  @JsonKey(name:"country")
  final String country;
  @JsonKey(name:"postcode")
  final String postcode;
  @JsonKey(name:"coordinates")
  final Coordinates coordinates;
  @JsonKey(name:"timezone")
  final Timezone timezone;

  Location({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.coordinates,
    required this.timezone,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Coordinates {
  @JsonKey(name:"latitude")
  final String latitude;
  @JsonKey(name:"longitude")
  final String longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}

@JsonSerializable()
class Street {
  @JsonKey(name:"number")
  final int number;
  @JsonKey(name:"name")
  final String name;

  Street({
    required this.number,
    required this.name,
  });

  factory Street.fromJson(Map<String, dynamic> json) => _$StreetFromJson(json);

  Map<String, dynamic> toJson() => _$StreetToJson(this);
}

@JsonSerializable()
class Timezone {
  @JsonKey(name:"offset")
  final String offset;
  @JsonKey(name:"description")
  final String description;

  Timezone({
    required this.offset,
    required this.description,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) => _$TimezoneFromJson(json);

  Map<String, dynamic> toJson() => _$TimezoneToJson(this);
}

@JsonSerializable()
class Login {
  @JsonKey(name:"uuid")
  final String uuid;
  @JsonKey(name:"username")
  final String username;
  @JsonKey(name:"password")
  final String password;
  @JsonKey(name:"salt")
  final String salt;
  @JsonKey(name:"md5")
  final String md5;
  @JsonKey(name:"sha1")
  final String sha1;
  @JsonKey(name:"sha256")
  final String sha256;

  Login({
    required this.uuid,
    required this.username,
    required this.password,
    required this.salt,
    required this.md5,
    required this.sha1,
    required this.sha256,
  });

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}

@JsonSerializable()
class Name {
  @JsonKey(name:"title")
  final String title;
  @JsonKey(name:"first")
  final String first;
  @JsonKey(name:"last")
  final String last;

  Name({
    required this.title,
    required this.first,
    required this.last,
  });

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  Map<String, dynamic> toJson() => _$NameToJson(this);
}

@JsonSerializable()
class Picture {
  @JsonKey(name:"large")
  final String large;
  @JsonKey(name:"medium")
  final String medium;
  @JsonKey(name:"thumbnail")
  final String thumbnail;

  Picture({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  factory Picture.fromJson(Map<String, dynamic> json) => _$PictureFromJson(json);

  Map<String, dynamic> toJson() => _$PictureToJson(this);
}
