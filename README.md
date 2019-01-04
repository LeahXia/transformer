# Leah's Transformer Project

By [Leah Xia](http://leahxia.com) ([leahxia5@gmail.com](mailto:leahxia5@gmail.com))

## Installation
1. Navigate to [repo](https://github.com/LeahXia/transformer) 
2. Clone locally using <br/>
HTTPS<br/>
`git clone https://github.com/LeahXia/transformer.git`<br/>
or SSH<br/>
`git clone git@github.com:LeahXia/transformer.git`<br/>
3.  Run `pod install` in Terminal
4. Open `Transformer.xcworkspace`
5. Press `cmd` + `R` to run the project
6. Enjoy!

## Assumptions
1. Assumed that Storyboard is the preferred way to create the UI.
2. Users can decide on the name of the transformer they create even if it's not an existing transformer
3. The name of the created Transformer should be alphanumeric and case sensitive
4. Users can create Transformers for both Autobots and Decepticons but won't see their overall rating on the listing page.
5. Users can create a maximum of 3 Transformers for each team at a time. Transformers that are destroyed in the war will be automatically deleted thus leaving room for the user to create new ones for that team.
6. For each creation, there's 60 `attribute points` that a user can use on the Transformer's tech spec. That said, if a user gives 10 points to the first 5 specs, there's only 10 points left to add to the last 3 specs.
7. A Transformer needs to be named exactly as "Optimus Prime" or "Predaking" to apply for the special rule. (Case sensitive and white space counts.)


## Languages and Frameworks
- Swift 4.2 with Xcode 10.1

## Libraries
- Alamofire
- SwiftKeychainWrapper
- KWStepper

## Planning
- Userflow: [userflow.jpg](./planning/userflow.jpg)

- Wireframes: [wireframes.jpg](./planning/wireframes.jpg)

## Requirements
1. [  ] A page to <strong>list</strong> all the current Transformers you have created. <br/>
&nbsp;&nbsp;&nbsp;&nbsp;Each list item must display the <strong>team icon</strong> associated with the Transformer with their <strong>relevant stats</strong> <br/>
&nbsp;&nbsp;&nbsp;&nbsp;and each list item must also be <strong>deletable</strong> and <strong>editable</strong>.
2. [  ] A page to <strong>create</strong> a new Transformer.
3. [  ] <strong>A button</strong> that wages a war between the Autobots and the Decepticons that you have
created and <strong>displays the results</strong> in any way you like. 
4. [  ] The application must <strong>maintain its state after a restart</strong>, for example, if you create a
Transformer and restart the app you should still see that same Transformer in the list and
not an empty list.
5. [  ] <strong>Unit tests</strong> covering important functionality.
6. [ x ] Short document explaining how to <strong>build and start the project</strong> and <strong>assumptions</strong> made about the
requirements.
7. [ x ] Application must target <strong>iOS 10 and above</strong>
8. [  ] Application should be a <strong>responsive universal</strong> application
9. [ x ] Application can be built in either Objective-C or Swift (preferred)<br/>
>Swift 4.2

## Bonuses
10. [  ] Documentation of classes
11. [  ] Automated UI tests
