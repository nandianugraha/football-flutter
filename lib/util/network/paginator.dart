import 'package:flutter/material.dart';
import 'api.dart';
import 'parameter.dart';
import 'result/success.dart';

class Paginator {
  int _currentPage;
  int _perPage;
  int _lastPage;
  int _total;
  int _timestamp;
  Api _api;
  ScrollController _scrollController;
  OnSuccessPaginator _onSuccessPaginator;
  bool _isLoading = true;
  double _initialHeight = 0;
  Function(bool isPaginationLoading) onPaginationLoading;

  Paginator(Api api) {
    this._currentPage = 1;
    this._perPage = 10;
    this._lastPage = 0;
    this._api = api;
    this._total = 0;
    this._timestamp = 0;
  }

  int getCurrentPage() {
    return this._currentPage;
  }

  int getLastPage() {
    return this._lastPage;
  }

  Paginator setTotal(int value) {
    this._total = value;
    return this;
  }

  Paginator setLastPage(int value) {
    this._lastPage = value;
    return this;
  }

  Paginator setPerPage(int value) {
    this._perPage = value;
    return this;
  }

  Paginator setCurrentPage(int value) {
    this._currentPage = value;
    return this;
  }

  Paginator setTimestamp(int value) {
    this._timestamp = value;
    return this;
  }

  Paginator setScrollController(ScrollController scrollController) {
    this._scrollController = scrollController;
    return this;
  }

  Paginator setOnSuccessPaginator(OnSuccessPaginator value) {
    this._onSuccessPaginator = value;
    return this;
  }

  Paginator setOnLoadingPaginator(Function(bool) value) {
    this.onPaginationLoading = value;
    return this;
  }

  void setup(String urlMethod, bool isGet, Parameter _parameter) {
    this._scrollController.addListener(() {
      if(_initialHeight == 0){
        _initialHeight = _scrollController.position.maxScrollExtent;
      }
      double requestPosition = this._scrollController.position.maxScrollExtent - (_initialHeight*0.75);

      if (this._scrollController.position.pixels > requestPosition &&
          this._currentPage < this._lastPage && _isLoading) {
//        debugPrint("position : ${_scrollController.position.pixels} "
//            "\n request : $requestPosition "
//            "\n max : ${_scrollController.position.maxScrollExtent}");
        _isLoading = false;
        int currentPages = this._currentPage + 1;
        _parameter.set("page_start", "$currentPages");
        _parameter.set("perPage", this._perPage.toString());

        if(onPaginationLoading != null){
          onPaginationLoading(true);
        }

        Api api = Api(this._api.context);
        api.setLoading(false).execute(urlMethod, isGet, _parameter, (response) {
          //this.setCurrentPage(currentPages);

          if(onPaginationLoading != null){
            onPaginationLoading(false);
          }

          Success success = new Success(this._api, response.data());
          this._isLoading = true;
          this._onSuccessPaginator(success);
        });
        api.setCompleteListener((){
          if(onPaginationLoading != null){
            onPaginationLoading(false);
          }
        });
      }
    });
  }
}

typedef OnSuccessPaginator = void Function(Success response);
