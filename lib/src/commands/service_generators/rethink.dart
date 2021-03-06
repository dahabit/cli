import 'generator.dart';
import 'package:code_builder/code_builder.dart';
import 'package:inflection/inflection.dart';
import '../make/maker.dart';

class RethinkServiceGenerator extends ServiceGenerator {
  const RethinkServiceGenerator() : super('RethinkDB');

  @override
  List<MakerDependency> get dependencies =>
      const [const MakerDependency('angel_rethink', '^1.0.0')];

  @override
  bool get createsModel => false;

  @override
  void applyToConfigureServer(
      MethodBuilder configureServer, String name, String lower) {
    configureServer
      ..addPositional(parameter('connection', [new TypeBuilder('Connection')]))
      ..addPositional(parameter('r', [new TypeBuilder('Rethinkdb')]));
  }

  @override
  void applyToLibrary(LibraryBuilder library, String name, String lower) {
    library.addMembers([
      'package:angel_rethink/angel_rethink.dart',
      'package:rethinkdb_driver2/rethinkdb_driver2.dart'
    ].map((str) => new ImportBuilder(str)));
  }

  @override
  ExpressionBuilder createInstance(
      MethodBuilder methodBuilder, String name, String lower) {
    return new TypeBuilder('RethinkService').newInstance([
      reference('connection'),
      reference('r').invoke('table', [literal(pluralize(lower))])
    ]);
  }
}
