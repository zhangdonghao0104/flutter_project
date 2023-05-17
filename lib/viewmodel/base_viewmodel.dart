import 'package:flutter_zdh/viewmodel/base_change_notifier.dart';
import 'package:flutter_zdh/widget/loading_state_widget.dart';

abstract class BaseViewModel extends BaseChangeNotifier {
  void refresh() {}

  void loadMore() {}

  void retry() {
    viewState = ViewState.loading;
    notifyListeners();
    refresh();
  }
}
