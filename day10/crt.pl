splitLines(S, L) :- split_string(S, "\n", "\n", L).

splitWords(S, L) :- split_string(S, " ", " ", L).

sumList([], 0) :- !.
sumList([H | T], Sum) :- sumList(T, SSum), Sum is SSum + H.

partList(_, 1, []) :- !.
partList([H | T], N, [H | L]) :- NN is N - 1, partList(T, NN, L).

parseLines([], []).
parseLines(["noop" | T], [0 | TT]) :- !, parseLines(T, TT).
parseLines([S | T], [0, Num | TT]) :- splitWords(S, L), nth0(1, L, NumStr), number_string(Num, NumStr), parseLines(T, TT).

parseCommands(S, Coms) :- splitLines(S, L), parseLines(L, Coms).

inOneRange(Position, Signal) :- Signal =:= Position + 1.
inOneRange(Position, Signal) :- Signal =:= Position.
inOneRange(Position, Signal) :- Signal =:= Position - 1.

signalStrength(Coms, N, Signal) :- partList(Coms, N, Com), sumList([1 | Com], Sum), Signal is Sum * N.

signalPos(Coms, N, Sum) :- partList(Coms, N, Com), sumList([1 | Com], Sum).

%drawScreen(Coms, Cycle, Screen)
drawScreen(_, 241, [10]) :- !.
drawScreen(Coms, Cycle, [35, 10 | Screen]) :- 39 =:= (Cycle - 1) mod 40, 
    signalPos(Coms, Cycle, Signal), inOneRange(39, Signal), !, 
    CC is Cycle + 1, drawScreen(Coms, CC, Screen).
drawScreen(Coms, Cycle, [48, 10 | Screen]) :- 39 =:= (Cycle - 1) mod 40, !, 
    CC is Cycle + 1, drawScreen(Coms, CC, Screen).
drawScreen(Coms, Cycle, [35 | Screen]) :- Pos is (Cycle - 1) mod 40, 
    signalPos(Coms, Cycle, Signal), inOneRange(Pos, Signal), !, 
    CC is Cycle + 1, drawScreen(Coms, CC, Screen).
drawScreen(Coms, Cycle, [48 | Screen]) :-
    CC is Cycle + 1, drawScreen(Coms, CC, Screen).

run(N) :- run_part_one(N);
    run_part_two(N).

run_part_one([Sum]) :- 
    parseCommands(
"noop
noop
noop
addx 4
addx 3
addx 3
addx 3
noop
addx 2
addx 1
addx -7
addx 10
addx 1
addx 5
addx -3
addx -7
addx 13
addx 5
addx 2
addx 1
addx -30
addx -8
noop
addx 3
addx 2
addx 7
noop
addx -2
addx 5
addx 2
addx -7
addx 8
addx 2
addx 5
addx 2
addx -12
noop
addx 17
addx 3
addx -2
addx 2
noop
addx 3
addx -38
noop
addx 3
addx 4
noop
addx 5
noop
noop
noop
addx 1
addx 2
addx 5
addx 2
addx -3
addx 4
addx 2
noop
noop
addx 7
addx -30
addx 31
addx 4
noop
addx -24
addx -12
addx 1
addx 5
addx 5
noop
noop
noop
addx -12
addx 13
addx 4
noop
addx 23
addx -19
addx 1
addx 5
addx 12
addx -28
addx 19
noop
addx 3
addx 2
addx 5
addx -40
addx 4
addx 32
addx -31
noop
addx 13
addx -8
addx 5
addx 2
addx 5
noop
noop
noop
addx 2
addx -7
addx 8
addx -7
addx 14
addx 3
addx -2
addx 2
addx 5
addx -40
noop
noop
addx 3
addx 4
addx 1
noop
addx 2
addx 5
addx 2
addx 21
noop
addx -16
addx 3
noop
addx 2
noop
addx 1
noop
noop
addx 4
addx 5
noop
noop
noop
noop
noop
noop
noop", Coms), 
    signalStrength(Coms, 20, Tot20), signalStrength(Coms, 60, Tot60),
    signalStrength(Coms, 100, Tot100), signalStrength(Coms, 140, Tot140),
    signalStrength(Coms, 180, Tot180), signalStrength(Coms, 220, Tot220),
    Sum is Tot20 + Tot60 + Tot100 + Tot140 + Tot180 + Tot220.

run_part_two([Screen]) :- 
    parseCommands(
"noop
noop
noop
addx 4
addx 3
addx 3
addx 3
noop
addx 2
addx 1
addx -7
addx 10
addx 1
addx 5
addx -3
addx -7
addx 13
addx 5
addx 2
addx 1
addx -30
addx -8
noop
addx 3
addx 2
addx 7
noop
addx -2
addx 5
addx 2
addx -7
addx 8
addx 2
addx 5
addx 2
addx -12
noop
addx 17
addx 3
addx -2
addx 2
noop
addx 3
addx -38
noop
addx 3
addx 4
noop
addx 5
noop
noop
noop
addx 1
addx 2
addx 5
addx 2
addx -3
addx 4
addx 2
noop
noop
addx 7
addx -30
addx 31
addx 4
noop
addx -24
addx -12
addx 1
addx 5
addx 5
noop
noop
noop
addx -12
addx 13
addx 4
noop
addx 23
addx -19
addx 1
addx 5
addx 12
addx -28
addx 19
noop
addx 3
addx 2
addx 5
addx -40
addx 4
addx 32
addx -31
noop
addx 13
addx -8
addx 5
addx 2
addx 5
noop
noop
noop
addx 2
addx -7
addx 8
addx -7
addx 14
addx 3
addx -2
addx 2
addx 5
addx -40
noop
noop
addx 3
addx 4
addx 1
noop
addx 2
addx 5
addx 2
addx 21
noop
addx -16
addx 3
noop
addx 2
noop
addx 1
noop
noop
addx 4
addx 5
noop
noop
noop
noop
noop
noop
noop", Coms), drawScreen(Coms, 1, ScreenList), string_to_list(ScreenDr, ScreenList),
    splitLines(ScreenDr, Screen).
             
             
