import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/features/clients/presentation/cubits/clinets/clients_cubit.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientsSelector extends StatelessWidget {
  const ClientsSelector({super.key, required this.onSelectClient});

  final ValueChanged onSelectClient;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientsCubit, ClientsState>(
      builder: (context, state) {
        final inputDecoration = InputDecoration(
          hintText: state is ClientsLoading
              ? AppStrings.loadingClients
              : state is ClientsError
              ? AppStrings.notLoaded
              : AppStrings.selectClient,
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

        if (state is! ClientsLoaded) {
          return IgnorePointer(
            ignoring: true,
            child: EasyAutocomplete(
              suggestions: const <String>[],
              initialValue: '',
              onChanged: (_) {},
              decoration: inputDecoration,
            ),
          );
        } else {
          return EasyAutocomplete(
            suggestions: state.data.map((c) => c.name).toList(),
            initialValue: '',
            onChanged: (value) {
              final matches = state.data.where((c) => c.name == value).toList();
              if (matches.isNotEmpty) {
                final client = matches.first;
                onSelectClient(client.id.toString());
              } else {
                onSelectClient(null);
              }
            },
            validator: (v) {
              if (v == null) {
                return AppStrings.selectClient;
              }
              return null;
            },
            decoration: inputDecoration,
          );
        }
      },
    );
  }
}
