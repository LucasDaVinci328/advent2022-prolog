splitLines(S, L) :- split_string(S, "\n", "\n", L).

stringSub(NS1,  NS2, SSub) :- number_string(N1, NS1), number_string(N2, NS2), Sub is N1 - N2, number_string(Sub, SSub).
stringAdd(NS1, NS2, SSum) :- number_string(N1, NS1), number_string(N2, NS2), Sum is N1 + N2, number_string(Sum, SSum).

createMove(Dir, Num, Move) :- stringSub(Num, "1", NNum), string_concat(Dir, NNum,  Move).

parseMoves([], []).
parseMoves([S | T], TT) :- split_string(S, " ", " ", L), nth0(1, L, "0"), !, parseMoves(T, TT).
parseMoves([S | T], [[1, 0] | TT]) :- split_string(S, " ", " ", L), nth0(0, L, "R"), !, nth0(1, L, NumStr), createMove("R ", NumStr, Move), parseMoves([Move | T], TT).
parseMoves([S | T], [[-1, 0] | TT]) :- split_string(S, " ", " ", L), nth0(0, L, "L"), !, nth0(1, L, NumStr), createMove("L ", NumStr, Move), parseMoves([Move | T], TT).
parseMoves([S | T], [[0, 1] | TT]) :- split_string(S, " ", " ", L), nth0(0, L, "U"), !, nth0(1, L, NumStr), createMove("U ", NumStr, Move), parseMoves([Move | T], TT).
parseMoves([S | T], [[0, -1] | TT]) :- split_string(S, " ", " ", L), nth0(0, L, "D"), !, nth0(1, L, NumStr), createMove("D ", NumStr, Move), parseMoves([Move | T], TT).

pastToMoves([_], []).
pastToMoves([P1, P2 | PT], [MH | MT]) :- sub(P1, P2, MH), pastToMoves([P2 | PT], MT).

insertUnique(H, [], [H]) :- !.
insertUnique(H, [H | T], [H | T]) :- !.
insertUnique(H, [A | T], [A | TT]) :- insertUnique(H, T, TT).

addUnique([], A, A) :- !.
addUnique([H | T], L, NL) :- insertUnique(H, L, NNL), addUnique(T, NNL, NL).

sub([X, Y], [X1, Y1], [X2, Y2]) :- X2 is X - X1, Y2 is Y - Y1.
add([X, Y], [X1, Y1], [X2, Y2]) :- X2 is X1 + X, Y2 is Y1 + Y.

sign(0, 0) :- !.
sign(A, 1) :- A > 0, !.
sign(A, -1) :- A < 0, !.

signs([X, Y], [SX, SY]) :- sign(X, SX), sign(Y, SY).

tailMove(Head, Tail, [0, 0]) :- 
    sub(Head, Tail, TailDiff), signs(TailDiff, TailDiffSigns),
    sub(TailDiff, TailDiffSigns, [0, 0]), !.
tailMove(Head, Tail, TailDiffSigns) :- 
    sub(Head, Tail, TailDiff), signs(TailDiff, TailDiffSigns).

exeMove([0, 0], H, T, H, T, []) :- !.
exeMove(Move, Head, Tail, NHead, NTail) :- add(Move, Head, NHead), 
    tailMove(NHead, Tail, TailMove), add(Tail, TailMove, NTail).

exeMoves([], _, T, [T]) :- !.
exeMoves([Move | T], Head, Tail, [Tail | PT]) :- exeMove(Move, Head, Tail, NHead, NTail), exeMoves(T, NHead, NTail, PT).

run_part_one(Len) :-
    splitLines(
"R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2", MovesStr), parseMoves(MovesStr, Moves), 
    exeMoves(Moves, [0, 0], [0, 0], Past),
    addUnique(Past, [], PastUniq), length(PastUniq, Len).

%not generalized lol but could technically be edited to be made general
run_part_two(Len) :-
    splitLines(
"R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20", MovesStr), parseMoves(MovesStr, Moves), 
    exeMoves(Moves, [0, 0], [0, 0], Past1), pastToMoves(Past1, Moves1),
    exeMoves(Moves1, [0, 0], [0, 0], Past2), pastToMoves(Past2, Moves2),
    exeMoves(Moves2, [0, 0], [0, 0], Past3), pastToMoves(Past3, Moves3),
    exeMoves(Moves3, [0, 0], [0, 0], Past4), pastToMoves(Past4, Moves4),
    exeMoves(Moves4, [0, 0], [0, 0], Past5), pastToMoves(Past5, Moves5),
    exeMoves(Moves5, [0, 0], [0, 0], Past6), pastToMoves(Past6, Moves6),
    exeMoves(Moves6, [0, 0], [0, 0], Past7), pastToMoves(Past7, Moves7),
    exeMoves(Moves7, [0, 0], [0, 0], Past8), pastToMoves(Past8, Moves8),
    exeMoves(Moves8, [0, 0], [0, 0], Past),
    addUnique(Past, [], PastUniq), length(PastUniq, Len).
