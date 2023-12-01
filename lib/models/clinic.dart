import 'package:cloud_firestore/cloud_firestore.dart';

class Clinic {
  String? zipcd;
  String? phone;
  String? name;
  String? address;
  String? url;

  DocumentReference? reference;

  Clinic(this.name, this.phone, this.zipcd, this.address, this.url, {this.reference});

  factory Clinic.fromSnapshot(DocumentSnapshot snapshot) {
    Clinic newClinic = Clinic.fromJson(snapshot.data() as Map<String, dynamic>?);
    newClinic.reference = snapshot.reference;
    return newClinic;
  }

  factory Clinic.fromJson(Map<String, dynamic>? json) => _ClinicFromJson(json);

  Map<String, dynamic> toJson() => _ClinicToJson(this);

  @override
  String toString() => "Clinic<$name, $phone, $address>";
}

Clinic _ClinicFromJson(Map<String, dynamic>? json) {
  print(json.toString());
  return Clinic(
      json?['CLNC_NM'] as String,
      json?['PHONE'] as String,
      json?['ZIPCD'] as String,
      json?['ZIPCD_DTLC'] as String,
      json?['URL'] as String
  );
}

Map<String, dynamic> _ClinicToJson(Clinic instance) => <String, dynamic> {
  'name': instance.name,
  'zipcd': instance.zipcd,
  'phone': instance.phone,
};