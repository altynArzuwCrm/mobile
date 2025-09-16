import 'dart:async';

import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/clients/domain/entities/client_entity.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/locator.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientsSelector extends StatefulWidget {
  const ClientsSelector({super.key, required this.onSelectClient, this.initialValue});

  final ValueChanged onSelectClient;
  final String? initialValue;

  @override
  State<ClientsSelector> createState() => _ClientsSelectorState();
}

class _ClientsSelectorState extends State<ClientsSelector> {
  late  TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;
  String? _lastQuery; // to avoid firing the same request repeatedly
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }
  @override
  void dispose() {
    _debounce?.cancel();

    // make sure suggestions overlay is closed before disposal
    _focusNode.unfocus();
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value, List<ClientEntity> clients) {
    // Cancel previous timer
    _debounce?.cancel();

    // Start a new timer: backend request only fires after 500ms of inactivity
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = value.trim();
      if (query.isEmpty) {
        widget.onSelectClient(null);
        _lastQuery = null;
        return;
      }

      final lowerQuery = query.toLowerCase();

      // Check exact match
      final matches = clients.where((p) => p.name.toLowerCase() == lowerQuery);
      final exactMatch = matches.isNotEmpty ? matches.first : null;
      if (exactMatch != null) {
        widget.onSelectClient(exactMatch.id.toString());
        _lastQuery = null;
        return;
      }

      // Check partial match (suggestions only)
      final partialMatch = clients.any(
        (p) => p.name.toLowerCase().startsWith(lowerQuery),
      );
      if (partialMatch) {
        _lastQuery = null;
        return; // show suggestions, no backend request
      }

      // No local match → call backend if query changed
      if (_lastQuery == query) return;
      _lastQuery = query;

      locator<ClientsCubit>().getAllClients(UserParams(search: query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientsCubit, ClientsState>(
      builder: (context, state) {
        final names = state is ClientsLoaded
            ? state.data.map((c) => c.name).toList()
            : <String>[];

        final inputDecoration = InputDecoration(
          hintText: state is ClientsLoading
              ? AppStrings.loadingClients
              : state is ClientsError
              ? AppStrings.notLoaded
              : AppStrings.selectClient,
          hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
          suffixIcon: const Icon(
            Icons.keyboard_arrow_down_outlined,
            color: AppColors.gray,
            size: 30,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.timeBorder,
              // highlight color when focused
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.timeBorder,
              // highlight color when focused
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.timeBorder, width: 1),
          ),
        );

        return EasyAutocomplete(
          controller: _controller,
          focusNode: _focusNode,
          suggestions: names,
          inputTextStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),

          debounceDuration: Duration.zero,
          // we handle debounce manually
          onChanged: (value) =>
              _onSearchChanged(value, state is ClientsLoaded ? state.data : []),
          validator: (v) {
            if(widget.initialValue != null){
              return null;
            }
            else if (v == null ||
                !names.map((n) => n.toLowerCase()).contains(v.toLowerCase())) {
              return AppStrings.selectClient;
            }
            return null;
          },

          decoration: inputDecoration,
        );
      },
    );
  }
}
