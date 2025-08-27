import 'dart:async';
import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class HomePageSearchWidget extends StatefulWidget {
  final TextEditingController searchCtrl;
  final Function onSearch;
  final Function? onClear;

  const HomePageSearchWidget({
    super.key,
    required this.searchCtrl,
    required this.onSearch,
    this.onClear,
  });

  @override
  State<HomePageSearchWidget> createState() => _HomePageSearchWidgetState();
}

class _HomePageSearchWidgetState extends State<HomePageSearchWidget> {
  bool isloading = false;

  Timer? debounce;

  onSearchChange(val) {
    if (debounce?.isActive ?? false) {
      setState(() {});
      debounce?.cancel();
    }
    debounce = Timer(const Duration(milliseconds: 800), fetch);
  }

  fetch() async {
    setState(() {
      isloading = true;
    });
    await widget.onSearch();
    setState(() {
      isloading = false;
    });
  }

  clear() {
    if (widget.onClear != null) {
      widget.onClear!();
    } else {
      widget.searchCtrl.clear();
      widget.onSearch();
      FocusManager.instance.primaryFocus?.unfocus();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      controller: widget.searchCtrl,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onChanged: onSearchChange,
      cursorColor: AppColors.primary,
      style: Theme.of(context).textTheme.bodyMedium!,
      decoration: InputDecoration(
        prefixIcon: Icon(
          HeroiconsOutline.magnifyingGlass,
          color: Theme.of(context).appBarTheme.iconTheme!.color,
        ),
        errorText: null,

        hintText: AppStrings.search,
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.gray,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 15,
        ),
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        filled: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.lightGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.lightGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.lightGray),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.lightGray),
        ),
        suffixIcon: isloading
            ? Container(
                width: 22,
                alignment: Alignment.center,
                child: const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                ),
              )
            : widget.searchCtrl.text.isNotEmpty
            ? InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: clear,
                child: Icon(
                  Icons.clear,
                  color: Theme.of(context).appBarTheme.iconTheme!.color,
                ),
              )
            : null,
      ),
    );
  }
}
