// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Staff extends $Staff with RealmEntity, RealmObjectBase, RealmObject {
  Staff(
    ObjectId id,
    String firstName,
    String lastName,
    String gender,
    String dob,
    String email,
    ObjectId sellerId, {
    String? primaryContact,
    String? secondaryContact,
    Address? address,
    ObjectId? storeId,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'firstName', firstName);
    RealmObjectBase.set(this, 'lastName', lastName);
    RealmObjectBase.set(this, 'gender', gender);
    RealmObjectBase.set(this, 'dob', dob);
    RealmObjectBase.set(this, 'primaryContact', primaryContact);
    RealmObjectBase.set(this, 'secondaryContact', secondaryContact);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'address', address);
    RealmObjectBase.set(this, 'sellerId', sellerId);
    RealmObjectBase.set(this, 'storeId', storeId);
  }

  Staff._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get firstName =>
      RealmObjectBase.get<String>(this, 'firstName') as String;
  @override
  set firstName(String value) => RealmObjectBase.set(this, 'firstName', value);

  @override
  String get lastName =>
      RealmObjectBase.get<String>(this, 'lastName') as String;
  @override
  set lastName(String value) => RealmObjectBase.set(this, 'lastName', value);

  @override
  String get gender => RealmObjectBase.get<String>(this, 'gender') as String;
  @override
  set gender(String value) => RealmObjectBase.set(this, 'gender', value);

  @override
  String get dob => RealmObjectBase.get<String>(this, 'dob') as String;
  @override
  set dob(String value) => RealmObjectBase.set(this, 'dob', value);

  @override
  String? get primaryContact =>
      RealmObjectBase.get<String>(this, 'primaryContact') as String?;
  @override
  set primaryContact(String? value) =>
      RealmObjectBase.set(this, 'primaryContact', value);

  @override
  String? get secondaryContact =>
      RealmObjectBase.get<String>(this, 'secondaryContact') as String?;
  @override
  set secondaryContact(String? value) =>
      RealmObjectBase.set(this, 'secondaryContact', value);

  @override
  String get email => RealmObjectBase.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObjectBase.set(this, 'email', value);

  @override
  Address? get address =>
      RealmObjectBase.get<Address>(this, 'address') as Address?;
  @override
  set address(covariant Address? value) =>
      RealmObjectBase.set(this, 'address', value);

  @override
  ObjectId get sellerId =>
      RealmObjectBase.get<ObjectId>(this, 'sellerId') as ObjectId;
  @override
  set sellerId(ObjectId value) => RealmObjectBase.set(this, 'sellerId', value);

  @override
  ObjectId? get storeId =>
      RealmObjectBase.get<ObjectId>(this, 'storeId') as ObjectId?;
  @override
  set storeId(ObjectId? value) => RealmObjectBase.set(this, 'storeId', value);

  @override
  Stream<RealmObjectChanges<Staff>> get changes =>
      RealmObjectBase.getChanges<Staff>(this);

  @override
  Staff freeze() => RealmObjectBase.freezeObject<Staff>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Staff._);
    return const SchemaObject(ObjectType.realmObject, Staff, 'Staff', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('firstName', RealmPropertyType.string),
      SchemaProperty('lastName', RealmPropertyType.string),
      SchemaProperty('gender', RealmPropertyType.string),
      SchemaProperty('dob', RealmPropertyType.string),
      SchemaProperty('primaryContact', RealmPropertyType.string,
          optional: true),
      SchemaProperty('secondaryContact', RealmPropertyType.string,
          optional: true),
      SchemaProperty('email', RealmPropertyType.string),
      SchemaProperty('address', RealmPropertyType.object,
          optional: true, linkTarget: 'Address'),
      SchemaProperty('sellerId', RealmPropertyType.objectid,
          indexType: RealmIndexType.regular),
      SchemaProperty('storeId', RealmPropertyType.objectid,
          optional: true, indexType: RealmIndexType.regular),
    ]);
  }
}
