import 'package:citizen_feedback/blocs/register/register_bloc.dart';
import 'package:citizen_feedback/blocs/register/register_event.dart';
import 'package:citizen_feedback/blocs/register/register_state.dart';
import 'package:citizen_feedback/widgets/textfield_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropDownWidget extends StatefulWidget {
  DropDownWidget(
      {Key key, this.value, this.hintText, this.icon})
      : super(key: key);

  final List<dynamic> value;
  final String hintText;
  final Icon icon;

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  var _category;
  bool errorCondition = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return DropdownButtonFormField(
          icon: Icon(null),
          items: widget.value.map((dynamic category) {
            return new DropdownMenuItem(
                value: category,
                child: Row(
                  children: <Widget>[
                    //Icon(Icons.star),
                    Text(category.toString()),
                  ],
                ));
          }).toList(),
          validator: (value) {
            if(widget.hintText == 'Select Region') {
              return state.isValidRegion ? null : 'please fill this field';
            } else if(widget.hintText == 'Select District') {
              return state.isValidDistrict ? null : 'please fill this field';
            } else {
              return null;
            }
          },
          onChanged: (newValue) {
            // do other stuff with _districts
            setState(() => _category = newValue);
            if(widget.hintText == 'Select Region') {
              context.read<RegisterBloc>().add(RegisterRegionChanged(region: newValue));
            } else if(widget.hintText == 'Select District') {
              context.read<RegisterBloc>().add(RegisterDistrictChanged(district: newValue));
            }
          },
          value: _category,
          decoration: TextFieldDecoration(
              prefixIcon: widget.icon,
              hintText: widget.hintText,
              suffixIcon: Icon(Icons.arrow_drop_down),
          ).draw()
      );
    });
  }
}
