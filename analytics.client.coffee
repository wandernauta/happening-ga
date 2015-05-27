# analytics.client.coffee
# Google Analytics Measurement Protocol for Happening.im

Dom = require 'dom'
Obs = require 'obs'
Plugin = require 'plugin'

serialize = (obj) ->
	uri = ""
	for k, v of obj
		uri += k + "=" + encodeURIComponent(v) + "&"
	uri += "z=" + ("" + Math.random()).substring(2)

exports.init = (tid, an) ->
	base = "https://ssl.google-analytics.com/collect?"

	ga = {}
	gal = Obs.create 0
	gaq = Obs.create {}

	Dom.div !->
		Dom.style {display: 'none'}

		gaq.iterate (item) !->
			Dom.img !->
				Dom.prop 'src', base + item.peek('url')
				Dom.prop 'alt', ''

	ga.cid = cid = Plugin.groupCode() + '-' + Plugin.userId()

	ga.track = (t, props) !->
		props.t = t      # Hit type
		props.v = 1      # Protocol Version
		props.tid = tid  # Tracking ID
		props.aip = 1    # Anonymize IP
		props.cid = cid  # Client ID
		props.an = an    # Application Name
		props.ds = 'app' # Data Source

		if not props.cd?
			props.cd = an

		gal.modify (v) -> v + 1
		gaq.set gal.peek(), {url: serialize(props), props: props}

	ga.pageview    = (props) -> ga.track('pageview', props)
	ga.screenview  = (props) -> ga.track('screenview', props)
	ga.event       = (props) -> ga.track('event', props)
	ga.transaction = (props) -> ga.track('transaction', props)
	ga.item        = (props) -> ga.track('item', props)
	ga.social      = (props) -> ga.track('social', props)
	ga.exception   = (props) -> ga.track('exception', props)
	ga.timing      = (props) -> ga.track('timing', props)

	return ga
