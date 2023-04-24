import 'package:flutter/material.dart';
import 'package:nwes_ap/modules/web_view/web_view_screen.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required var validate,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  var suffixPressed,
  var onTap,
  var onChange,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validate,
      obscureText: isPassword,
      onTap: onTap,
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(suffix),
        ) : null,
        border: OutlineInputBorder(), // to drow the border
      ),
    );




Widget articleBuilder(list) => list.length > 0 ? ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildArticleItem(list[index], context),
  separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],)),
  itemCount: list.length,) : Center(child: CircularProgressIndicator());


Widget buildArticleItem(article, context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              [
                Expanded(
                  child: Text('${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text('${article['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 15.0,
        ),
      ],
    ),
  ),
);



void navigateTo(context, widget) => Navigator.push(context, MaterialPageRoute(builder: (context) => widget));