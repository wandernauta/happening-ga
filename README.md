# happening-ga

`happening-ga` is a tiny, unofficial library for working with the [Google Analytics Measurement Protocol][gamp] from inside the [Happening][happ] plugin sandbox. To use it, copy `analytics.client.coffee` to your project folder and `require` it inside your `client.coffee`.

    Analytics = require 'analytics'
    # ...

    exports.render = !->
        ga = Analytics.init("UA-12345678-01", "Your Plugin Name")

        Dom.section !->
            Ui.button "Label", !->
                ga.event {cd: 'Main screen', ec: 'Interaction', ea: 'Button pressed'}

To send interaction data to Google Analytics, use the `track` method, supplying the required [parameters][params] as an object. The following aliases, which each just set `t` and call `track`, are available for convenience: `pageview`, `screenview`, `event`, `transaction`, `item`, `social`, `exception`, `timing`.

`happening-ga` is licensed under the MIT license. Note that all applications using the Measurement Protocol must adhere to the [Measurement Protocol Policy][policy].


[gamp]: https://developers.google.com/analytics/devguides/collection/protocol/v1/
[happ]: https://happening.im
[params]: https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters
[policy]: https://developers.google.com/analytics/devguides/collection/protocol/policy
