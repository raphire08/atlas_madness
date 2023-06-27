// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Address extends $Address
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  Address(
    String city,
    int pincode,
    String district,
    String state,
    String country, {
    String? streetAddress1,
    String? streetAddress2,
  }) {
    RealmObjectBase.set(this, 'streetAddress1', streetAddress1);
    RealmObjectBase.set(this, 'streetAddress2', streetAddress2);
    RealmObjectBase.set(this, 'city', city);
    RealmObjectBase.set(this, 'pincode', pincode);
    RealmObjectBase.set(this, 'district', district);
    RealmObjectBase.set(this, 'state', state);
    RealmObjectBase.set(this, 'country', country);
  }

  Address._();

  @override
  String? get streetAddress1 =>
      RealmObjectBase.get<String>(this, 'streetAddress1') as String?;
  @override
  set streetAddress1(String? value) =>
      RealmObjectBase.set(this, 'streetAddress1', value);

  @override
  String? get streetAddress2 =>
      RealmObjectBase.get<String>(this, 'streetAddress2') as String?;
  @override
  set streetAddress2(String? value) =>
      RealmObjectBase.set(this, 'streetAddress2', value);

  @override
  String get city => RealmObjectBase.get<String>(this, 'city') as String;
  @override
  set city(String value) => RealmObjectBase.set(this, 'city', value);

  @override
  int get pincode => RealmObjectBase.get<int>(this, 'pincode') as int;
  @override
  set pincode(int value) => RealmObjectBase.set(this, 'pincode', value);

  @override
  String get district =>
      RealmObjectBase.get<String>(this, 'district') as String;
  @override
  set district(String value) => RealmObjectBase.set(this, 'district', value);

  @override
  String get state => RealmObjectBase.get<String>(this, 'state') as String;
  @override
  set state(String value) => RealmObjectBase.set(this, 'state', value);

  @override
  String get country => RealmObjectBase.get<String>(this, 'country') as String;
  @override
  set country(String value) => RealmObjectBase.set(this, 'country', value);

  @override
  Stream<RealmObjectChanges<Address>> get changes =>
      RealmObjectBase.getChanges<Address>(this);

  @override
  Address freeze() => RealmObjectBase.freezeObject<Address>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Address._);
    return const SchemaObject(ObjectType.embeddedObject, Address, 'Address', [
      SchemaProperty('streetAddress1', RealmPropertyType.string,
          optional: true),
      SchemaProperty('streetAddress2', RealmPropertyType.string,
          optional: true),
      SchemaProperty('city', RealmPropertyType.string),
      SchemaProperty('pincode', RealmPropertyType.int),
      SchemaProperty('district', RealmPropertyType.string),
      SchemaProperty('state', RealmPropertyType.string),
      SchemaProperty('country', RealmPropertyType.string),
    ]);
  }
}
