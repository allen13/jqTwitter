class BootstrapTweetApi
  api: (options)->
    $.ajax
      url: "http://api.twitter.com/1/" + options.resource
      type: "GET"
      dataType: "jsonp"
      data: options.parameters
      success: (data, textStatus, xhr) ->
        options.results(data)

  search_tweets: (el,location) ->
    $.getJSON("http://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20twitter.search%20WHERE%20q%3D%27food%27%20AND%20geocode%3D%2724.560824%2C-81.762807%2C20mi%27&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=?", (data) ->
      $(el).append(JST["tweets"](tweets:data.query.results.results))
    )
  user_timeline: (el,user) ->
    @api
      resource: "statuses/user_timeline.json"
      parameters:
        screen_name: user,
        include_rts: true,
        count: 20,
        include_entities: true
      results: (tweets) ->
        $(el).append(JST["tweets"](tweets:tweets))

$ ->
  bootstrap = new BootstrapTweetApi
  bootstrap.user_timeline(".user-tweets","twbootstrap")
  bootstrap.search_tweets(".location-tweets","24.560824,-81.762807,20mi")

