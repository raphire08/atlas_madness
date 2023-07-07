// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_value.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class AttributeValue extends $AttributeValue
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  AttributeValue(
    ObjectId attributeId, {
    RealmValue value = const RealmValue.nullValue(),
  }) {
    RealmObjectBase.set(this, 'attributeId', attributeId);
    RealmObjectBase.set(this, 'value', value);
  }

  AttributeValue._();

  @override
  ObjectId get attributeId =>
      RealmObjectBase.get<ObjectId>(this, 'attributeId') as ObjectId;
  @override
  set attributeId(ObjectId value) =>
      RealmObjectBase.set(this, 'attributeId', value);

  @override
  RealmValue get value =>
      RealmObjectBase.get<RealmValue>(this, 'value') as RealmValue;
  @override
  set value(RealmValue value) => RealmObjectBase.set(this, 'value', value);

  @override
  Stream<RealmObjectChanges<AttributeValue>> get changes =>
      RealmObjectBase.getChanges<AttributeValue>(this);

  @override
  AttributeValue freeze() => RealmObjectBase.freezeObject<AttributeValue>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(AttributeValue._);
    return const SchemaObject(
        ObjectType.embeddedObject, AttributeValue, 'AttributeValue', [
      SchemaProperty('attributeId', RealmPropertyType.objectid),
      SchemaProperty('value', RealmPropertyType.mixed, optional: true),
    ]);
  }
}
