class Double1 {
  double _value = 0;
  bool _valid = false;

  Double1();


  Double1.setVal(double value){
    set(value);
  }

  double get(){
    return _value;
  }

  void set(double value){
    if(value > 0){
      _value = value;
      _valid = true;
    }else{
      _valid = false;
    }
  }

  bool isValid(){
    return _valid;
  }
}