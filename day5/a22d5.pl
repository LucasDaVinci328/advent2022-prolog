splitLines(S, L) :- split_string(S, "\n", "\n", L).

splitTower("", []).
splitTower(S, [32]) :-   string_to_list(S, [32, 32, 32]).
splitTower(S, [H]) :-   string_to_list(S, [91, H, 93]).
splitTower(S, [32 | T]) :-  string_to_list(S, [32, 32, 32, 32 | L]), string_to_list(SS, L), splitTower(SS, T).
splitTower(S, [H | T]) :-  string_to_list(S, [91, H, 93, 32 | L]), string_to_list(SS, L), splitTower(SS, T).

listTowers([], []).
listTowers([S], [L]) :- splitTower(S, L).
listTowers([S | Lines], [L | LinesP]) :- splitTower(S, L), listTowers(Lines, LinesP).

firstTower([], []).
firstTower([], [T]) :- nth0(0, T, 32), !.
firstTower([L], [T]) :- nth0(0, T, L), !.
firstTower(LT, [TH | TT]) :- nth0(0, TH, 32), !, firstTower(LT, TT).
firstTower([LH | LT], [TH | TT]) :- nth0(0, TH, LH), firstTower(LT, TT).

skipFirst([], []).
skipFirst([[_ | LH]], [LH]).
skipFirst([[_ | LH] | TT], [LH | LT]) :- skipFirst(TT, LT).

parseTowers([], []).
parseTowers([L], T) :- nth0(0, T, TT), length(TT, 1), !, firstTower(L, T).
parseTowers([LH | LT], T) :- firstTower(LH, T), skipFirst(T, TT), parseTowers(LT, TT).

parseMoves([], []).
parseMoves([LH | LT], [[MN, MF, MT] | T]) :- split_string(LH, " ", " ", [_, MNS, _, MFS, _, MTS]), number_string(MN, MNS), number_string(MF, MFS), number_string(MT, MTS), parseMoves(LT, T).

subList(_, 0, []) :- !.
subList([H | T], N, [H | L]) :- NN is N - 1, subList(T, NN, L).

cutList(L, 0, L) :- !.
cutList([_ | LT], N, L) :- NN is N - 1 , cutList(LT, NN, L).

message([], []).
message([H | T], [LH | LT]) :- nth0(0, H, HH), char_code(LH, HH), message(T, LT).

exeMove([], _, []).
exeMove([TH | TT], [N, Crates, 1, MT], [TEH | TET]) :- !, MMT is MT - 1, cutList(TH, N, TEH), exeMove(TT, [N, Crates, 0, MMT], TET).
exeMove([TH | TT], [N, Crates, MF, 1], [TEH | TET]) :- !, MMF is MF - 1, flatten([Crates, TH], TEH), exeMove(TT, [N, Crates, MMF, 0], TET).
exeMove([TH | TT], [N, Crates, MF, MT], [TH | TET]) :- MMF is MF - 1, MMT is MT - 1, exeMove(TT, [N, Crates, MMF, MMT], TET).

exeMoves(T, [], T).
exeMoves(Towers, [[MN, MF, MT] | Moves], TowersEnd) :- nth1(MF, Towers, F), subList(F, MN, Crates), exeMove(Towers, [MN, Crates, MF, MT], TowersNew), exeMoves(TowersNew, Moves, TowersEnd).
    
run(Message) :- splitLines(
"    [D]    
[N] [C]    
[Z] [M] [P]", L), 
listTowers(L, T), parseTowers(Towers, T), 
splitLines("move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2", MovesStr), parseMoves(MovesStr, Moves), exeMoves(Towers, Moves, End), message(End, MesList), string_to_list(Message, MesList).
