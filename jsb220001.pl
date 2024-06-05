%1
secondMin(List,Min2):-numset(List),unique(List),minimum1(List,Min),minumum2(List,Min,Min2).
numset([]).
numset([X|List]):-number(X),!,numset(List),!.
numset([X|_]):-write("ERROR: "),write(X),writeln(" is not a number."),false,!.
unique([_]):-writeln("ERROR: List has fewer than two unique elements."),false,!.
unique([X|List]):-list2(X,List).
list2(X,[X]):-writeln("ERROR: List has fewer than two unique elements."),false,!.
list2(X,[X|List]):-list2(X,List),!.
list2(X,[Y|_]):-not(X=Y),!.
minimum1([X],X).
minimum1([X|List],X):-minimum1(List,Y),X<Y,!.
minimum1([X|List],Y):-minimum1(List,Y),not(X<Y),!.
minumum2([X],Min,X):-X>Min,!.
minumum2([X|List],Min,Y):-X=Min,!,minumum2(List,Min,Y),!.
minumum2([X|List],Min,Y):-minumum2(List,Min,Y),X>Y,Y>Min,!.
minumum2([X|List],Min,X):-minumum2(List,Min,Y),not(X>Y),!.

%2
fillList(_,X,[],[X]).
fillList(Op, X, [Y|Y2],Result) :- (call(Op,X,Y)-> Result = [X, Y|Y2];  
fillList(Op, X, Y2, Z),Result = [Y|Z]).
classify([], [], []).
classify([X|X2], Even, Odd) :- classify(X2, Even0, Odd0),( 0 is X mod 2 -> 
fillList(>, X, Even0, Even), Odd = Odd0; 
fillList(<, X, Odd0, Odd), Even = Even0).

%3
subslice([],_):- !.
subslice(SubList,[A|B]):- prefix(SubList,[A|B]),!;subslice(SubList,B).

%4
rlist([],L2,L2).
rlist([X|Y],L2,R):-
rlist(Y,[X|L2],R).
rlist(L,R):-
rlist(L,[],R).
lList([],0).
lList([_|Y],R):-
lList(Y,R2),
R is R2+1.
sList([],L2,L2).
sList([X2|Y2],L2,[X2|Y3]):-
sList(Y2,L2,Y3).
sublist(L,0,L).
sublist([_|Y],N,X):-
N3 is N-1,
sublist(Y,N3,X),!.
shiftleft(List,N,Shifted):-
lList(List,L),
rlist(List,First),
sublist(First,L-N,FirstR),
sublist(List,N,Second),
rlist(Second,SecondR),
sList(FirstR,SecondR,R2),
rlist(R2,Shifted).
shiftright(List,N,Shifted):-
lList(List,L),
rlist(List,First),
sublist(First,N,FirstR),
sublist(List,L-N,Second),
rlist(Second,SecondR),
sList(FirstR,SecondR,R2),
rlist(R2,Shifted).
shift(List,N,Shifted):-
N < 0-> N2 is (-1 * N),shiftright(List,N2,Shifted);
shiftleft(List,N,Shifted).

%5
sum2(Num,Result):-
N1 is mod(Num,10),
N2 is div(Num,10),
Result is N1+N2,!.
sum(Num,Result):-
N1 is mod(Num,10),
N2 is div(Num,10),
N3 is N2*2,
N3>9 -> sum2(N3,X),Result is X+N1,!;
N1 is mod(Num,10),
N2 is div(Num,10),
N3 is N2*2,
Result is N1+N3,!.
dSum(0,Sum,Result):-
Result is Sum,!.
dSum(N,Sum,Result):-
X is mod(N,100),
Y is div(N,100),
sum(X,S2),
Sum3 is Sum+S2,
dSum(Y,Sum3,Result),!.
luhn(Num):-
dSum(Num,0,Result),
X is mod(Result,10),
X = 0.

%6
edge(a,b).
edge(b,c).
edge(c,d).
edge(d,a).
edge(d,e).
edge(b,a).
path(X, Y):-
edge(X,Y), !.
path(X, Y):-
edge(X, R),
path(R, Y), !.
cycle(X):-
path(X, X), !.

%7-1
entaglement(mrBoddy,msGreen).
entaglement(mrBoddy,missScarlett).
affair(M,F) :- entaglement(M,F).
affair(F,M) :- entaglement(M,F).
husband_wife(profPlum, msGreen).
married(M,F) :- husband_wife(M,F).
married(F,M) :- husband_wife(M,F).
rich(mrBoddy).
greedy(colMustard).
hate(X,Y) :- married(X,Spouse), affair(Y,Spouse).
greed(X,Y) :- greedy(X), not(rich(X)), rich(Y).
suspect(X,Y):- hate(X,Y).
suspect(X,Y):- greed(X,Y).

