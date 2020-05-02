library preflection;

import 'package:bargain_di/ObjectFactory.dart';



class PreflectorFactory {
  static final _objectFactory = new ObjectFactory();
    

  static void addCreator<TType>(TType Function() typeCreator){
    _objectFactory.register<TType>(typeCreator);
  }

  static TType create<TType>(){
    return _objectFactory.getInstance<TType>();
  }
  

  
}
