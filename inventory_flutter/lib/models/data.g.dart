// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Data extends $Data with RealmEntity, RealmObjectBase, RealmObject {
  Data(
    ObjectId id,
    ObjectId sellerId,
    ObjectId productId,
    DateTime createdOn,
    DateTime modifiedOn, {
    Iterable<AttributeValue> values = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'sellerId', sellerId);
    RealmObjectBase.set(this, 'productId', productId);
    RealmObjectBase.set(this, 'createdOn', createdOn);
    RealmObjectBase.set(this, 'modifiedOn', modifiedOn);
    RealmObjectBase.set<RealmList<AttributeValue>>(
        this, 'values', RealmList<AttributeValue>(values));
  }

  Data._();

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
  ObjectId get productId =>
      RealmObjectBase.get<ObjectId>(this, 'productId') as ObjectId;
  @override
  set productId(ObjectId value) =>
      RealmObjectBase.set(this, 'productId', value);

  @override
  DateTime get createdOn =>
      RealmObjectBase.get<DateTime>(this, 'createdOn') as DateTime;
  @override
  set createdOn(DateTime value) =>
      RealmObjectBase.set(this, 'createdOn', value);

  @override
  DateTime get modifiedOn =>
      RealmObjectBase.get<DateTime>(this, 'modifiedOn') as DateTime;
  @override
  set modifiedOn(DateTime value) =>
      RealmObjectBase.set(this, 'modifiedOn', value);

  @override
  RealmList<AttributeValue> get values =>
      RealmObjectBase.get<AttributeValue>(this, 'values')
          as RealmList<AttributeValue>;
  @override
  set values(covariant RealmList<AttributeValue> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Data>> get changes =>
      RealmObjectBase.getChanges<Data>(this);

  @override
  Data freeze() => RealmObjectBase.freezeObject<Data>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Data._);
    return const SchemaObject(ObjectType.realmObject, Data, 'Data', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('sellerId', RealmPropertyType.objectid),
      SchemaProperty('productId', RealmPropertyType.objectid),
      SchemaProperty('createdOn', RealmPropertyType.timestamp),
      SchemaProperty('modifiedOn', RealmPropertyType.timestamp),
      SchemaProperty('values', RealmPropertyType.object,
          linkTarget: 'AttributeValue',
          collectionType: RealmCollectionType.list),
    ]);
  }
}
