

class RecipeModel{
 late String appLabel;
  late String appImgUrl;
 late  double appCalories;
   late String appUrl;

  RecipeModel({
       this.appLabel="uh",  this.appImgUrl="yghg",  this.appCalories=23.899,  this.appUrl="uhyj"});
   factory RecipeModel.fromMap(Map recipe){
    return RecipeModel(
      appLabel: recipe["label"],
      appImgUrl:recipe["image"],
      appCalories: recipe["calories"],
      appUrl:recipe["url"]


    );
  }
}