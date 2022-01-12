import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController creditCardNumber = TextEditingController();
  final TextEditingController dateInput = TextEditingController();
  final TextEditingController securityCode = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();

  //alert dialog Pop Up message
  void showPopUp(BuildContext context){
    var popUp = AlertDialog(
      actions: [
        Center(
          child :Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Text('Payment Successful',style: TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(width: 10.0,),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: const Text('Ok',style: TextStyle(color: Colors.green),) ,
              )
            ],
          )
        )
      ],
    );
    showDialog(context: context, builder: (BuildContext context)=>popUp,barrierDismissible: false);
  }

  @override
  Widget build(BuildContext context) {
    final cardNumber = TextFormField(
      controller: creditCardNumber,
      keyboardType: TextInputType.number,
      onSaved: (value)=>creditCardNumber.text=value!,
      textInputAction: TextInputAction.next,
      validator: (value)
      {
        if(value!.isEmpty)
          {
            return ('Please Enter The Card Number!');
          }else
            {
              int val = int.parse(value);
              int sum = 0;
              bool isSecond = false;
              while(val>0)
              {
                int digit = val%10;
                if(isSecond==true)
                {
                  digit*=2;
                }
                sum+= digit ~/ 10;
                sum += digit%10;
                val=val ~/ 10;
                isSecond = !isSecond;
              }
              if(sum%10!=0)
                {
                  return ('Enter The Correct Card Number');
                }
            }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Card Number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        )
      ),
    );

    final dateTime = TextFormField(
      controller: dateInput,
      keyboardType: TextInputType.datetime,
      onSaved: (value)=>dateInput.text=value!,
      textInputAction: TextInputAction.next,
      validator: (value)
      {
        if(value!.isEmpty)
          {
            return ('Can Not Be Empty!');
          }
        return null;
      },
      decoration: InputDecoration(
          labelText: 'MM/YY',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )
      ),
    );

    final securtiy = TextFormField(
      controller: securityCode,
      keyboardType: TextInputType.number,
      onSaved: (value)=>securityCode.text=value!,
      textInputAction: TextInputAction.next,
      validator: (value)
      {
        if(value!.isEmpty){
          return ('Enter The Code!');
        }else if(value.length!=3){
          return ('Wrong Security Code!');
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: 'Security Code',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )
      ),
    );

    final firstNameField = TextFormField(
      controller: firstName,
      keyboardType: TextInputType.text,
      onSaved: (value)=>firstName.text=value!,
      textInputAction: TextInputAction.next,
      validator: (value)
      {
        if (value!.isEmpty) {
          return ("Cannot be Empty");
        }else if(value.length>10){
          return ('Name should be max 10 char');
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: 'First Name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )
      ),
    );

    final lastNameField = TextFormField(
      controller: lastName,
      keyboardType: TextInputType.text,
      onSaved: (value)=>lastName.text=value!,
      textInputAction: TextInputAction.done,
      validator: (value)
      {
        if (value!.isEmpty) {
          return ("Cannot be Empty");
        }else if(value.length>10){
          return ('Name should be max 10 char');
        }
      },
      decoration: InputDecoration(
          labelText: 'Last Name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credit Card Input Exercise'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: cardNumber,
                ),
                const SizedBox(height: 10,),
                 Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Row(
                     //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: <Widget>[
                       Expanded (child: dateTime),
                       const SizedBox(width: 10.0,),
                       Expanded (child: securtiy),
                     ],
                   ),
                 ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded (child: firstNameField),
                      const SizedBox(width: 10.0,),
                      Expanded (child: lastNameField),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          if(_formKey.currentState!.validate()){
                            showPopUp(context);
                          }
                        });
                      },
                      child: const Text('SUBMIT PAYMENT'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        fixedSize: Size(MediaQuery.of(context).size.width,45),
                      ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

