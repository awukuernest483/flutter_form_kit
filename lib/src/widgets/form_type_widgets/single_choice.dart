import 'package:flutter/material.dart';
import 'package:flutter_form_kit/src/models/page.dart';
import 'package:flutter_form_kit/src/widgets/flutter_form_details.dart';

class SingleChoice extends StatefulWidget {
  final FlutterFormPage page;
  final Function(String) onOptionSelected;

  const SingleChoice(
      {super.key, required this.page, required this.onOptionSelected});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  int? hoveredIndex;
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.page.selectedOptions.isNotEmpty
        ? widget.page.selectedOptions.first
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(widget.page.options!.length,
          (index) => optionWidget(index, widget.page.options![index], context)),
    );
  }

  optionWidget(int index, String option, context) {
    final themeColor = FlutterFormDetails.of(context).themeColor;
    final textTheme = Theme.of(context).textTheme;
    String alphabet = String.fromCharCode('A'.codeUnitAt(0) + index);
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hoveredIndex = index;
        });
      },
      onExit: (_) {
        setState(() {
          hoveredIndex = null;
        });
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedOption = option;
          });
          widget.onOptionSelected(option);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          constraints: const BoxConstraints(minWidth: 200),
          decoration: BoxDecoration(
              color: themeColor.withOpacity(hoveredIndex == index ? 0.2 : 0.1),
              border: Border.all(
                  color: selectedOption == option
                      ? themeColor
                      : Colors.transparent),
              borderRadius: BorderRadius.circular(4)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: themeColor),
                    borderRadius: BorderRadius.circular(4)),
                child: Center(
                    child: Text(
                  alphabet,
                  style: textTheme.bodySmall?.copyWith(
                      color: themeColor, fontWeight: FontWeight.bold),
                )),
              ),
              const SizedBox(width: 8),
              Text(
                option,
                style: textTheme.titleMedium?.copyWith(color: themeColor),
              ),
              if (selectedOption == option) Icon(Icons.check, color: themeColor)
            ],
          ),
        ),
      ),
    );
  }
}
