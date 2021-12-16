import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({ Key key }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with AutomaticKeepAliveClientMixin<Search> {
  TextEditingController searchController = TextEditingController();
  // Future<QuerySnapshot> searchResultsFuture;

  handleSearch(String query) {
    // Future<QuerySnapshot> users = FirebaseFirestore.instance
    //     .collection('users')
    //     .where("name", isGreaterThanOrEqualTo: query)
    //     .get();
    setState(() {
      // searchResultsFuture = users;
    });
  }

  clearSearch() {
    searchController.clear();
  }

  AppBar buildSearchField() {
    // final logoutProvider = Provider.of<AuthServices>(context);
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search for a user...",
          filled: true,
          prefixIcon: Icon(
            Icons.account_box,
            size: 28.0,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: clearSearch,
          ),
        ),
        onFieldSubmitted: handleSearch,
      ),
      actions: [
        IconButton(
            // onPressed: () async => await logoutProvider.logout(),
            icon: Icon(
              Icons.exit_to_app,
            ),
            color: Colors.black,
          ),
      ],
    );
  }

  Container buildNoContent() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            // SvgPicture.asset(
            //   'assets/images/search.svg',
            //   height: orientation == Orientation.portrait ? 300.0 : 150.0,
            // ),
            Text(
              "Find Users",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                fontSize: 60.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildSearchResults() {
    return FutureBuilder(
        // future: searchResultsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // return circularProgress();
          }
          // List<UserResult> searchResults = [];
          // snapshot.data.docs.forEach((doc) {
          //   UserV2 user = UserV2.fromDocument(doc);
          //   UserResult searchResult = UserResult(user);
          //   searchResults.add(searchResult);
          // });
          return ListView(
            // children: searchResults,
          );
        });
  }

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      appBar: buildSearchField(),
      body: buildNoContent()
          // searchResultsFuture == null ? buildNoContent() : buildSearchResults(),
    );
  }
}