%7-2
entaglement(mrBoddy,missScarlett).
affair(M,F) :- entaglement(M,F).
affair(F,M) :- entaglement(M,F).
husband_wife(mrBoddy, msGreen).
married(M,F) :- husband_wife(M,F).
married(F,M) :- husband_wife(M,F).
rich(mrBoddy).
greedy(msGreen).
hate(X,Y) :- married(X,Spouse), affair(Y,Spouse).
greed(X,Y) :- greedy(X), not(rich(X)), rich(Y).
suspect(X,Y):- hate(X,Y).
suspect(X,Y):- greed(X,Y).

%8
nationality(American).
nationality(Canadian).
nationality(Dutch).
nationality(French).
nationality(Scottish).

scolor(black).
scolor(blue).
scolor(green).
scolor(red).
scolor(white).

genres(drumAndBass).
genres(dubstep).
genres(EDM).
genres(house).
genres(trance).

stage(Arcadia).
stage(Asgard).
stage(Shangri-la).
stage(Valhalla).
stage(Xibalba).

ages(25).
ages(30).
ages(35).
ages(40).
ages(45).

hobby(camping). 
hobby(juggling).
hobby(painting).
hobby(singing).
hobby(surfing).

next_to(X,Y,List) :- is_right(X,Y,List).
next_to(X,Y,List) :- is_right(Y,X,List).

is_right(L,R,[L|[R|_]]).

rightOf(R, L, List(L, R, _, _, _)).
rightOf(R, L, List(_, L, R, _, _)).
rightOf(R, L, List(_, _, L, R, _)).
rightOf(R, L, List(_, _, _, L, R)).

middle(X, List(_, _, X, _, _)).

solve(DJSet) :-
DJSet = [
    dj(_, _, _, _, _, _),
    dj(_, _, _, _, _, _),
    dj(_, _, _, _, _, _),
    dj(_, _, _, _, _, _),
    dj(_, _, _, _, _, _)
],

is_right(dj(Scottish, _, _, _, _, _), dj(_, white, _, _, _, _), DJSet),		% The Scott is somewhere to the left of the DJ wearing the White shirt.

nth0(3, DJSet, dj(_, _, _, Arcadia, _, _)),		% At the fourth position is the DJ who is going to play on the Arcadia stage.

nth0(0, DJSet, dj(_, _, _, _, 30, _)),		% The 30-year-old DJ is at the first position.

rightOf(dj(_, _, EDM, _, _, _), dj(Canadian, _, _, _, _, _), DJSet),		% The DJ that plays EDM is exactly to the right of the Canadian.

next_to(dj(_, _, _, _, _, painting), dj(_, _, dubstep, _, _, _), DJSet),		% The one who likes Painting is next to the DJ who plays Dubstep.

is_right(dj(Scottish, _, _, _, _, _), dj(_, black, _, _, _, _), DJSet),is_right(dj(_, black, _, _, _, _), dj(_, _, dubstep, _, _, _), DJSet),		% The DJ wearing the Black shirt is somewhere between the Scott and the Dubstep player, in that order.

next_to(dj(French, _, _, _, _, _), dj(_, blue, _, _, _, _), DJSet),	% The French DJ is next to the one wearing the Blue shirt.

% At one of the ends is the DJ that likes Camping.

nth1(_, DJSet, dj(_, blue, _, Asgard, _, _)), 	% The DJ who is going to play on the Asgard stage is wearing the Blue shirt.

is_right(dj(_, green, _, _, _, _), dj(_, _, _, _, _, painting), DJSet),is_right(dj(_, _, _, _, _, painting), dj(_, blue, _, _, _, _), DJSet),	% The one that likes Painting is somewhere between the DJ wearing Green and the DJ wearing Blue, in that order.

nth0(4, DJSet, dj(_, _, drumAndBass, _, _, _)),		% At the fifth position is the DJ who plays Drum and bass.

middle(dj(_, _, Asgard, _, _),DJSet)	% In the middle is the DJ who is going to play on the Asgard stage.

% The one who plays Trance is next to the one who plays Dubstep.

% The Canadian is exactly to the left of the DJ who likes Juggling

% The DJ whose hobby is Singing is exactly to the right of the DJ wearing the Black shirt.

% The DJ in his Mid-thirties is next to the DJ who is into Juggling.

% The 40-year-old DJ is at the fourth position.

% The 40-year-old DJ is somewhere between the Dutch and the youngest DJ, in that order.

% The DJ wearing Blue is somewhere to the left of the DJ who is going to play on the Xibalba stage.

% The one who enjoys Surfing is going to play on the Valhalla stage.

% The DJ wearing the Red shirt is somewhere to the right of the French.







      