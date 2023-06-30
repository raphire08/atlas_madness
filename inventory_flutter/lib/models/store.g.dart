// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Store extends $Store with RealmEntity, RealmObjectBase, RealmObject {
  Store(
    ObjectId id,
    String name,
    String contact,
    String email,
    ObjectId sellerId, {
    Address? address,
    StoreProperties? properties,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'address', address);
    RealmObjectBase.set(this, 'contact', contact);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'properties', properties);
    RealmObjectBase.set(this, 'sellerId', sellerId);
  }

  Store._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Address? get address =>
      RealmObjectBase.get<Address>(this, 'address') as Address?;
  @override
  set address(covariant Address? value) =>
      RealmObjectBase.set(this, 'address', value);

  @override
  String get contact => RealmObjectBase.get<String>(this, 'contact') as String;
  @override
  set contact(String value) => RealmObjectBase.set(this, 'contact', value);

  @override
  String get email => RealmObjectBase.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObjectBase.set(this, 'email', value);

  @override
  StoreProperties? get properties =>
      RealmObjectBase.get<StoreProperties>(this, 'properties')
          as StoreProperties?;
  @override
  set properties(covariant StoreProperties? value) =>
      RealmObjectBase.set(this, 'properties', value);

  @override
  ObjectId get sellerId =>
      RealmObjectBase.get<ObjectId>(this, 'sellerId') as ObjectId;
  @override
  set sellerId(ObjectId value) => RealmObjectBase.set(this, 'sellerId', value);

  @override
  Stream<RealmObjectChanges<Store>> get changes =>
      RealmObjectBase.getChanges<Store>(this);

  @override
  Store freeze() => RealmObjectBase.freezeObject<Store>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Store._);
    return const SchemaObject(ObjectType.realmObject, Store, 'Store', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('address', RealmPropertyType.object,
          optional: true, linkTarget: 'Address'),
      SchemaProperty('contact', RealmPropertyType.string),
      SchemaProperty('email', RealmPropertyType.string),
      SchemaProperty('properties', RealmPropertyType.object,
          optional: true, linkTarget: 'StoreProperties'),
      SchemaProperty('sellerId', RealmPropertyType.objectid,
          indexType: RealmIndexType.regular),
    ]);
  }
}

class StoreProperties extends $StoreProperties
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  static var _defaultsSet = false;

  StoreProperties({
    bool isPOS = true,
    bool isOnline = false,
    bool hasStorage = true,
    bool hasStaff = true,
    bool hasGst = true,
    String? gst,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<StoreProperties>({
        'isPOS': true,
        'isOnline': false,
        'hasStorage': true,
        'hasStaff': true,
        'hasGst': true,
      });
    }
    RealmObjectBase.set(this, 'isPOS', isPOS);
    RealmObjectBase.set(this, 'isOnline', isOnline);
    RealmObjectBase.set(this, 'hasStorage', hasStorage);
    RealmObjectBase.set(this, 'hasStaff', hasStaff);
    RealmObjectBase.set(this, 'hasGst', hasGst);
    RealmObjectBase.set(this, 'gst', gst);
  }

  StoreProperties._();

  @override
  bool get isPOS => RealmObjectBase.get<bool>(this, 'isPOS') as bool;
  @override
  set isPOS(bool value) => RealmObjectBase.set(this, 'isPOS', value);

  @override
  bool get isOnline => RealmObjectBase.get<bool>(this, 'isOnline') as bool;
  @override
  set isOnline(bool value) => RealmObjectBase.set(this, 'isOnline', value);

  @override
  bool get hasStorage => RealmObjectBase.get<bool>(this, 'hasStorage') as bool;
  @override
  set hasStorage(bool value) => RealmObjectBase.set(this, 'hasStorage', value);

  @override
  bool get hasStaff => RealmObjectBase.get<bool>(this, 'hasStaff') as bool;
  @override
  set hasStaff(bool value) => RealmObjectBase.set(this, 'hasStaff', value);

  @override
  bool get hasGst => RealmObjectBase.get<bool>(this, 'hasGst') as bool;
  @override
  set hasGst(bool value) => RealmObjectBase.set(this, 'hasGst', value);

  @override
  String? get gst => RealmObjectBase.get<String>(this, 'gst') as String?;
  @override
  set gst(String? value) => RealmObjectBase.set(this, 'gst', value);

  @override
  Stream<RealmObjectChanges<StoreProperties>> get changes =>
      RealmObjectBase.getChanges<StoreProperties>(this);

  @override
  StoreProperties freeze() =>
      RealmObjectBase.freezeObject<StoreProperties>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(StoreProperties._);
    return const SchemaObject(
        ObjectType.embeddedObject, StoreProperties, 'StoreProperties', [
      SchemaProperty('isPOS', RealmPropertyType.bool),
      SchemaProperty('isOnline', RealmPropertyType.bool),
      SchemaProperty('hasStorage', RealmPropertyType.bool),
      SchemaProperty('hasStaff', RealmPropertyType.bool),
      SchemaProperty('hasGst', RealmPropertyType.bool),
      SchemaProperty('gst', RealmPropertyType.string, optional: true),
    ]);
  }
}
