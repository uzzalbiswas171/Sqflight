import 'package:flutter/material.dart';
import 'package:employemanagement/contact.dart';
import 'package:employemanagement/databasapage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key,this.contact}) : super(key: key);
  Contact ? contact;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _nameController=TextEditingController();
  TextEditingController _numberController=TextEditingController();

  @override
  void initState() {

    if(widget.contact!=null){
      _nameController.text=widget.contact!.name!;
      _numberController.text=widget.contact!.number!;
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
body: Container(
  margin: EdgeInsets.all(22),
  height: double.infinity,
  width: double.infinity,
  child: SingleChildScrollView(
    child: Column(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10,),
                margin: EdgeInsets.all(10),
                height: 60,
                width: double.infinity,
                color: Colors.pink,
                child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter Your name',
                  labelText: 'Name',
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.only(left: 10,),
                margin: EdgeInsets.all(10),
                height: 60,
                color: Colors.amberAccent,
                width: double.infinity,
                child: TextField(
                  controller: _numberController,
                  decoration: InputDecoration(
                    hintText: 'Enter Your number',
                    labelText: 'number',
                  ),
                ),
              ),
              InkWell(
                onTap: () async{
                  await DBHelper.createContact(Contact(
                      name: _nameController.text,
                      number: _numberController.text));
                      setState(() {});
                },
                child: Container(
                  alignment:Alignment.center ,
                  margin: EdgeInsets.all(10),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.blue,
                  ),
                  child: Text("ADD Employe",style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),),
                ),
              )
            ],
          ),
        ),

        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blueAccent,
                Colors.redAccent,
                Colors.amberAccent,
              ])
          ),
          margin: EdgeInsets.only(
            top: 50,
          ),
          height:400,
          width: double.infinity,
          child: FutureBuilder<List<Contact>>(
              future: DBHelper.readContact(),
              builder:
                (BuildContext context, AsyncSnapshot<List<Contact>> snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        ),
                        Text("LOading..."),
                      ],
                    ),
                  );
                }
                return snapshot.data!.isEmpty ?  Center(
                  child: Text("No Data Found"),
                ): ListView(
                  children: snapshot.data!.map((contacts){
                      return Center(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          elevation: 5,
                          color: Colors.white,
                          child: ListTile(
                          title: Text("${contacts.name}"),
                      subtitle: Text("${contacts.number}"),
                      ),
                      ),
                      );
                    }).toList(),
                );
              }
          ),
        ),
      ],
    ),
  ),
),
    );
  }
}
