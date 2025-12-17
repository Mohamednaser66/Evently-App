
class UserDM {
 static  UserDM? currentUser;
  String id;
  String name;
  String email;
  List<String> favEventIds;

  UserDM(
      {required this.id, required this.name, required this.email, required this.favEventIds});

  Map<String,dynamic> toJson()=>{
    "id": id,
    "name": name,
    "email": email,
    "favEventIds":favEventIds
  };
  UserDM.fromJson(Map<String,dynamic> json) :this(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    favEventIds: (json["favEventIds"] as List<dynamic>).map((e) => e.toString(),).toList()
  );
}