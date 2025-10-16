// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_page_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodoPageEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoPageEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodoPageEvent()';
}


}

/// @nodoc
class $TodoPageEventCopyWith<$Res>  {
$TodoPageEventCopyWith(TodoPageEvent _, $Res Function(TodoPageEvent) __);
}


/// Adds pattern-matching-related methods to [TodoPageEvent].
extension TodoPageEventPatterns on TodoPageEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Adding value)?  adding,TResult Function( _Listing value)?  listing,TResult Function( _Add value)?  add,TResult Function( _Remove value)?  remove,TResult Function( _ToggleComplete value)?  toggleComplete,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Adding() when adding != null:
return adding(_that);case _Listing() when listing != null:
return listing(_that);case _Add() when add != null:
return add(_that);case _Remove() when remove != null:
return remove(_that);case _ToggleComplete() when toggleComplete != null:
return toggleComplete(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Adding value)  adding,required TResult Function( _Listing value)  listing,required TResult Function( _Add value)  add,required TResult Function( _Remove value)  remove,required TResult Function( _ToggleComplete value)  toggleComplete,}){
final _that = this;
switch (_that) {
case _Adding():
return adding(_that);case _Listing():
return listing(_that);case _Add():
return add(_that);case _Remove():
return remove(_that);case _ToggleComplete():
return toggleComplete(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Adding value)?  adding,TResult? Function( _Listing value)?  listing,TResult? Function( _Add value)?  add,TResult? Function( _Remove value)?  remove,TResult? Function( _ToggleComplete value)?  toggleComplete,}){
final _that = this;
switch (_that) {
case _Adding() when adding != null:
return adding(_that);case _Listing() when listing != null:
return listing(_that);case _Add() when add != null:
return add(_that);case _Remove() when remove != null:
return remove(_that);case _ToggleComplete() when toggleComplete != null:
return toggleComplete(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  adding,TResult Function()?  listing,TResult Function( TodoItem item)?  add,TResult Function( String id)?  remove,TResult Function( String id)?  toggleComplete,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Adding() when adding != null:
return adding();case _Listing() when listing != null:
return listing();case _Add() when add != null:
return add(_that.item);case _Remove() when remove != null:
return remove(_that.id);case _ToggleComplete() when toggleComplete != null:
return toggleComplete(_that.id);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  adding,required TResult Function()  listing,required TResult Function( TodoItem item)  add,required TResult Function( String id)  remove,required TResult Function( String id)  toggleComplete,}) {final _that = this;
switch (_that) {
case _Adding():
return adding();case _Listing():
return listing();case _Add():
return add(_that.item);case _Remove():
return remove(_that.id);case _ToggleComplete():
return toggleComplete(_that.id);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  adding,TResult? Function()?  listing,TResult? Function( TodoItem item)?  add,TResult? Function( String id)?  remove,TResult? Function( String id)?  toggleComplete,}) {final _that = this;
switch (_that) {
case _Adding() when adding != null:
return adding();case _Listing() when listing != null:
return listing();case _Add() when add != null:
return add(_that.item);case _Remove() when remove != null:
return remove(_that.id);case _ToggleComplete() when toggleComplete != null:
return toggleComplete(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class _Adding implements TodoPageEvent {
  const _Adding();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Adding);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodoPageEvent.adding()';
}


}




/// @nodoc


class _Listing implements TodoPageEvent {
  const _Listing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Listing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodoPageEvent.listing()';
}


}




/// @nodoc


class _Add implements TodoPageEvent {
  const _Add({required this.item});
  

 final  TodoItem item;

/// Create a copy of TodoPageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddCopyWith<_Add> get copyWith => __$AddCopyWithImpl<_Add>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Add&&(identical(other.item, item) || other.item == item));
}


@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'TodoPageEvent.add(item: $item)';
}


}

/// @nodoc
abstract mixin class _$AddCopyWith<$Res> implements $TodoPageEventCopyWith<$Res> {
  factory _$AddCopyWith(_Add value, $Res Function(_Add) _then) = __$AddCopyWithImpl;
@useResult
$Res call({
 TodoItem item
});


$TodoItemCopyWith<$Res> get item;

}
/// @nodoc
class __$AddCopyWithImpl<$Res>
    implements _$AddCopyWith<$Res> {
  __$AddCopyWithImpl(this._self, this._then);

  final _Add _self;
  final $Res Function(_Add) _then;

/// Create a copy of TodoPageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? item = null,}) {
  return _then(_Add(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as TodoItem,
  ));
}

/// Create a copy of TodoPageEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodoItemCopyWith<$Res> get item {
  
  return $TodoItemCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}

/// @nodoc


class _Remove implements TodoPageEvent {
  const _Remove({required this.id});
  

