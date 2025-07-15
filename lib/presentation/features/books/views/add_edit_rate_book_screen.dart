import 'package:books/components/shared_widgets/app_text.dart';
import 'package:books/components/shared_widgets/custom_snackbar.dart';
import 'package:books/components/shared_widgets/image_picker.dart';
import 'package:books/core/constants/app_strings.dart';
import 'package:books/presentation/features/books/blocs/review_books_cubit/review_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditRateBookScreen extends StatefulWidget {
  final String bookId;
  final String bookTitle;

  const AddEditRateBookScreen({
    super.key,
    required this.bookId,
    required this.bookTitle,
  });

  @override
  State<AddEditRateBookScreen> createState() => _AddRateBookScreenState();
}

class _AddRateBookScreenState extends State<AddEditRateBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();
  String? imageFilePath;
  double _rating = 3.0;
  bool _isSubmitting = false;

  void _submitReview() async {
    if (!_formKey.currentState!.validate()) return;

    if (imageFilePath == null || imageFilePath!.isEmpty) {
      CustomSnackbar.show(context, AppStrings.selectAnImage);
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      context.read<BookReviewCubit>().addReview(
        bookId: widget.bookId,
        userName: _nameController.text,
        comment: _reviewController.text,
        rating: _rating,
        imageFilePath: imageFilePath!,
      );

      if (mounted) {
        CustomSnackbar.show(context, AppStrings.reviewAddedSuccessfully);
        Navigator.pop(context);
      }
    } catch (e) {
      CustomSnackbar.show(context, 'Error adding review: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          "${AppStrings.rateBookPrefix}${widget.bookTitle}",
          fontSize: 22,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(AppStrings.yourRating, kind: TextKind.heading),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return IconButton(
                              icon: Icon(
                                index < _rating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 36,
                              ),
                              onPressed: () {
                                setState(() => _rating = index + 1);
                              },
                            );
                          }),
                        ),
                        const SizedBox(height: 24),
                        AppText(AppStrings.yourName, kind: TextKind.heading),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: AppStrings.enterYourName,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        AppText(AppStrings.yourReview, kind: TextKind.heading),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _reviewController,
                          decoration: InputDecoration(
                            hintText: AppStrings.enterYourThoughts,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.reviewCommentRequired;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        Imagepicker(
                          initialImage: imageFilePath,
                          onImageChanged: (filePath) {
                            setState(() {
                              imageFilePath = filePath;
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isSubmitting ? null : _submitReview,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              foregroundColor: Colors.white,
                            ),
                            child: _isSubmitting
                                ? const CircularProgressIndicator()
                                : const Text(AppStrings.reviewSubmit),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
