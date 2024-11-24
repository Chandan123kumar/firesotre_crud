class UserModel {
  final String userId;
  final String name;
  final String email;
  final String password;
  final String address;
  final String gender;
  final String num;

  UserModel({
        required this.userId,
        required this.name,
        required this.email,
        required this.password,
        required this.address,
        required this.gender,
        required this.num});

  Map<String,dynamic> toMap(){
    return{
    'userId':userId,
    'name':name,
    'email':email,
    'password':password,
    'address':address,
    'gender':gender,
    'num':num,
    };
  }
  factory UserModel.fromMap(Map<String,dynamic>map,String userId){
    return UserModel(
        userId: map['userId'],
        name: map['name'],
        email: map['email'],
        password: map['password'],
        address: map['address'],
        gender: map['gender'],
        num: map['num']);
  }
}