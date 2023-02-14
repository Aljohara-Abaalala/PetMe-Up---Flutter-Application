import 'package:flutter/material.dart';
class CheckboxFormField extends StatefulWidget {
  const CheckboxFormField({Key? key}) : super(key: key);
  @override
  State<CheckboxFormField> createState() => _CheckboxFormFieldState();
}

class _CheckboxFormFieldState extends State<CheckboxFormField> {
  bool agree = false;
  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (state){
        return Column(
          children: [
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title:
              TextButton(onPressed: (){
                showDialog(
                    context: context,
                    builder: (ctx) => const AlertDialog(
                      content: Text(
                        "• Pet owners are legally confined to  pay the required service fees.\n\n"
                            "• Pet Sitters and vets are  legally  confined to pay the required transaction fee, if your payment method fails or  your account past due we may place restrictions on your account \n\n"
                            "• PetMe Up is clear of any responsibility regarding harm caused to pets.\n\n"
                            "• You consent to the disclosure of certain personally identifiable information.\n\n",
                      ),
                    ));
              },
                child: const Text('I have read and accept digital contract. click here to read',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15),),),
              value: agree,
              onChanged: (value) {
                setState(() => agree = value!);
              },
            ),
            Text(
              state.errorText ?? '',
              style: TextStyle(
                color: Theme.of(context).errorColor,
              ),

            ),
          ],
        );
      },
      validator:(value) {
        if (!agree)
          return'you must check this box';
        return null;
    },
    );
  }
}
