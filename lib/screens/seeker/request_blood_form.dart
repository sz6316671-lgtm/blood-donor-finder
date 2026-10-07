import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../widgets/my_button.dart';
import '../../database/db_helper.dart';

class RequestBloodForm extends StatefulWidget {
  const RequestBloodForm({super.key});

  @override
  State<RequestBloodForm> createState() => _RequestBloodFormState();
}

class _RequestBloodFormState extends State<RequestBloodForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _hospitalController = TextEditingController();

  String _selectedBloodGroup = 'B+';
  bool _isUrgent = false;
  final List<String> _bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _hospitalController.dispose();
    super.dispose();
  }


  Future<void> _submitRequest() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> requestData = {
        'patientName': _nameController.text.trim(),
        'bloodGroup': _selectedBloodGroup,
        'phone': _phoneController.text.trim(),
        'hospital': _hospitalController.text.trim(),
        'isUrgent': _isUrgent ? 1 : 0,
      };

      await DBHelper().insertRequest(requestData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Blood Request Posted!"), backgroundColor: Colors.green),
        );
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Blood", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryRed,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Emergency Detail", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryRed)),
              const SizedBox(height: 20),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Patient Name", border: OutlineInputBorder(), prefixIcon: Icon(Icons.person)),
                validator: (val) => (val == null || val.isEmpty) ? "Enter patient name" : null,
              ),
              const SizedBox(height: 20),

              DropdownButtonFormField(
                value: _selectedBloodGroup,
                decoration: const InputDecoration(labelText: "Blood Group Required", border: OutlineInputBorder(), prefixIcon: Icon(Icons.bloodtype)),
                items: _bloodGroups.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                onChanged: (val) => setState(() => _selectedBloodGroup = val as String),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: "Contact Number", border: OutlineInputBorder(), prefixIcon: Icon(Icons.phone)),
                validator: (val) => (val == null || val.length < 11) ? "Enter valid phone" : null,
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _hospitalController,
                decoration: const InputDecoration(labelText: "Hospital Name", border: OutlineInputBorder(), prefixIcon: Icon(Icons.local_hospital)),
                validator: (val) => (val == null || val.isEmpty) ? "Enter hospital name" : null,
              ),
              const SizedBox(height: 10),

              SwitchListTile(
                title: const Text("Mark as Urgent Request", style: TextStyle(fontWeight: FontWeight.w500)),
                value: _isUrgent,
                activeColor: AppColors.primaryRed,
                onChanged: (val) => setState(() => _isUrgent = val),
              ),
              const SizedBox(height: 30),

              MyButton(title: "Submit Request", onTap: _submitRequest),
            ],
          ),
        ),
      ),
    );
  }
}