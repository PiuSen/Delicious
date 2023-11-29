import 'dart:convert';

import 'package:delicious/recipe_details.dart';
import 'package:delicious/recipemodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:developer';

class Search extends StatefulWidget {
  String query;
  Search(this.query);

  @override
  State<Search> createState() => _HomeState();
}

class _HomeState extends State<Search> {
  bool isLoading =true;
  List<RecipeModel>recipeList=<RecipeModel>[];
  TextEditingController searchController=new TextEditingController();

  getRecipe(String query)async{
    String url="https://api.edamam.com/search?q=$query&app_id=181aa7c9&app_key=fbe44a9706e329493e0ec15da3fa3e7b";
    Response response=await get(Uri.parse(url));
    Map data=jsonDecode(response.body);

    data["hits"].forEach((element){
      RecipeModel recipeModel=RecipeModel();
      recipeModel=RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      setState(() {
        isLoading=false;
      });
      log(recipeList.toString());

    });

    recipeList.forEach((Recipe) {
      print(Recipe.appLabel);
      print(Recipe.appCalories);

    });



  }
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    getRecipe(widget.query);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xff213A50),
                    Color(0xff071938)

                  ]
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 24,vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child:  Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            if((searchController.text).replaceAll(" ","")==""){
                              print("blank");
                            }
                            else{
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Search(searchController.text)));

                            }


                          },
                          child: Container(child: const Icon(Icons.search),margin: EdgeInsets.fromLTRB(3, 0, 7, 0,),
                          ),
                        ),
                        Expanded(child: TextField(
                          textInputAction: TextInputAction.search,
                          controller: searchController,
                   onSubmitted: (value) {
                            if(value=="") {
                              print("blank search");
                            }
                            else {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      Search(value)));
                            }
                      },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search here...."

                          ),

                        ),
                        )

                      ],
                    ),
                  ),
                ),

                Container(

                  child:  isLoading? CircularProgressIndicator():ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // scrollDirection: Axis.horizontal,
                      itemCount: recipeList.length,
                      itemBuilder: (context,index){

                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(recipeList[index].appUrl)));
                          },
                          child: Card(
                            margin: EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                            elevation: 0.0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius:BorderRadius.circular(10.0),
                                  child:Image.network(
                                    recipeList[index].appImgUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 250,
                                  ),
                                ),
                                Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,

                                    child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                        decoration:  const BoxDecoration(
                                            color: Colors.black26
                                        ),
                                        child: Text(recipeList[index].appLabel,style: const TextStyle(
                                            color: Colors.white,fontSize: 18
                                        ),))),
                                Positioned(
                                    right: 0,
                                    width: 80,
                                    height: 50,
                                    child:Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          )
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:
                                          [
                                            Icon(Icons.local_fire_department,size: 16,),
                                            Text(recipeList[0].appCalories.toString().substring(0,6)
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),

                        );

                      }),
                )



              ],
            ),
          )
        ],
      ),

    );
  }
}
