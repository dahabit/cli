# 1.1.5
Deprecated several commands, in favor of the `make`
command:
* `controller`
* `plugin`
* `service`
* `test`

The `rename` command will now replace *all* occurrences
of the old project names with the new one in `config/`
YAML files, and also operates on the glob `config/**/*.yaml`.

Changed the call to run `angel start` to run `dart bin/server.dart` instead, after an
`init` command.