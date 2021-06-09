mixin StateNotifier{
  List<Function> onStable;
  List<Function> onTransition;

  /* Listen for onCreate eventes which are thrown when instance is initialized
  it can come handy if you want to show some indication when app is starting
   */
  void listenOnStable(Function listener){
    if(onStable==null)
      onStable = [];
    this.onStable.add(listener);
  }
  void removeOnStableListener(Function listener){
    try{
      this.onStable.remove(listener);
    }catch(error){
      throw Exception("Function not registered as listener ");
    }
  }
  /*
  Listen for onTransition event that happen when the provider starts to change state
  Use for time consuming operation to show some other think on ui
   */
  void listenOnTransition(Function listener){
    if(onTransition==null)
      onTransition = [];
    onTransition.add(listener);
  }
  void removeOnTransitionListener(Function listener){
    try{
      this.onTransition.remove(listener);
    }catch(error){
      throw Exception("Function not registered as listener ");
    }
  }
  /*
  throw an onCreate event or onTransition Event
   */
  void throwOnCreateEvent(){
    if(onStable!=null){
      for(Function f in onStable)
        f();
    }
  }
  void throwOnTransitionEvent(){
    if(onTransition!=null){
      for(Function f in onTransition)
        f();
    }
  }

}