import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget toolbarIcon(IconData icon, String title, {Function() onTap}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.black38,
          size: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w400
            ),
          ),
        )
      ],
    ),
  );
}

Future<PickedFile> dialogPickImage(BuildContext context) async {
  PickedFile file = await showDialog<PickedFile>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          padding: const EdgeInsets.all(12),
          height: 120,
          child: PickImageWidget(),
        ),
      );
    }
  );
  return file;
}

Future<PickedFile> bottomSheetPickImage(BuildContext context) async {
  PickedFile file = await showModalBottomSheet<PickedFile>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
          child: Container(
            height: 140,
            width: double.infinity,
            child: PickImageWidget(),
          )
      );
    }
  );
  return file;
}

class PickImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 80,
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.white, padding: const EdgeInsets.all(10)),
                  onPressed: () {
                    getImage(true, context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Icon(
                          Icons.linked_camera,
                          color: Colors.black45,
                          size: 44,
                        ),
                      ),
                      Text(
                        "Camera",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 80,
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.white, padding: const EdgeInsets.all(10)),
                  onPressed: () {
                    getImage(false, context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Icon(
                          Icons.image,
                          color: Colors.black45,
                          size: 44,
                        ),
                      ),
                      Text(
                        "Gallery",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future getImage(bool fromCamera, BuildContext context) async {
    try {
      final picker = ImagePicker();
      PickedFile image = await picker.getImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 800.0,
        maxHeight: 600.0,
      );
      Navigator.of(context).pop(image);
    } catch (e) {
      Navigator.of(context).pop();
    }
  }
}