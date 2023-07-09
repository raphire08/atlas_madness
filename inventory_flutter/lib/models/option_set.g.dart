// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_set.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class OptionSet extends $OptionSet
    with RealmEntity, RealmObjectBase, RealmObject {
  OptionSet(
    ObjectId id,
    ObjectId sellerId,
    String name,
    bool active, {
    ObjectId? parentSetId,
    Iterable<Option> options = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'sellerId', sellerId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'parentSetId', parentSetId);
    RealmObjectBase.set(this, 'active', active);
    RealmObjectBase.set<RealmList<Option>>(
        this, 'options', RealmList<Option>(options));
  }

  OptionSet._();

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
  ObjectId? get parentSetId =>
      RealmObjectBase.get<ObjectId>(this, 'parentSetId') as ObjectId?;
  @override
  set parentSetId(ObjectId? value) =>
      RealmObjectBase.set(this, 'parentSetId', value);

  @override
  bool get active => RealmObjectBase.get<bool>(this, 'active') as bool;
  @override
  set active(bool value) => RealmObjectBase.set(this, 'active', value);

  @override
  RealmList<Option> get options =>
      RealmObjectBase.get<Option>(this, 'options') as RealmList<Option>;
  @override
  set options(covariant RealmList<Option> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<OptionSet>> get changes =>
      RealmObjectBase.getChanges<OptionSet>(this);

  @override
  OptionSet freeze() => RealmObjectBase.freezeObject<OptionSet>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(OptionSet._);
    return const SchemaObject(ObjectType.realmObject, OptionSet, 'OptionSet', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('sellerId', RealmPropertyType.objectid),
      SchemaProperty('name', RealmPropertyType.string,
          indexType: RealmIndexType.fullText),
      SchemaProperty('parentSetId', RealmPropertyType.objectid, optional: true),
      SchemaProperty('active', RealmPropertyType.bool),
      SchemaProperty('options', RealmPropertyType.object,
          linkTarget: 'Option', collectionType: RealmCollectionType.list),
    ]);
  }
}
