
class Notifier {
  bool dirty;
  Function onChange;


  void notifyChange(){
    if(onChange!=null)
      onChange();
  }
  void listen(Function listener){
    onChange = listener;
  }
}
