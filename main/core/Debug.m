BeginPackage["core`Debug`"];

SetAttributes[Global`debugf,HoldAll];
If[!ValueQ[Global`debugf],
  If[$KernelID===0,
    Global`debugf=Print,
    Global`debugf[___]=Null];];

typeList::usage = "typeList[]";
If[!ValueQ[`typeList],
  `typeList={"msg","val"}];

If[!ValueQ[Global`$verbose],
  Global`$verbose=Association @@ (# -> 0 & /@ `typeList);];

debug::usage = "debug[]";
SetAttributes[debug,HoldAll];
debug[msg__,level_List]:=If[Global`$verbose[[1]]>=level[[2]],Global`debugf[msg]];

debugset::usage = "debugset[]";
SetAttributes[debugset,HoldAll];
debugset[vars__,level_List]:=
  Do[debug[StringTake[ToString[var],{6,-2}]<>" is "<>ReleaseHold[var],level]
    ,{var,Map[Hold,Hold[{vars}],2][[1,1]]}];

Remove/@{level,msg, var, vars};

EndPackage[];