splitLines(S, L) :- split_string(S, "\n", "\n", L).

sorted([]).
sorted([_]).
sorted([H1, H2 | T]) :- H2 > H1, sorted([H2 | T]).

%leastInList(List, Least, NewList) :- 
leastInList([Least], Least, []) :- !.
leastInList([Least, LH | LT], Least, [LH | NLT]) :- Least =< LH, leastInList([Least | LT], Least, NLT).
leastInList([NLH, LH | LT], Least, [NLH | NLT]) :- leastInList([LH | LT], Least, NLT).

%sortList(List, SList) :- permutation(List, SList), sorted(SList).

sortList([], []).
sortList(List, [SH | ST]) :- leastInList(List, SH, LList), sortList(LList, ST).

selectList([], [], _).
%for part one
%selectList([LH | LT], SList, Num) :- LH > Num, !, selectList(LT, SList, Num).
%selectList([LH | LT], [LH | SList], Num) :- LH =< Num, selectList(LT, SList, Num).
%for part two
selectList([LH | _], LH, Num) :- LH > Num, !.
selectList([_ | LT], NL, Num) :- selectList(LT, NL, Num).

sumList([], 0).
sumList([H | T], Sum) :- sumList(T, SSum), Sum is H + SSum.

neededSpace(S, NS) :- SS is 70000000 - S, NS is 30000000 - SS.

addList([], [], []) :- !.
addList([], L, L) :- !.
addList(L, [], L) :- !.
addList([LH], L2, [LH | L2]) :- !.
addList([LH | LT], L2, LSum) :- addList(LT, [LH | L2], LSum).

endDir([], [], _).
endDir(["$ cd .." | LinesR], LinesR, 0) :- !.
endDir(["$ cd .." | LinesT], LinesR, Depth) :- !, DDepth is Depth - 1, endDir(LinesT, LinesR, DDepth).
endDir([Com | LinesT], LinesR, Depth) :- split_string(Com, " ", " ", ComList), nth0(1, ComList, "cd"), !, 
  DDepth is Depth + 1, endDir(LinesT, LinesR, DDepth).
endDir([_ | LinesT], LinesR, Depth) :- endDir(LinesT, LinesR, Depth).

endDir(Lines, LinesR) :- endDir(Lines, LinesR, 0).

%parseDir(Lines, Directories, Sum of Files & Dir)
parseDir([], [], 0) :- !.
parseDir(["$ cd .." | _], [], 0) :- !.
parseDir(["$ ls" | LT], [DirH | Dirs], Sum) :- !, endDir(LT, LR), parseDir(LT, DirR, DirH),
    parseDir(LR, DirT, SSum), addList(DirT, DirR, Dirs), Sum is SSum + DirH.
parseDir([Com | LT], Dirs, Sum) :- split_string(Com, " ", " ", ComList), 
    nth0(0, ComList, "$"), !, parseDir(LT, Dirs, Sum).
parseDir([Dir | LT], Dirs, Sum) :- split_string(Dir, " ", " ", DirList),
    nth0(0, DirList, "dir"), !, parseDir(LT, Dirs, Sum).
parseDir([File | LT], Dirs, Sum) :- 
    split_string(File, " ", " ", FileList), nth0(0, FileList, NumStr), number_string(Num, NumStr), 
    parseDir(LT, Dirs, SSum), Sum is Num + SSum.

run(Sum) :- splitLines(
"$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k",
                Lines), parseDir(Lines, [DD | Dirs], _), sortList([DD | Dirs], DirsSort), neededSpace(DD, NS),
    selectList(DirsSort, Sum, NS).
