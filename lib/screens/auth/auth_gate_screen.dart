import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../models/models.dart';

/// Two-step verification: DU email format check, then a camera scan of
/// the student ID card's QR code. This is local-only for now — it does
/// not check against any real DU database (see docs/ROADMAP.md).
class AuthGateScreen extends StatefulWidget {
  final ValueChanged<AppUser> onVerified;

  const AuthGateScreen({super.key, required this.onVerified});

  @override
  State<AuthGateScreen> createState() => _AuthGateScreenState();
}

class _AuthGateScreenState extends State<AuthGateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  bool _emailStepDone = false;
  String? _fullName;
  String? _email;

  // Domain must be a department subdomain of du.ac.bd, e.g.
  // @cs.du.ac.bd, @it.du.ac.bd — NOT a bare @du.ac.bd.
  static final _duDomainPattern = RegExp(
    r'^[a-zA-Z0-9]+\.du\.ac\.bd$',
  );

  // Local part should roughly look like name-roll-reg (e.g.
  // akidul-15-2022716316). Kept lenient on purpose: this is a soft
  // shape check, not a hard validation, since exact roll/reg digit
  // counts may vary by department/year.
  static final _localPartShapePattern = RegExp(
    r'^[a-zA-Z]+-[a-zA-Z0-9]+-[a-zA-Z0-9]+$',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitEmailStep() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _fullName = _nameController.text.trim();
        _email = _emailController.text.trim();
        _emailStepDone = true;
      });
    }
  }

  void _onQrDetected(BarcodeCapture capture) {
    // Any successful scan is treated as verification for the prototype.
    // Real DU ID validation isn't possible yet (see docs/ROADMAP.md).
    final user = AppUser(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: _fullName ?? '',
      email: _email ?? '',
      verified: true,
    );
    widget.onVerified(user);
  }

  String? _validateEmail(String? v) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return 'Enter your email';

    final parts = value.split('@');
    if (parts.length != 2) return 'Enter a valid email address';

    final localPart = parts[0];
    final domain = parts[1].toLowerCase();

    if (!_duDomainPattern.hasMatch(domain)) {
      return 'Must be a DU department email (e.g. name@it.du.ac.bd)';
    }

    if (!_localPartShapePattern.hasMatch(localPart)) {
      return 'Expected format: name-roll-reg (e.g. akidul-15-2022716316)';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify your DU account'),
        leading: _emailStepDone
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => setState(() => _emailStepDone = false),
              )
            : null,
      ),
      body: SafeArea(
        child: _emailStepDone ? _buildScanStep() : _buildEmailStep(),
      ),
    );
  }

  Widget _buildEmailStep() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const Text(
              'Ghore Khai',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Only for Dhaka University students.'),
            const SizedBox(height: 32),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full name'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Enter your name' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'DU email',
                hintText: 'name-roll-reg@dept.du.ac.bd',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _submitEmailStep,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScanStep() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Scan the QR code on your DU student ID card.',
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: MobileScanner(onDetect: _onQrDetected),
        ),
      ],
    );
  }
}