enum ViewState{Idle,Busy}

abstract class LoaderState{

  ViewState _state=ViewState.Idle;

  ViewState get state=>_state;

  void setState(ViewState viewState);

}