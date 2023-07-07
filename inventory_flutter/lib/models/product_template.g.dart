// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_template.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class ProductTemplate extends $ProductTemplate
    with RealmEntity, RealmObjectBase, RealmObject {
  ProductTemplate(
    ObjectId id,
    ObjectId sellerId,
    String name,
    String displayName,
    String description,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'sellerId', sellerId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'displayName', displayName);
    RealmObjectBase.set(this, 'description', description);
  }

  ProductTemplate._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  ObjectId get sellerId =>
      RealmObjectBase.get<ObjectId>(this, 'sellerId') as ObjectId;
  @override
  set sellerId(ObjectId value) => RealmObjectBase.set(this, 'sellerId', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get displayName =>
      RealmObjectBase.get<String>(this, 'displayName') as String;
  @override
  set displayName(String value) =>
      RealmObjectBase.set(this, 'displayName', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  Stream<RealmObjectChanges<ProductTemplate>> get changes =>
      RealmObjectBase.getChanges<ProductTemplate>(this);

  @override
  ProductTemplate freeze() =>
      RealmObjectBase.freezeObject<ProductTemplate>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ProductTemplate._);
    return const SchemaObject(
        ObjectType.realmObject, ProductTemplate, 'ProductTemplate', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('sellerId', RealmPropertyType.objectid),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('displayName', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
    ]);
  }
}
