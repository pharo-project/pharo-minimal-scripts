baseline
baseline: spec 
    
	<baseline>
        
	| repository | 
	
	repository := 'filetree://./pharo-core/src'.    

	spec for: #common do: [
		spec postLoadDoIt: #'postload:package:'.

		spec baseline: 'UI' with: [spec repository: repository].

		spec package: 'HudsonBuildTools20'.
		
		spec baseline: 'SUnit' with: [
			spec repository: repository.
			spec loads: #('UI' 'Help')].

		spec package: 'Morphic-Widgets-FastTable'.
		
		spec package: 'Tool-ExternalBrowser'.
		spec package: 'BlueInk-Core'. 
		spec package: 'Tool-ProcessBrowser'.
		spec package: 'Tool-Profilers'.
		spec package: 'Tool-SystemReporter'.	"standalone"
		spec package: 'NECompletion'.
		spec package: 'Nautilus'.
		spec package: 'NautilusCommon'.
		spec package: 'Nautilus-GroupManager'.
		spec package: 'Nautilus-GroupManagerUI'.
		spec package: 'Komitter'.
		
		spec package: 'Metacello-FileTree'. "standalone"
		spec package: 'Metacello-GitBasedRepository'.
		spec package: 'Metacello-GitHub'.
		spec package: 'Metacello-ProfStef'. "standalone"
		spec package: 'Metacello-Reference'.
		spec package: 'Metacello-Tutorial'.	"standalone"
		spec package: 'MonticelloGUI'.
		spec package: 'Network-Mail'.
		spec package: 'ProfStef-Core'.
		spec package: 'ProfStef-Help'.
		spec package: 'RecentSubmissions'.
		spec package: 'Refactoring-Changes'.
		spec package: 'Refactoring-Core'.
		spec package: 'Refactoring-Environment'.
		spec package: 'UpdateStreamer-Core'.
		spec package: 'IssueTracking'.
		spec package: 'Monticello-OldDataStreamCompatibility'. "standalone"
		spec package: 'MonticelloFileServices'.	"standalone"		
		spec package: 'Spec-Examples'.
		spec package: 'Tool-Diff'.
		spec package: 'Tool-FileList'.
		spec package: 'Tool-Finder'.
		spec package: 'Tool-ImageCleaner'.	"standalone"		
		spec package: 'Tools'.
					
		spec package: 'Athens-Core'.
		spec package: 'Athens-CairoPools'.
		spec package: 'Athens-Cairo'.

	].