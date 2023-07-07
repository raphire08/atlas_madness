// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Attribute extends $Attribute
    with RealmEntity, RealmObjectBase, RealmObject {
  Attribute(
    ObjectId id,
    ObjectId sellerId,
    ObjectId productTemplateId,
    String name,
    int displayName,
    String dataType,
    ObjectId optionSetId,
    bool isParent,
    bool isChild,
    bool isSelected,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'sellerId', sellerId);
    RealmObjectBase.set(this, 'productTemplateId', productTemplateId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'displayName', displayName);
    RealmObjectBase.set(this, 'dataType', dataType);
    RealmObjectBase.set(this, 'optionSetId', optionSetId);
    RealmObjectBase.set(this, 'isParent', isParent);
    RealmObjectBase.set(this, 'isChild', isChild);
    RealmObjectBase.set(this, 'isSelected', isSelected);
  }

  Attribute._();

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
  ObjectId get productTemplateId =>
      RealmObjectBase.get<ObjectId>(this, 'productTemplateId') as ObjectId;
  @override
  set productTemplateId(ObjectId value) =>
      RealmObjectBase.set(this, 'productTemplateId', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get displayName => RealmObjectBase.get<int>(this, 'displayName') as int;
  @override
  set displayName(int value) => RealmObjectBase.set(this, 'displayName', value);

  @override
  String get dataType =>
      RealmObjectBase.get<String>(this, 'dataType') as String;
  @override
  set dataType(String value) => RealmObjectBase.set(this, 'dataType', value);

  @override
  ObjectId get optionSetId =>
      RealmObjectBase.get<ObjectId>(this, 'optionSetId') as ObjectId;
  @override
  set optionSetId(ObjectId value) =>
      RealmObjectBase.set(this, 'optionSetId', value);

  @override
  bool get isParent => RealmObjectBase.get<bool>(this, 'isParent') as bool;
  @override
  set isParent(bool value) => RealmObjectBase.set(this, 'isParent', value);

  @override
  bool get isChild => RealmObjectBase.get<bool>(this, 'isChild') as bool;
  @override
  set isChild(bool value) => RealmObjectBase.set(this, 'isChild', value);

  @override
  bool get isSelected => RealmObjectBase.get<bool>(this, 'isSelected') as bool;
  @override
  set isSelected(bool value) => RealmObjectBase.set(this, 'isSelected', value);

  @override
  Stream<RealmObjectChanges<Attribute>> get changes =>
      RealmObjectBase.getChanges<Attribute>(this);

  @override
  Attribute freeze() => RealmObjectBase.freezeObject<Attribute>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Attribute._);
    return const SchemaObject(ObjectType.realmObject, Attribute, 'Attribute', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('sellerId', RealmPropertyType.objectid),
      SchemaProperty('productTemplateId', RealmPropertyType.objectid),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('displayName', RealmPropertyType.int),
      SchemaProperty('dataType', RealmPropertyType.string),
      SchemaProperty('optionSetId', RealmPropertyType.objectid),
      SchemaProperty('isParent', RealmPropertyType.bool),
      SchemaProperty('isChild', RealmPropertyType.bool),
      SchemaProperty('isSelected', RealmPropertyType.bool),
    ]);
  }
}
