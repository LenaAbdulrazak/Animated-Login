import 'package:animatedlogin/animation_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Artboard ? riveArtBoard;
 
  final passwordFocusNode=FocusNode();
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  late RiveAnimationController controllerIdle;
  late RiveAnimationController controllerHandsup;
  late RiveAnimationController controllerHandsDown;
  late RiveAnimationController controllerlookLeft;
  late RiveAnimationController controllerLookRight;
  late RiveAnimationController controllerSuccess;
  late RiveAnimationController controllerfail;
  bool isLookingLeft=false;
  bool isLookingRight=false;
 String testEmail="lena@gmail.com";
  String testPassword="qwerty";

  void removeAllControllers(){

    riveArtBoard?.artboard.removeController(controllerIdle);
    riveArtBoard?.artboard.removeController(controllerHandsup);
    riveArtBoard?.artboard.removeController(controllerHandsDown);
    riveArtBoard?.artboard.removeController(controllerlookLeft);
    riveArtBoard?.artboard.removeController(controllerLookRight);
    riveArtBoard?.artboard.removeController(controllerSuccess);
    riveArtBoard?.artboard.removeController(controllerfail);
    isLookingLeft=false;
    isLookingRight=false;
  }

  void addIdleController(){
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerIdle);
    debugPrint("idleee");
  }


  void addHandsUpController(){
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerHandsup);
    debugPrint("hands up");
  }
    void addHandsdownController(){
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerHandsDown);
    debugPrint("hands down");
  }

  void addSuccesController(){
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerSuccess);
    debugPrint("succes");
  }

  void addFailController(){
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerfail);
    debugPrint("fail");
  }

    void addLookRightController(){
    removeAllControllers();
    isLookingRight=true;
    riveArtBoard?.artboard.addController(controllerLookRight);
    debugPrint("Righttt");
  }
      void addLookLeftController(){
    removeAllControllers();
    isLookingLeft=true;
    riveArtBoard?.artboard.addController(controllerlookLeft);
    debugPrint("left");
  }






@override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerIdle=SimpleAnimation(AnimationEnum.idle.name);
    controllerHandsDown=SimpleAnimation(AnimationEnum.hands_down.name);
    controllerHandsup=SimpleAnimation(AnimationEnum.hands_up.name);
    controllerLookRight=SimpleAnimation(AnimationEnum.Look_down_right.name);
    controllerlookLeft=SimpleAnimation(AnimationEnum.Look_down_left.name);
    controllerSuccess=SimpleAnimation(AnimationEnum.success.name);
    controllerfail=SimpleAnimation(AnimationEnum.fail.name);
    rootBundle.load("assets/fullBody.riv").then((data){
    final file=RiveFile.import(data);
    final artboard =file.mainArtboard;
    artboard.addController(controllerIdle);
    setState(() {
      riveArtBoard=artboard;
    });
    });
    checkForPasswordFocusNodeToChangeAnimationState();
  }



  void checkForPasswordFocusNodeToChangeAnimationState(){

  passwordFocusNode.addListener((){
    if(passwordFocusNode.hasFocus){
      addHandsUpController();
    }else if(!passwordFocusNode.hasFocus){
      addHandsdownController();
    }
  });
}

  void validatEmailAndPassword(){
Future.delayed(const Duration(seconds: 1),(){
   if(formKey.currentState!.validate()){
      addSuccesController();
    }else{
      addFailController();
    }
});
   
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      resizeToAvoidBottomInset: false,
   appBar: AppBar(title: const Text("Login"),centerTitle: true,),
   body: Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/20),
   child: Column(
children: [
  SizedBox(
    height: MediaQuery.of(context).size.height/18,
  ),
  SizedBox(
    height: MediaQuery.of(context).size.height/3,
    child: riveArtBoard==null?const SizedBox.shrink(): Rive(artboard: riveArtBoard!,)),
    Form(
      key: formKey,
      child:  Column(
      children: [
          SizedBox(
          height: MediaQuery.of(context).size.height/18,
        ),
        
        TextFormField(
            validator: (value) {
              if(value!=testEmail){
                return "wrong Email";
              }
              return null;
            },
           onChanged: (value) {
            if(value.isNotEmpty && value.length<16 && !isLookingLeft){
                addLookLeftController();
            }else if(value.isNotEmpty && value.length>16 && !isLookingRight){
              addLookRightController();
            }
          },
            decoration: InputDecoration(
              border:  OutlineInputBorder( borderRadius:BorderRadius.circular(25)),
              // focusedErrorBorder: OutlineInputBorder( borderRadius:BorderRadius.circular(25),borderSide: const BorderSide(color:Color.fromARGB(255, 233, 30, 30))),
            focusedBorder: OutlineInputBorder( borderRadius:BorderRadius.circular(25),borderSide: const BorderSide(color:Colors.pink)),
            labelText: "Email",
          enabledBorder: OutlineInputBorder( borderRadius:BorderRadius.circular(25),borderSide: const BorderSide(color:Colors.black)),

          ),
          
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height/30,
        ),
        TextFormField(
      
          obscureText: true,
          focusNode: passwordFocusNode,
          
          decoration: InputDecoration(
           border:  OutlineInputBorder( borderRadius:BorderRadius.circular(25)),
            focusedBorder: OutlineInputBorder( borderRadius:BorderRadius.circular(25),borderSide: const BorderSide(color:Colors.pink)),
            labelText: "passsword",
          enabledBorder: OutlineInputBorder( borderRadius:BorderRadius.circular(25),borderSide: const BorderSide(color:Colors.black)),

          ),
            validator: (value) {
              if(value!=testPassword){
                return "wrong password";
              }
              return null;
            }
            
            
            // value!=testPassword? "Wrong password":null, 
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height/18,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height/8,

          ),

          child: TextButton(style: TextButton.styleFrom(shape: const StadiumBorder(),backgroundColor: Colors.pink.shade700,padding: const EdgeInsets.symmetric(vertical: 14)),
          onPressed:(){
        passwordFocusNode.unfocus();
        validatEmailAndPassword();

          } ,
          child: const Text("Login",
          style: TextStyle(fontSize: 20,color: Colors.white),),
          ),
        )
      ],
    ))


],

   ),),

   


    );
  }
}