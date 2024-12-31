import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final ValueChanged<String> onSearch;

  const CustomSearchBar({super.key, required this.onSearch});

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<CustomSearchBar> {
  bool isExpanded = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (isExpanded)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8 - 40,
              child: TextField(
                controller: _controller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Cari Surah...',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                onChanged: widget.onSearch,
              ),
            ),
          SizedBox(
            width: 40,
            child: IconButton(
              icon: Icon(isExpanded ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                  if (!isExpanded) {
                    _controller.clear();
                    widget.onSearch(''); // Reset pencarian
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
