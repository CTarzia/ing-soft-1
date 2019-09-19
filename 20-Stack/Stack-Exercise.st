!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test'!
8:20'! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'stack prefixFinder stackCopy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'gc 9/17/2019 18:46:41'!
setUp

	prefixFinder _ SentenceFinderByPrefix new.

	stack _ OOStack new.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.
	stack push: 'winter is here'.
	stack push: 'The winds of Winter'.
	
	stackCopy _ OOStack new.
	stackCopy push: 'winter is coming'.
	stackCopy push: 'winning is everything'.
	stackCopy push: 'The winds of Winter'.
	stackCopy push: 'Winter is here'.
	stackCopy push: 'winter is here'.
	stackCopy push: 'The winds of Winter'.	
	! !


!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'cg 9/19/2019 14:54:54'!
test01EmptyStackReturnsEmptyBag
	| emptyStack aBag|
	emptyStack _ OOStack new.
	
	aBag _ Bag new.
	
	self assert: (prefixFinder find: 'prefix' from: emptyStack) = aBag .! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'gc 9/17/2019 18:55:15'!
test02StackReturnsEmptyCollection
	| aBag |
	
	aBag _ Bag new.
	
	self assert: (prefixFinder find: 'prefix' from: stack) = aBag .
	
	self assert: (stack size = stackCopy size).
	[stack size > 0] whileTrue: [
		self assert: (stack pop = stackCopy pop).
	].! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'cg 9/19/2019 14:55:18'!
test03StackReturnsBagWithOneElement
	| aBag |
	
	aBag _ Bag new.
	aBag add: 'Winter is here'.
	
	self assert: (prefixFinder find: 'Wint' from: stack) = aBag .
	
	self assert: (stack size = stackCopy size).
	[stack size > 0] whileTrue: [
		self assert: (stack pop = stackCopy pop).
	].! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'gc 9/17/2019 18:55:21'!
test04CheckForCaseSensitive
	| aBag |
	
	aBag _ Bag new.
	aBag add: 'winter is here'.
	aBag add: 'winter is coming'.
	aBag add: 'winning is everything'.
	
	self assert: (prefixFinder find: 'win' from: stack) = aBag .
	
	self assert: (stack size = stackCopy size).
	[stack size > 0] whileTrue: [
		self assert: (stack pop = stackCopy pop).
	].! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'cg 9/19/2019 16:42:46'!
test05ReturnRepetedSentences
	| aBag |
	
	aBag _ Bag new.
	aBag add: 'The winds of Winter'.
	aBag add: 'The winds of Winter'.
	
	self assert: (prefixFinder find: 'The' from: stack) = aBag .
	self assert: aBag size = 2.
	
	self assert: (stack size = stackCopy size).
	[stack size > 0] whileTrue: [
		self assert: (stack pop = stackCopy pop).
	].! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'gc 9/17/2019 19:04:29'!
test06InvertEmptyStackToEmptyStack

	| aStack aStackToRevert |

	aStack _ OOStack new.
	aStackToRevert _ OOStack new.
	
	prefixFinder invert: aStackToRevert to: aStack .
	
	self assert: (aStack size = 0)! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'gc 9/17/2019 19:07:52'!
test07InvertStackToEmptyStack

	| aStack aStackToRevert |

	aStack _ OOStack new.
	aStackToRevert _ OOStack new.
	
	aStackToRevert push: 1.
	aStackToRevert push: 2.
	aStackToRevert push: 3.	
	
	prefixFinder invert: aStackToRevert to: aStack .
	
	self assert: (aStackToRevert size = 0).
	self assert: (aStack size = 3).
	self assert: (aStack pop = 1).
	self assert: (aStack pop = 2).
	self assert: (aStack pop = 3).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'cg 9/19/2019 15:01:47'!
test08EmptyPrefixReturnsError

	self
		should: [ prefixFinder find: '' from: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription ]! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'collection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'gc 9/17/2019 17:39:27'!
initialize
	collection _  OrderedCollection new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'gc 9/17/2019 17:39:36'!
isEmpty
	^collection size = 0 ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'gc 9/17/2019 17:41:57'!
pop
	| theTop |
	theTop  _ self top.
	collection remove: theTop .
	^theTop 
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'gc 9/17/2019 17:41:27'!
push: anObject
	^collection addLast: anObject ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'gc 9/17/2019 17:41:41'!
size
	^collection size! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'gc 9/17/2019 17:46:30'!
top
	^TopHandler handleTop: collection! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'cg 9/19/2019 16:42:24'!
find: prefix from: stack
	| auxStack sentences sentence size|
	
	(prefix size = 0) ifTrue: [^self error: self class prefixEmptyErrorDescription ].
	sentences _ Bag new.
	auxStack _ OOStack new.
	size _ prefix size .
	[stack size > 0] whileTrue: [
		sentence _ stack pop.
		(sentence copyFrom: 1 to: size) = prefix  ifTrue: [sentences add: sentence].
		auxStack push: sentence 
	].
	
	self invert: auxStack to: stack.
	
	^sentences.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'gc 9/17/2019 18:58:27'!
invert: aStack to: returnStack
	[aStack size > 0] whileTrue: [
		returnStack push: (aStack pop).
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'cg 9/19/2019 14:56:19'!
prefixEmptyErrorDescription
	
	^ 'Prefix is empty'! !


!classDefinition: #TopHandler category: #'Stack-Exercise'!
Object subclass: #TopHandler
	instanceVariableNames: 'collection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TopHandler class' category: #'Stack-Exercise'!
TopHandler class
	instanceVariableNames: ''!


!TopHandler class methodsFor: 'as yet unclassified' stamp: 'gc 9/17/2019 17:46:30'!
handleTop: aCollection

	^(TopHandler allSubclasses detect:[:aClass | aClass canHandle: aCollection ]) removeLastFrom: aCollection ! !


!classDefinition: #CollectionWithElements category: #'Stack-Exercise'!
TopHandler subclass: #CollectionWithElements
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CollectionWithElements class' category: #'Stack-Exercise'!
CollectionWithElements class
	instanceVariableNames: ''!

!CollectionWithElements class methodsFor: 'as yet unclassified' stamp: 'gc 9/17/2019 17:38:34'!
canHandle: aCollection
	^aCollection size > 0! !

!CollectionWithElements class methodsFor: 'as yet unclassified' stamp: 'gc 9/17/2019 17:34:36'!
removeLastFrom: aCollection
	^aCollection last! !


!classDefinition: #EmptyCollection category: #'Stack-Exercise'!
TopHandler subclass: #EmptyCollection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyCollection class' category: #'Stack-Exercise'!
EmptyCollection class
	instanceVariableNames: ''!

!EmptyCollection class methodsFor: 'as yet unclassified' stamp: 'gc 9/17/2019 17:38:21'!
canHandle: aCollection
	^aCollection size = 0 ! !

!EmptyCollection class methodsFor: 'as yet unclassified' stamp: 'gc 9/17/2019 17:35:43'!
removeLastFrom: aCollection
	^self error: OOStack stackEmptyErrorDescription ! !
