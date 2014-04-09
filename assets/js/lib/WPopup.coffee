$   = jQuery

class @WPopup
  config = {
    timeout : 1500
    opacity : 0.85
  }

  html  : (data,height=200,width=600) ->
    $.colorbox({html:data, innerWidth:width,innerHeight:height,transition:'none',opacity : 0.52})

  iframe : (url,height=200,width=600) ->
    $.colorbox({iframe:true,href:url, innerWidth:width,innerHeight:height,transition:'none'})

  notice : (message,type="notic",height=200,width=600) =>
    msg = $('<div></div>').addClass('text-center').addClass(type).html(message)
    WPopup::html(msg,height,width)

  close  : ->
    $.colorbox.close()

  auto_close : (time=config.timeout) ->
    setTimeout(->
      WPopup::close();
    ,time)