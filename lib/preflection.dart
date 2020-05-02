library preflection;

import 'package:bargain_di/ObjectFactory.dart';



class PreflectorFactory {
  final _objectFactory = new ObjectFactory();

  static final instance = new PreflectorFactory();
    

  PreflectorFactory addCreator<TType>(TType Function() typeCreator){
    _objectFactory.register<TType>(typeCreator);
    return this;
  }

  TType create<TType>(){
    return _objectFactory.getInstance<TType>();
  }
  

  
}
