import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../api_service/pagination_service.dart';
import '../models/paginationModel.dart';

class PaginationPage extends StatefulWidget {
  const PaginationPage({Key? key}) : super(key: key);

  @override
  State<PaginationPage> createState() => _PaginationPageState();
}

class _PaginationPageState extends State<PaginationPage> {
  List<PaginationModel> pagi_datalist = [];
  int _page = 1;
  int _limit = 20;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  List _posts = [];

  // This function will be called when the app launches (see the initState function)
  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    fatchAyatList();
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 100) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1

      fatchAyatList();
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // The controller for the ListView
  late ScrollController _controller;
  fatchAyatList() async {
    var data = await PaginationService().get_pagination_service(_page, _limit);

    setState(() {
      pagi_datalist = data;
    });
  }

  @override
  void initState() {
    _firstLoad();
    _controller = new ScrollController()..addListener(_loadMore);

    // PaginationProvider paginationProvider =
    //     Provider.of<PaginationProvider>(context, listen: false);
    // paginationProvider.getPagination();

    //paginationProvider.firstLoad();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // PaginationProvider paginationProvider = Provider.of<PaginationProvider>(
    //   context,
    // );
    return Scaffold(
        appBar: AppBar(
          title: Text('Products Pgination'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  child: Column(
                children: [
                  StaggeredGridView.countBuilder(
                      controller: _controller,
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.count(2, index.isEven ? 2 : 1),
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: pagi_datalist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: ((context) => ProductsDetails(
                            //             // productPrice: productProvider
                            //             //         .data_list[index]
                            //             //     ['price'],
                            //             // productName: productProvider
                            //             //         .data_list[index]
                            //             //     ['title'],
                            //             // products_details:
                            //             //     productProvider
                            //             //             .data_list[index]
                            //             //         ['description'],
                            //             // productsImage: productProvider
                            //             //         .data_list[index]
                            //             //     ['image'],
                            //             ))));
                          },
                          child: Container(
                            child: Card(
                                child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                      child: Image.network(
                                    pagi_datalist[index].downloadUrl.toString(),
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  )),
                                ),
                                Text(
                                  pagi_datalist[index].author.toString(),
                                  maxLines: 1,
                                  style: TextStyle(),
                                ),
                                Text(
                                  pagi_datalist[index].height.toString(),
                                  style: TextStyle(),
                                ),
                              ],
                            )),
                          ),
                        );
                      }),
                  if (_isLoadMoreRunning == true)
                    Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 0),
                      child: Center(
                        child:  Container(
                    color: Colors.white,
                    child: Center(
                      child: Text('Loading More Products'),
                    ),
                  ),
                      ),
                    ),

                  // When nothing else to load 
                                  _hasNextPage == false?
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Text('You have fetched all of the content'),
                    ),
                  ): Container(
                    color: Colors.white,
                    child: Center(
                      child: Text('You have fetched all of the content'),
                    ),
                  )],
              ))
            ],
          ),
        ));
  }
}
