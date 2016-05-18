//= require jquery

var LazyRender = {
  load                 : function (context) {
    var lazy_renders = [];
    var lazy_render_elms = [];
    $('[class^=js-lazy-render]', context).each(function () {
      var param = {
        name     : $(this).data('lazy-render-name'),
        locals   : $(this).data('lazy-render-params'),
        cache    : $(this).data('lazy-render-cache'),
        version  : $(this).data('lazy-render-version'),
        callback : $(this).data('lazy-render-callback'),
        parallel : $(this).data('lazy-render-parallel')
      };
      if (param['cache']) {
        var cache = LazyRender.cache_read(param['name'] + $(this).attr('data-lazy-render-lazy_renders'), param['version']);
        if (cache) {
          LazyRender.apply(this, param, cache);
          return;
        }
      }
      if (param['parallel']) {
        LazyRender.request([param], [this]);
      } else {
        lazy_render_elms[lazy_render_elms.length] = this;
        lazy_renders.push(param);
      }
    });
    if (lazy_renders.length > 0) LazyRender.request(lazy_renders, lazy_render_elms);
  },
  request: function(params, positions) {
    $.ajax({
      type       : 'post',
      url        : '/lazy_render/load',
      data       : {
        lazy_renders : params,
        referrer     : document.referrer ? document.referrer : ''
      },
      beforeSend : function (jqXHR, settings) {
        jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      },
      cache      : false,
      dataType   : 'json',
      success    : function (result) {
        $(params).each(function (i, lazy_render) {
          LazyRender.apply(positions[i], lazy_render, result[i]);
          if (lazy_render['cache']) {
            LazyRender.cache_write(result[i], lazy_render['name'] + $(positions[i]).attr('data-lazy-render-lazy_renders'), lazy_render['version'], lazy_render['cache']);
          }
        });
      }
    });
  },
  apply                : function (elm, data, html) {
    if ($(elm).data('lazy-render-replace') == 'inner') {
      $(elm).html(html);
    } else {
      $(elm).replaceWith(html);
    }
    if (data['callback']) {
      eval(data['callback'] + '(data, elm);');
    }
  },
  cache_storage_prefix : 'lazy_render_cache_',
  cache_storage_key    : function (key) {
    return location.protocol + this.cache_storage_prefix + key;
  },
  cache_read           : function (key, version) {
    if (typeof sessionStorage == 'undefined' || typeof JSON == 'undefined') return false;
    if (location.search.match('cacheclear=1')) return false;
    try {
      var cache = JSON.parse(sessionStorage[this.cache_storage_key(key)]);
      if (!cache) return false;
      var now = new Date / 1e3 | 0;
      return cache['expire'] > now && cache['version'] == version ? cache['data'] : false;
    }catch (e) {
      return false;
    }
  },
  cache_write          : function (data, key, version, lifetimesec) {
    if (typeof sessionStorage == 'undefined' || typeof JSON == 'undefined') return false;
    sessionStorage[this.cache_storage_key(key)] = JSON.stringify({
      data    : data,
      version : version,
      expire  : (new Date / 1e3 | 0) + lifetimesec
    });
    return true;
  }
};


$(function () {
  if ($('[class^=js-lazy-render]').length > 0) {
    LazyRender.load(document);
  }
});
