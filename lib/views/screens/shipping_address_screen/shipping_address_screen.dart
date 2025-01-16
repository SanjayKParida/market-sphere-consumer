import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_sphere/controllers/authentication/auth_controller.dart';
import 'package:market_sphere/provider/user_provider.dart';
import 'package:market_sphere/services/snackbar_service.dart';

class ShippingAddressScreen extends ConsumerStatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends ConsumerState<ShippingAddressScreen> {
  late TextEditingController _stateController,
      _cityController,
      _localityController;
  bool isLoading = false;
  final AuthController _authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //READ THE CURRENT USER DATA FROM THE PROVIDER
    final user = ref.read(userProvider);
    //INITIALIZE CONTROLLERS WITH CURRENT DATA IF AVAILABLE, IF NOT INITIALIZE WITH EMPTY STRING
    _stateController = TextEditingController(text: user!.state ?? "");
    _cityController = TextEditingController(text: user.state ?? "");
    _localityController = TextEditingController(text: user.state ?? "");
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
    final updateUser = ref.read(userProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Delivery",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            fontSize: 24,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Where will your order\nbe shipped?",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildTextField(
                        controller: _stateController,
                        label: "State",
                        hint: "Enter your state",
                        icon: Icons.location_on_outlined,
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _cityController,
                        label: "City",
                        hint: "Enter your city",
                        icon: Icons.location_city_outlined,
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _localityController,
                        label: "Locality",
                        hint: "Enter your locality",
                        icon: Icons.home_outlined,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            if (_formKey.currentState!.validate()) {
              await _authController
                  .updateUserAddress(
                      context: context,
                      id: user!.id,
                      state: _stateController.text,
                      city: _cityController.text,
                      locality: _localityController.text)
                  .whenComplete(() {
                updateUser.recreateUserState(
                  state: _stateController.text,
                  city: _cityController.text,
                  locality: _localityController.text,
                );
              });
            }
            setState(() {
              isLoading = false;
            });
            showSnackbar(context, 'Address updated!');
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isLoading ? Colors.grey : const Color(0xFF3854EE),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: isLoading
              ? const SizedBox(
                  height: 30,
                  width: 30,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ))
              : Text(
                  "Save Address",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label,
      required String hint,
      required IconData icon,
      required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3854EE), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade400, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade400, width: 2),
        ),
        labelStyle: GoogleFonts.poppins(
          color: Colors.grey[700],
          fontSize: 14,
        ),
        hintStyle: GoogleFonts.poppins(
          color: Colors.grey[400],
          fontSize: 14,
        ),
      ),
      style: GoogleFonts.poppins(
        color: Colors.black87,
        fontSize: 16,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your $label";
        }
        return null;
      },
    );
  }
}
