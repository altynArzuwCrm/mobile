import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/text_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Color? borderColor;
  final String? prefixText;
  final String? labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final String? Function(String?)? validator;
  final bool isSubmitted;
  final bool? isEnabled;
  final bool upperCase;
  final Function(String)? onChange;
  final TextStyle? labelStyle;
  final int maxLines;
  final TextCapitalization textCapitalization;
  final bool? isDense;
  final bool? autofocus;
  final bool? obscureText;

  const KTextField({
    super.key,
    required this.controller,
    this.keyboardType,
    this.hintText,
    this.hintStyle,
    this.style,
    this.borderColor,
    this.prefixText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.validator,
    this.isEnabled,
    required this.isSubmitted,
    this.upperCase = false,
    this.onChange,
    this.labelStyle,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.isDense,
    this.autofocus,
    this.obscureText,
  });

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  bool active = false;

  @override
  void initState() {
    active = widget.controller.text.isNotEmpty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      showCursor: true,
      cursorColor: AppColors.white,
      obscureText: widget.obscureText ?? false,
      contextMenuBuilder: kContextMenuBuilder,
      autofocus: widget.autofocus ?? false,
      autovalidateMode: widget.isSubmitted
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: TextInputAction.done,
      textCapitalization: widget.textCapitalization,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      enabled: widget.isEnabled,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onChanged: widget.prefixIcon != null
          ? (val) {
        if (widget.onChange != null) {
          widget.onChange!(val);
        }
        if (active && widget.controller.text.isEmpty) {
          setState(() {
            active = false;
          });
        } else if (!active && widget.controller.text.isNotEmpty) {
          setState(() {
            active = true;
          });
        }
      }
          : widget.onChange,
      validator: widget.validator ??
              (value) {
            if (value != null && value.isNotEmpty) {
              return null;
            }
            return 'Hokman doldurmaly'; //AppLocalizations.of(context)!.requiredToFill;
          },
      decoration: InputDecoration(
        isDense: widget.isDense,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
          widget.prefixIcon,
          color: Colors.white,
        )
            : null,
        suffixIcon: widget.suffixIcon != null
            ? Container(
          margin: const EdgeInsets.only(right: 13.0),
          height: 24,
          width: 24,
          child: widget.suffixIcon,
        )
            : null,
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 24,
          maxWidth: 44,
        ),
        prefixText: widget.prefixText,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? TextStyle(
          color: AppColors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: TextFonts.nunito,
        ),
        labelText: widget.labelText,
        labelStyle: widget.labelStyle,
        alignLabelWithHint: true,
        // fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        filled: false,
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusColor: widget. borderColor ?? AppColors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color:widget. borderColor ?? AppColors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget. borderColor ?? AppColors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        errorMaxLines: 2,
        prefixStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: TextFonts.nunito,
          // height: 1.0,
        ),
      ),
      style:widget. style ?? TextStyle(
        color: AppColors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: TextFonts.nunito,
      ),
    );
  }
}

class PhoneNumField extends StatelessWidget {
  final TextEditingController phoneCtrl;
  final bool isSubmitted;
  final String? hint;
  final String? label;
  final bool showContactPicker;
  final Function(String)? onChange;

  const PhoneNumField({
    super.key,
    required this.phoneCtrl,
    required this.isSubmitted,
    this.hint,
    this.label,
    this.showContactPicker = true,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return KTextField(
      controller: phoneCtrl,
      isSubmitted: isSubmitted,
      keyboardType: TextInputType.number,
      prefixText: '+993 | ',
      maxLength: 8,
      labelText: label ?? '',
      onChange: onChange,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'to fill'; //AppLocalizations.of(context)!.requiredToFill;
        } else if (val.length < 8) {
          return 'phoneNumberIncorrect'; //AppLocalizations.of(context)!.phoneNumberIncorrect;
        }
        num? v = num.tryParse(val);
        if (v == null) {
          return 'phoneNumberIncorrect'; //AppLocalizations.of(context)!.phoneNumberIncorrect;
        }
        return null;
      },
    );
  }
}

Widget kContextMenuBuilder(
    BuildContext context, EditableTextState editableTextState) {
  return AdaptiveTextSelectionToolbar.editable(
    clipboardStatus: ClipboardStatus.pasteable,
    onPaste: () async {
      if (await Clipboard.hasStrings()) {
        final val = await Clipboard.getData('text/plain');
        if (val != null && val.text != null) {
          String text = val.text!;
          if (text.startsWith('+993')) {
            text = text.replaceFirst('+993', '');
          } else if (text.startsWith('993')) {
            text = text.replaceFirst('993', '');
          }

          text = text.replaceAll(' ', '');
          if (val.text != text) {
            await Clipboard.setData(ClipboardData(text: text));
          }
        }
      }
      editableTextState.pasteText(SelectionChangedCause.toolbar);
    },
    onCopy: () =>
        editableTextState.copySelection(SelectionChangedCause.toolbar),
    onCut: () => editableTextState.cutSelection(SelectionChangedCause.toolbar),
    onLiveTextInput: null,
    onSelectAll: () =>
        editableTextState.selectAll(SelectionChangedCause.toolbar),
    anchors: editableTextState.contextMenuAnchors,
    onLookUp: () {},
    onSearchWeb: () {},
    onShare: () {},
    // onShare: () =>
    //     editableTextState.shareSelection(SelectionChangedCause.toolbar),
    // onLookUp: () =>
    //     editableTextState.lookUpSelection(SelectionChangedCause.tap),
    // onSearchWeb: () =>
    //     editableTextState.searchWebForSelection(SelectionChangedCause.toolbar),
  );
}