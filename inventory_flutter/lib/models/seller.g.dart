// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Seller extends $Seller with RealmEntity, RealmObjectBase, RealmObject {
  Seller(
    ObjectId id,
    String name,
    String contact,
    String email, {
    Address? address,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'contact', contact);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'address', address);
  }

  Seller._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get contact => RealmObjectBase.get<String>(this, 'contact') as String;
  @override
  set contact(String value) => RealmObjectBase.set(this, 'contact', value);

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
  Stream<RealmObjectChanges<Seller>> get changes =>
      RealmObjectBase.getChanges<Seller>(this);

  @override
  Seller freeze() => RealmObjectBase.freezeObject<Seller>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Seller._);
    return const SchemaObject(ObjectType.realmObject, Seller, 'Seller', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('contact', RealmPropertyType.string),
      SchemaProperty('email', RealmPropertyType.string),
      SchemaProperty('address', RealmPropertyType.object,
          optional: true, linkTarget: 'Address'),
    ]);
  }
}
