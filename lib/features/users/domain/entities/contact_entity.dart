import 'dart:typed_data';


class ContactEntity {
  final String? id;
  final String? displayName;
  final Uint8List? photo;
  final Uint8List? thumbnail;


  ContactEntity(
      {this.id,
        this.displayName,
        this.photo,
        this.thumbnail,
      });
}