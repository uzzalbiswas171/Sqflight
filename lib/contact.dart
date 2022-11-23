
class Contact{
  String ? name,number;
  int ? id;

  Contact({required this.number,required this.name,this.id});

  factory Contact.fromJson(Map<String, dynamic> json)=>Contact(
      number: json['number'],
      name: json['name'],
      id: json['id'],
  );

 Map<String, dynamic> toJson()=>{
   'id' : id,
   'name' : name,
   'number' : number,
 };

}






