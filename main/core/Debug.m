BeginPackage["core`Debug`"];

Begin["`Private`"];

`defaultTypeList={"msg","val","core"};

End[];

defaultDebugLevel::usage = "defaultDebugLevel[]";
If[!ValueQ[`defaultDebugLevel],
  `defaultDebugLevel=0];

`Private`mergeAssociations[default_,current_]:=KeySort[Merge[{default, current}, Last]];
`Private`defaultAssociation=Association @@ (# -> `defaultDebugLevel & /@ `Private`defaultTypeList);

If[!ValueQ[Global`$verbose],
  Global`$verbose=`Private`defaultAssociation,
  Global`$verbose=`Private`mergeAssociations[`Private`defaultAssociation,Global`$verbose];
];


debug::usage = "debug[]";
SetAttributes[debug,HoldAll];
debug[msg__,level_List]:=If[
  NumberQ[Global`$verbose[level[[1]]]] &&
      Global`$verbose[level[[1]]]>=level[[2]],
  Global`debugf[msg]];

debugset::usage = "debugset[]";
SetAttributes[debugset,HoldAll];
debugset[vars__,level_List]:=
  Do[debug[StringTake[ToString[var],{6,-2}]<>" is "<>ToString[ReleaseHold[var]],level]
    ,{var,Map[Hold,Hold[{vars}],2][[1,1]]}];

debug["$verbose is set to ",Global`$verbose,{"core",5}];

Remove/@{level,msg, var, vars,current,default};

`Private`isLoaded=True;
EndPackage[];