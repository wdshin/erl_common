#!/bin/sh
cd `dirname $0`
exec erl -pa $PWD/ebin $PWD/deps/*/ebin -name erl_common@127.0.0.1 -setcookie riak -boot start_sasl -s erl_common -cf $PWD/priv/mac_local.conf $PWD/priv/mac_local_other_nodes.conf
