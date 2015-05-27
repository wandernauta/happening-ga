Analytics = require 'analytics'
Dom = require 'dom'
Obs = require 'obs'
Ui = require 'ui'
Plugin = require 'plugin'
Page = require 'page'

exports.render = !->
	propertyID = "UA-11481162-22"
	ga = Analytics.init(propertyID, "Analytics Demo")

	clicks = Obs.create(0)

	Dom.section !->
		Dom.h2 "Event button"

		Ui.button "" + clicks.get(), !->
			clicks.modify (v) -> v + 1
			ga.event {ec: 'Interaction', ea: 'increment'}

	Dom.p !->
		Dom.small "Using property ID: " + propertyID
	
	Dom.p !->
		Dom.small "This app uses Google Analytics, an analytics service provided by Google, Inc. ('Google'). Information generated about your use of this app will be transmitted to and stored by Google's servers in the United States and elsewhere. Google’s ability to use and share information collected by Google Analytics about your usage of this app is restricted by the Google Analytics Terms of Use and the Google Privacy Policy."
