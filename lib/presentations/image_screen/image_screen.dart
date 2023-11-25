import 'package:crm/utils/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewScreen extends StatelessWidget {
  const ImagePreviewScreen({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: PhotoView(
          backgroundDecoration: const BoxDecoration(color: Colors.white),
            imageProvider:  NetworkImage(
          
              '$baseUrlForImage/$imageUrl',
              // headers: {'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2lzZmFhbmJhYy51ei9hcGkvbG9naW4iLCJpYXQiOjE3MDA4NjA1NTgsImV4cCI6MTcwMDg2NDE1OCwibmJmIjoxNzAwODYwNTU4LCJqdGkiOiIyVmY1ODdBNnV2ZjlZc2x4Iiwic3ViIjoiMSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.KzcLWOAi4aDyJHVYWdZCCOURgsfgmEgPB5_d48F8iSU'},
              // 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D',
              // headers: {'Authorization': 'Bearer $token'},
            ),
          ),
        ),
      ),
    );
  }
}
