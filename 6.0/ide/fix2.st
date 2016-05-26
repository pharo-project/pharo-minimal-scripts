
| vs versions full packagesWithHistory toFix | 

vs := MCWorkingCopy allManagers reject: [ :wc | wc ancestry ancestors isEmpty ].


versions := (vs collect: [ :wc | wc ancestry ancestors first name  ]) sorted..


full := 'versions.txt' asFileReference readStream contentsOfEntireFile lines.


packagesWithHistory := MCWorkingCopy allManagers reject: [ :wc | wc ancestry ancestors isEmpty ].
versions := (packagesWithHistory collect: [ :wc | wc ancestry ancestors first name  ]) sorted.
full := 'versions.txt' asFileReference readStream contentsOfEntireFile lines.

toFix := full copyWithoutAll: versions.
packageNames := toFix collect: [ :versionName | versionName copyUpToLast: $- ].

Transcript show: 'Packages with wrong versions:'; cr.
packageNames do: [ :pn | Transcript show: pn; cr. ].
Transcript cr.

[
[
toFix do: [ :versionName |
	Transcript show: 'Loading '; show: versionName; cr.
	Gofer it smalltalkhubUser:  'Pharo' project:  'Pharo60'; version: versionName;  load. ].

] on:  ProvideAnswerNotification do: [:e | 
  Transcript show: 'ProvideAnswerNotification '; show: e asString; cr.
  e resume:  ''].
] on:  MCMergeOrLoadWarning do: [:w | 
  Transcript show: 'MCMergeOrLoadWarning '; show: w asString; cr.
  w resume: true].