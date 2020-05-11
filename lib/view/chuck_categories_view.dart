import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streamchucknorris/blocs/chuck_categories_bloc.dart';
import 'package:streamchucknorris/models/chuck_categories.dart';
import 'package:streamchucknorris/networking/api_response.dart';

class GetChuckCategories extends StatefulWidget {
  @override
  _GetChuckCategoriesState createState() => _GetChuckCategoriesState();
}

class _GetChuckCategoriesState extends State<GetChuckCategories> {
  //Define Bloc
  ChuckCategoryBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ChuckCategoryBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Chucky Categories with Bloc',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        backgroundColor: Colors.redAccent,
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchCategories(),
        child: StreamBuilder<Response<ChuckCategories>>(
          stream: _bloc.chuckListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                // TODO: Handle this case.
                  return Loading(
                    loadingMessage: snapshot.data.message,
                  );
                  break;
                case Status.COMPLETED:
                // TODO: Handle this case.
                  return CategoryList(categoryList: snapshot.data.data);
                  break;
                case Status.ERROR:
                // TODO: Handle this case.
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchCategories(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}

//View List
class CategoryList extends StatelessWidget {
  final ChuckCategories categoryList;

  const CategoryList({Key key, this.categoryList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 1.0),
            child: InkWell(
              onTap: () {},
              child: SizedBox(
                height: 65.0,
                child: Container(
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                    child: Text(
                      categoryList.categories[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: categoryList.categories.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
      ),
    );
  }
}

//Loading Method
class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 23.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
          )
        ],
      ),
    );
  }
}

//Error Method
class Error extends StatelessWidget {
  final String errorMessage;
  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.deepOrange, fontSize: 18.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            color: Colors.green,
            child: Text(
              'Retry',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}
