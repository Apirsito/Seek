// Mocks generated by Mockito 5.4.4 from annotations
// in seek/test/feature/task/data/datasource/task_local_datasource_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:seek/core/models/error_model.dart' as _i5;
import 'package:seek/features/task/data/datasources/task_database_helper.dart'
    as _i3;
import 'package:seek/features/task/data/models/task_model.dart' as _i7;
import 'package:sqflite/sqflite.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TaskDatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockTaskDatabaseHelper extends _i1.Mock
    implements _i3.TaskDatabaseHelper {
  MockTaskDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.ErrorModel, _i6.Database>> get database =>
      (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i4.Future<_i2.Either<_i5.ErrorModel, _i6.Database>>.value(
            _FakeEither_0<_i5.ErrorModel, _i6.Database>(
          this,
          Invocation.getter(#database),
        )),
      ) as _i4.Future<_i2.Either<_i5.ErrorModel, _i6.Database>>);

  @override
  _i4.Future<_i2.Either<_i5.ErrorModel, void>> insertTask(
          _i7.TaskModel? task) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertTask,
          [task],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.ErrorModel, void>>.value(
            _FakeEither_0<_i5.ErrorModel, void>(
          this,
          Invocation.method(
            #insertTask,
            [task],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.ErrorModel, void>>);

  @override
  _i4.Future<_i2.Either<_i5.ErrorModel, List<_i7.TaskModel>>> getAllTasks() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllTasks,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.ErrorModel, List<_i7.TaskModel>>>.value(
                _FakeEither_0<_i5.ErrorModel, List<_i7.TaskModel>>(
          this,
          Invocation.method(
            #getAllTasks,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.ErrorModel, List<_i7.TaskModel>>>);

  @override
  _i4.Future<_i2.Either<_i5.ErrorModel, void>> updateTask(
          _i7.TaskModel? task) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateTask,
          [task],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.ErrorModel, void>>.value(
            _FakeEither_0<_i5.ErrorModel, void>(
          this,
          Invocation.method(
            #updateTask,
            [task],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.ErrorModel, void>>);

  @override
  _i4.Future<_i2.Either<_i5.ErrorModel, void>> deleteTask(
          _i7.TaskModel? task) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteTask,
          [task],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.ErrorModel, void>>.value(
            _FakeEither_0<_i5.ErrorModel, void>(
          this,
          Invocation.method(
            #deleteTask,
            [task],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.ErrorModel, void>>);
}
