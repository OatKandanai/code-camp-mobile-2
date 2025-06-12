class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory UserModel.fromApi(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'] ?? -1,
      name: data['name'] ?? 'no name',
      username: data['username'] ?? 'no username',
      email: data['email'] ?? 'no email',
      address: Address data['address'],
      phone: data['phone'],
      website: data['website'],
      company: data['company'],
    );
  }
}

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  Address(this.street, this.suite, this.city, this.zipcode, this.geo);

  factory Address.fromJson(Map<String,dynamic> data){
    return Address(street:data['street'], suite:data['suite'], city:data['street'], zipcode:data['street'], geo:Geo data['geo']);
  }
}

class Geo {
  final String lat;
  final String long;

  Geo(this.lat, this.long);

  factory Geo
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company(this.name, this.catchPhrase, this.bs);

  factory Company
}
