%%%-------------------------------------------------------------------
%%% @author 신원동 <wdshin@CTO-Wondong-Shin.local>
%%% @copyright (C) 2015, 신원동
%%% @doc
%%%
%%% @end
%%% Created :  6 Jan 2015 by 신원동 <wdshin@CTO-Wondong-Shin.local>
%%%-------------------------------------------------------------------
-module(erl_common).

-behaviour(application).

%% Application callbacks
-export([start/0,stop/0]).
-export([start/2, stop/1]).


start() ->
    start(dummy,dummy).

stop() ->
    stop(dummy).



%%%===================================================================
%%% Application callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function is called whenever an application is started using
%% application:start/[1,2], and should start the processes of the
%% application. If the application is structured according to the OTP
%% design principles as a supervision tree, this means starting the
%% top supervisor of the tree.
%%
%% @spec start(StartType, StartArgs) -> {ok, Pid} |
%%                                      {ok, Pid, State} |
%%                                      {error, Reason}
%%      StartType = normal | {takeover, Node} | {failover, Node}
%%      StartArgs = term()
%% @end
%%--------------------------------------------------------------------
start(_StartType, _StartArgs) ->
    case erl_common_sup:start_link() of
        {ok, Pid} ->
            {ok, Pid};
        Error ->
            Error
                end.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function is called whenever an application has stopped. It
%% is intended to be the opposite of Module:start/2 and should do
%% any necessary cleaning up. The return value is ignored.
%%
%% @spec stop(State) -> void()
%% @end
%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%%===================================================================
%%% Internal functions
%%%===================================================================
