import 'package:flutter/material.dart';

import '../utilities/string.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;

  const SearchBarWidget({Key? key, required this.onSearchChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaquery=MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      child: SizedBox(
        height:mediaquery.height*0.07,
        child: TextField(
          cursorColor:Colors.grey ,
          decoration: InputDecoration(
            
            prefixIcon: const Icon(Icons.search),
            hintText: strings.search,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey), // Default border color
            ),
             enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey), // When not focused
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey), // When tapped
            ),
            
          ),
          onChanged: onSearchChanged, 
        ),
      ),
    );
  }
}
