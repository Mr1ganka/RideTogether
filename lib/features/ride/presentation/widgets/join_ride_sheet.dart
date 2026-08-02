import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ride_together/core/theme/app_durations.dart';
import 'package:ride_together/core/theme/app_radius.dart';
import 'package:ride_together/core/theme/app_spacing.dart';
import 'package:ride_together/features/location/presentation/widgets/background_consent_sheet.dart';
import 'package:ride_together/features/ride/presentation/providers/ride_controller_provider.dart';

import 'create_ride_sheet.dart';

class JoinRideSheet extends ConsumerStatefulWidget {
  const JoinRideSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      sheetAnimationStyle: const AnimationStyle(
        duration: AppDurations.normal,
        reverseDuration: AppDurations.fast,
        curve: Curves.fastOutSlowIn,
      ),
      builder: (context) => const JoinRideSheet(),
    );
  }

  @override
  ConsumerState<JoinRideSheet> createState() => _JoinRideSheetState();
}

class _JoinRideSheetState extends ConsumerState<JoinRideSheet> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _errorMessage = null;
    });

    final joinCode = _codeController.text.trim().toUpperCase();
    final ride = await ref
        .read(rideControllerProvider.notifier)
        .joinRide(joinCode);

    if (mounted) {
      if (ride != null) {
        Navigator.of(context).pop();
        BackgroundConsentSheet.show(context);
      } else {
        final error = ref.read(rideControllerProvider).error;
        setState(() {
          _errorMessage = error != null
              ? error.toString().replaceAll('Exception: ', '')
              : 'Failed to join ride. Please verify code.';
        });
      }
    }
  }

  void _openCreateRideSheet() {
    Navigator.of(context).pop();
    CreateRideSheet.show(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAsyncLoading = ref.watch(rideControllerProvider).isLoading;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md + bottomPadding,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.xl),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Join Group Ride',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Enter the 6-character code provided by your ride leader.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: theme.colorScheme.error,
                        size: 20,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onErrorContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _codeController,
                  autofocus: false,
                  textCapitalization: TextCapitalization.characters,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    letterSpacing: 8,
                    fontWeight: FontWeight.bold,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                  ],
                  decoration: InputDecoration(
                    hintText: 'CODE12',
                    hintStyle: theme.textTheme.headlineSmall?.copyWith(
                      letterSpacing: 8,
                      color: theme.colorScheme.outline.withValues(alpha: 0.4),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().length != 6) {
                      return 'Please enter a valid 6-character code';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              FilledButton(
                onPressed: isAsyncLoading ? null : _submit,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
                child: isAsyncLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Join Ride',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
              const SizedBox(height: AppSpacing.xs),
              TextButton(
                onPressed: isAsyncLoading ? null : _openCreateRideSheet,
                child: const Text('Want to create a new ride instead?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