 final  String id;

/// Create a copy of TodoPageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveCopyWith<_Remove> get copyWith => __$RemoveCopyWithImpl<_Remove>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Remove&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'TodoPageEvent.remove(id: $id)';
}


}

/// @nodoc
abstract mixin class _$RemoveCopyWith<$Res> implements $TodoPageEventCopyWith<$Res> {
  factory _$RemoveCopyWith(_Remove value, $Res Function(_Remove) _then) = __$RemoveCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$RemoveCopyWithImpl<$Res>
    implements _$RemoveCopyWith<$Res> {
  __$RemoveCopyWithImpl(this._self, this._then);

  final _Remove _self;
  final $Res Function(_Remove) _then;

/// Create a copy of TodoPageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_Remove(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ToggleComplete implements TodoPageEvent {
  const _ToggleComplete({required this.id});
  

 final  String id;

/// Create a copy of TodoPageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleCompleteCopyWith<_ToggleComplete> get copyWith => __$ToggleCompleteCopyWithImpl<_ToggleComplete>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleComplete&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'TodoPageEvent.toggleComplete(id: $id)';
}


}

/// @nodoc
abstract mixin class _$ToggleCompleteCopyWith<$Res> implements $TodoPageEventCopyWith<$Res> {
  factory _$ToggleCompleteCopyWith(_ToggleComplete value, $Res Function(_ToggleComplete) _then) = __$ToggleCompleteCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$ToggleCompleteCopyWithImpl<$Res>
    implements _$ToggleCompleteCopyWith<$Res> {
  __$ToggleCompleteCopyWithImpl(this._self, this._then);

  final _ToggleComplete _self;
  final $Res Function(_ToggleComplete) _then;

/// Create a copy of TodoPageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_ToggleComplete(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$TodoPageState {

 TodoPageStatus get status; List<TodoItem> get items;
/// Create a copy of TodoPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoPageStateCopyWith<TodoPageState> get copyWith => _$TodoPageStateCopyWithImpl<TodoPageState>(this as TodoPageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoPageState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'TodoPageState(status: $status, items: $items)';
}


}

/// @nodoc
abstract mixin class $TodoPageStateCopyWith<$Res>  {
  factory $TodoPageStateCopyWith(TodoPageState value, $Res Function(TodoPageState) _then) = _$TodoPageStateCopyWithImpl;
@useResult
$Res call({
 TodoPageStatus status, List<TodoItem> items
});




}
/// @nodoc
class _$TodoPageStateCopyWithImpl<$Res>
    implements $TodoPageStateCopyWith<$Res> {
  _$TodoPageStateCopyWithImpl(this._self, this._then);

  final TodoPageState _self;
  final $Res Function(TodoPageState) _then;

/// Create a copy of TodoPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? items = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TodoPageStatus,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<TodoItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [TodoPageState].
extension TodoPageStatePatterns on TodoPageState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodoState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodoState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodoState value)  $default,){
final _that = this;
switch (_that) {
case _TodoState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodoState value)?  $default,){
final _that = this;
switch (_that) {
case _TodoState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TodoPageStatus status,  List<TodoItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodoState() when $default != null:
return $default(_that.status,_that.items);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TodoPageStatus status,  List<TodoItem> items)  $default,) {final _that = this;
switch (_that) {
case _TodoState():
return $default(_that.status,_that.items);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TodoPageStatus status,  List<TodoItem> items)?  $default,) {final _that = this;
switch (_that) {
case _TodoState() when $default != null:
return $default(_that.status,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _TodoState implements TodoPageState {
  const _TodoState({this.status = TodoPageStatus.listing, final  List<TodoItem> items = const []}): _items = items;
  

@override@JsonKey() final  TodoPageStatus status;
 final  List<TodoItem> _items;
@override@JsonKey() List<TodoItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of TodoPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoStateCopyWith<_TodoState> get copyWith => __$TodoStateCopyWithImpl<_TodoState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'TodoPageState(status: $status, items: $items)';
}


}

/// @nodoc
abstract mixin class _$TodoStateCopyWith<$Res> implements $TodoPageStateCopyWith<$Res> {
  factory _$TodoStateCopyWith(_TodoState value, $Res Function(_TodoState) _then) = __$TodoStateCopyWithImpl;
@override @useResult
$Res call({
 TodoPageStatus status, List<TodoItem> items
});




}
/// @nodoc
class __$TodoStateCopyWithImpl<$Res>
    implements _$TodoStateCopyWith<$Res> {
  __$TodoStateCopyWithImpl(this._self, this._then);

  final _TodoState _self;
  final $Res Function(_TodoState) _then;

/// Create a copy of TodoPageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? items = null,}) {
  return _then(_TodoState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TodoPageStatus,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TodoItem>,
  ));
}


}

// dart format on
