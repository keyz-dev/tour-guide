import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tour_aid/components/elevated_button.dart';
import 'package:tour_aid/components/my_text.dart';
import 'package:tour_aid/components/text_field.dart';
import 'package:tour_aid/models/attraction.dart';
import 'package:tour_aid/screens/home/main.dart';
import 'package:tour_aid/services/attractions.dart';
import 'package:tour_aid/services/cloudinary.dart';
import 'package:tour_aid/utils/colors.dart';

class AddAttractionScreen extends StatefulWidget {
  const AddAttractionScreen({super.key});
  @override
  State<AddAttractionScreen> createState() => _AddAttractionScreenState();
}

class _AddAttractionScreenState extends State<AddAttractionScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _attractionSite = AttractionSite(
      name: '',
      categoryName: '',
      town: '',
      description: '',
      latitude: 0.0,
      longitude: 0.0,
      primaryImage: '',
      additionalImages: []);

  final ImagePicker _picker = ImagePicker();
  File? _primaryImage;
  List<XFile> _additionalImages = [];

  Future<void> _selectPrimaryImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _primaryImage = File(image.path);
      });
    }
  }

  Future<void> _selectAdditionalImages() async {
    final images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _additionalImages = images;
      });
    }
  }

  void _saveAttractionSite() async {
    // Activate the loading spinner
    setState(() {
      _isLoading = true;
    });

    try {
      // Verify if the form is validated
      if (!_formKey.currentState!.validate())
        throw Exception("Form data isn't valid");

      // save the form data in the onSaved fields
      _formKey.currentState!.save();

      // upload primary image to cloudinary and save the url
      if (_primaryImage != null) {
        var uploadResult = await CloudinaryService()
            .uploadImage(_primaryImage!, imagePath: "primary_images");
        if (uploadResult['success'] == false) {
          throw Exception(uploadResult['value']);
        }
        _attractionSite.primaryImage = uploadResult['value'];
      }

      // upload the additional images
      if (_additionalImages.isNotEmpty) {
        for (var image in _additionalImages) {
          File imageFile = File(image.path);
          var uploadResult = await CloudinaryService()
              .uploadImage(imageFile, imagePath: "additional_images");
          if (uploadResult['success'] == false) {
            throw Exception(uploadResult['value']);
          }
          _attractionSite.additionalImages.add(uploadResult['value']);
        }
      }
      var result =
          await AttractionService().createAttractionSite(_attractionSite);

      // Verify creation and display message accordingly
      if (result != null) throw Exception(result);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Attraction site added!')));
      _formKey.currentState!.reset();
      setState(() {
        _attractionSite.additionalImages.clear();
        _primaryImage = null;
        _additionalImages.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = "Add Attraction Sites";

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  MyTextField(
                      hintText: "Enter the site name",
                      labelText: "Name",
                      icon: Icons.near_me,
                      onSaved: (value) => _attractionSite.name = value!,
                      fillColor: AppColors.indicatorInActive,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please enter a name'
                          : null),
                  SizedBox(
                    height: 8,
                  ),
                  MyTextField(
                      hintText: "Category Name",
                      labelText: "Category",
                      icon: Icons.category,
                      onSaved: (value) => _attractionSite.categoryName = value!,
                      fillColor: AppColors.indicatorInActive,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please enter a category name'
                          : null),
                  SizedBox(
                    height: 8,
                  ),
                  MyTextField(
                      hintText: "Town",
                      labelText: "Where is it located?",
                      icon: Icons.location_city,
                      onSaved: (value) => _attractionSite.town = value!,
                      fillColor: AppColors.indicatorInActive,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please enter town name'
                          : null),
                  SizedBox(
                    height: 8,
                  ),
                  MyTextField(
                      hintText: "Latitude",
                      labelText: "Geo Latitude",
                      icon: Icons.location_on_rounded,
                      keyboardType: TextInputType.numberWithOptions(),
                      onSaved: (value) =>
                          _attractionSite.latitude = double.parse(value!),
                      fillColor: AppColors.indicatorInActive,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please enter the latitude'
                          : null),
                  SizedBox(
                    height: 8,
                  ),
                  MyTextField(
                      hintText: "Longitude",
                      labelText: "Geo Longitude",
                      icon: Icons.location_on_rounded,
                      keyboardType: TextInputType.numberWithOptions(),
                      onSaved: (value) =>
                          _attractionSite.longitude = double.parse(value!),
                      fillColor: AppColors.indicatorInActive,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please enter the longitude'
                          : null),
                  SizedBox(
                    height: 8,
                  ),
                  MyTextField(
                    hintText: "paste in the website url",
                    labelText: "Website Url",
                    icon: Icons.web,
                    onSaved: (value) => _attractionSite.websiteUrl = value,
                    fillColor: AppColors.indicatorInActive,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  MyTextField(
                    hintText: "Enter a phone number",
                    labelText: "Site Phone number (+237)",
                    icon: Icons.call,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
                    onSaved: (value) => _attractionSite.phoneNumber = value,
                    fillColor: AppColors.indicatorInActive,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  MyTextField(
                      hintText: "Enter a description",
                      labelText: "Description",
                      onSaved: (value) => _attractionSite.description = value!,
                      maxLines: 5,
                      fillColor: AppColors.indicatorInActive,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please enter a Description'
                          : null),
                  SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: _selectPrimaryImage,
                    child: Text('Select Primary Image'),
                  ),
                  if (_primaryImage != null) ...[
                    SizedBox(height: 10),
                    Image.file(File(_primaryImage!.path), height: 100),
                  ],
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _selectAdditionalImages,
                    child: Text('Select Additional Images'),
                  ),
                  if (_additionalImages.isNotEmpty) ...[
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8.0,
                      children: _additionalImages.map((img) {
                        return Image.file(File(img.path), height: 100);
                      }).toList(),
                    ),
                  ],
                  SizedBox(height: 20),
                  _isLoading
                      ? MyElevatedButton(
                          onPressed: () {},
                          radius: 5.0,
                          width: double.infinity,
                          backgroundColor: AppColors.indicatorActive,
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: AppColors.primaryWhite,
                              strokeWidth: 3,
                            ),
                          ))
                      : MyElevatedButton(
                          onPressed: _saveAttractionSite,
                          radius: 5.0,
                          width: double.infinity,
                          backgroundColor: AppColors.indicatorActive,
                          child: MyText(
                              text: 'Add Site',
                              color: AppColors.primaryWhite,
                              weight: FontWeight.w600,
                              align: TextAlign.center,
                              size: 17),
                        ),
                ],
              ),
            ),
          ),
        ));
  }
}
