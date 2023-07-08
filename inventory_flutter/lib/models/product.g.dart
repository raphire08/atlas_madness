// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Product extends $Product with RealmEntity, RealmObjectBase, RealmObject {
  Product(
    ObjectId id,
    ObjectId sellerId,
    String name,
    String type,
    String subType,
    String subSubType,
    String sku, {
    Iterable<ObjectId> templateIds = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'sellerId', sellerId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set(this, 'subType', subType);
    RealmObjectBase.set(this, 'subSubType', subSubType);
    RealmObjectBase.set(this, 'sku', sku);
    RealmObjectBase.set<RealmList<ObjectId>>(
        this, 'templateIds', RealmList<ObjectId>(templateIds));
  }

  Product._();

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
  String get type => RealmObjectBase.get<String>(this, 'type') as String;
  @override
  set type(String value) => RealmObjectBase.set(this, 'type', value);

  @override
  String get subType => RealmObjectBase.get<String>(this, 'subType') as String;
  @override
  set subType(String value) => RealmObjectBase.set(this, 'subType', value);

  @override
  String get subSubType =>
      RealmObjectBase.get<String>(this, 'subSubType') as String;
  @override
  set subSubType(String value) =>
      RealmObjectBase.set(this, 'subSubType', value);

  @override
  String get sku => RealmObjectBase.get<String>(this, 'sku') as String;
  @override
  set sku(String value) => RealmObjectBase.set(this, 'sku', value);

  @override
  RealmList<ObjectId> get templateIds =>
      RealmObjectBase.get<ObjectId>(this, 'templateIds') as RealmList<ObjectId>;
  @override
  set templateIds(covariant RealmList<ObjectId> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Product>> get changes =>
      RealmObjectBase.getChanges<Product>(this);

  @override
  Product freeze() => RealmObjectBase.freezeObject<Product>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Product._);
    return const SchemaObject(ObjectType.realmObject, Product, 'Product', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('sellerId', RealmPropertyType.objectid),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('type', RealmPropertyType.string),
      SchemaProperty('subType', RealmPropertyType.string),
      SchemaProperty('subSubType', RealmPropertyType.string),
      SchemaProperty('sku', RealmPropertyType.string),
      SchemaProperty('templateIds', RealmPropertyType.objectid,
          collectionType: RealmCollectionType.list),
    ]);
  }
}
