// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Option extends $Option with RealmEntity, RealmObjectBase, EmbeddedObject {
  Option(
    ObjectId id,
    String name,
    int value,
    int sortOrder,
    bool active, {
    ObjectId? parentOptionId,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'value', value);
    RealmObjectBase.set(this, 'sortOrder', sortOrder);
    RealmObjectBase.set(this, 'active', active);
    RealmObjectBase.set(this, 'parentOptionId', parentOptionId);
  }

  Option._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get value => RealmObjectBase.get<int>(this, 'value') as int;
  @override
  set value(int value) => RealmObjectBase.set(this, 'value', value);

  @override
  int get sortOrder => RealmObjectBase.get<int>(this, 'sortOrder') as int;
  @override
  set sortOrder(int value) => RealmObjectBase.set(this, 'sortOrder', value);

  @override
  bool get active => RealmObjectBase.get<bool>(this, 'active') as bool;
  @override
  set active(bool value) => RealmObjectBase.set(this, 'active', value);

  @override
  ObjectId? get parentOptionId =>
      RealmObjectBase.get<ObjectId>(this, 'parentOptionId') as ObjectId?;
  @override
  set parentOptionId(ObjectId? value) =>
      RealmObjectBase.set(this, 'parentOptionId', value);

  @override
  Stream<RealmObjectChanges<Option>> get changes =>
      RealmObjectBase.getChanges<Option>(this);

  @override
  Option freeze() => RealmObjectBase.freezeObject<Option>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Option._);
    return const SchemaObject(ObjectType.embeddedObject, Option, 'Option', [
      SchemaProperty('id', RealmPropertyType.objectid),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('value', RealmPropertyType.int),
      SchemaProperty('sortOrder', RealmPropertyType.int),
      SchemaProperty('active', RealmPropertyType.bool),
      SchemaProperty('parentOptionId', RealmPropertyType.objectid,
          optional: true),
    ]);
  }
}
