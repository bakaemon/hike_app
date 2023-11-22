import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hike_app/widgets/input.dart';
import 'package:hike_app/widgets/scrollpage.dart';
import 'package:sqflite/sqflite.dart';

import '../database/entity/hike.dart';
import '../database/repository/hike_repo.dart';

class HikeForm extends StatefulWidget {
  const HikeForm({super.key, required this.db, this.hike});

  final Database db;
  final Hike? hike;

  @override
  _HikeFormState createState() => _HikeFormState();
}

class _HikeFormState extends State<HikeForm> {
  final _formKey = GlobalKey<FormState>();
  late Hike? _hike;
  late HikeRepo _repository;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  bool? _parking = false;
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _guideController = TextEditingController();
  String _difficulty = '';
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _repository = HikeRepo(db: widget.db);
    _hike = widget.hike;
    if (_hike != null) {
      _nameController.text = _hike?.name ?? '';
      _locationController.text = _hike?.location ?? '';
      _dateController.text = _hike?.date ?? '';
      _lengthController.text = _hike?.length.toString() ?? '';
      _parking = _hike?.parking;
      _descController.text = _hike?.desc ?? '';
      _guideController.text = _hike?.guide ?? '';
      _difficulty = _hike?.difficulty ?? '';
      _priceController.text = _hike?.price.toString() ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollPage(
      hasBackArrow: true,
      titleText: _hike == null ? 'New Hike' : 'Edit Hike',
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextInputUtil.input(
              label: 'Name',
              initialValue: _hike?.name,
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextInputUtil.input(
              label: 'Location',
              controller: _locationController,
              initialValue: _hike?.location,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a location';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextInputUtil.input(
              label: 'Date',
              controller: _dateController,
              initialValue: _hike?.date,
              readOnly: true,
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().add(const Duration(days: -365)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                ).then((value) {
                  if (value != null) {
                    _dateController.text = value.toString();
                  }
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter date';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextInputUtil.input(
              label: 'Length',
              controller: _lengthController,
              keyboardType: TextInputType.number,
              initialValue: _hike?.length.toString(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter length';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextInputUtil.radioGroup(
              label: 'Parking available',
              items: {
                'Yes': true,
                'No': false,
              },
              groupValue: _parking,
              onChanged: (value) {
                setState(() {
                  _parking = value;
                });
              },
              errorText: _parking == null ? 'Please select parking' : null,
            ),
            const SizedBox(height: 10),
            TextInputUtil.input(
              label: 'Description',
              controller: _descController,
              initialValue: _hike?.desc,
            ),
            const SizedBox(height: 10),
            TextInputUtil.input(
              label: 'Guide',
              controller: _guideController,
              initialValue: _hike?.guide,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter guide\'s name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextInputUtil.radioGroup(
              label: 'Difficulty',
              items: {
                'Easy': 'easy',
                'Medium': 'medium',
                'Hard': 'hard',
              },
              groupValue: _difficulty,
              onChanged: (value) {
                setState(() {
                  _difficulty = value!;
                });
              },
              errorText:
                  _difficulty.isEmpty ? 'Please select difficulty' : null,
            ),
            const SizedBox(height: 10),
            TextInputUtil.input(
              label: 'Price',
              controller: _priceController,
              keyboardType: TextInputType.number,
              initialValue: _hike?.price.toString(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a price';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _confirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  fixedSize: const Size.fromWidth(100),
                ),
                child: const Text('Confirm',
                    style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
    );
  }

  void _confirm() {
    if (_formKey.currentState!.validate()) {
// if hike is null, create a new one
      if (_hike == null) {
        final hike = Hike(
          name: _nameController.text,
          location: _locationController.text,
          date: _dateController.text,
          length: int.parse(_lengthController.text),
          difficulty: _difficulty,
          parking: _parking,
          desc: _descController.text,
          guide: _guideController.text,
          price: double.parse(_priceController.text),
        );
        _repository.insert(hike);
        // show snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('A new record created'),
          ),
        );
      } else {
        // if hike is not null, update the existing one
        final hike = Hike(
          id: _hike?.id,
          name: _nameController.text,
          location: _locationController.text,
          date: _dateController.text,
          length: int.parse(_lengthController.text),
          parking: _parking,
          desc: _descController.text,
          guide: _guideController.text,
          difficulty: _difficulty,
          price: double.parse(_priceController.text),
        );
        _repository.update(hike);
        // show snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The record updated'),
          ),
        );
      }
      Navigator.pop(context);
    }
  }
}
