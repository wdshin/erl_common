ERL ?= erl
APP := erl_common
REPO ?= erl_common

.PHONY: deps

all: deps
	@./rebar compile

compile: 
	@./rebar compile
	
debug: deps
	@./rebar -D debug compile


deps:
	@./rebar get-deps

clean:
	@./rebar clean

test:
	@rm -rf .eunit
	@mkdir -p .eunit
	@$(REBAR) skip_deps=true eunit

distclean: clean
	@./rebar delete-deps


APPS = kernel stdlib sasl erts ssl tools os_mon runtime_tools crypto asn1 inets \
	xmerl webtool snmp public_key mnesia eunit syntax_tools compiler edoc

DEPS = deps/ibrowse/ebin deps/jsx/ebin deps/mimetypes/ebin 

COMBO_PLT = $(HOME)/.$(REPO)_combo_dialyzer_plt

check_plt: all
	dialyzer --check_plt --plt $(COMBO_PLT) --apps $(APPS) \
		$(DEPS) ebin

build_plt: all
	dialyzer --build_plt --output_plt $(COMBO_PLT) --apps $(APPS) \
		$(DEPS) ebin

dialyzer: compile
	@echo
	@echo Use "'make check_plt'" to check PLT prior to using this target.
	@echo Use "'make build_plt'" to build PLT prior to using this target.
	@echo
	@sleep 1
	dialyzer --plt $(COMBO_PLT) ebin
	# dialyzer -Wno_return --plt $(COMBO_PLT) $(DEPS) apps/fbbs_fs/ebin | \
	#     fgrep -v -f ./dialyzer.ignore-warnings

cleanplt:
	@echo
	@echo "Are you sure?  It takes about 1/2 hour to re-build."
	@echo Deleting $(COMBO_PLT) in 5 seconds.
	@echo
	sleep 5
	rm $(COMBO_PLT)

dialyzer_src:
	dialyzer --src src/*.erl > dialyzer_result.txt


docs:
	@erl -noshell -run edoc_run application '$(APP)' '"."' '[]'
