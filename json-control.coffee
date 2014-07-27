fs = Npm.require('fs')
path = Npm.require('path')
stream = Npm.require('stream')

class JS

  get_seed: (path, _s_n) ->
    json = EJSON.parse(Assets.getText(path))
    n = 0
    while n < json.length
      json[n]._s_n = _s_n
      json[n]._usr = "root"
      json[n]._dt = new Date()
      DATA.insert(json[n])
      n++

  seed_json: () ->
    DATA.remove({})
    s_json = EJSON.parse(Assets.getText('essential-list-json/_s.json'))
    to_load = EJSON.parse(Assets.getText('web-str-json/_s_to_load.json'))
    n = 0
    while n < s_json.length
      if to_load[s_json[n]._s_n_for] and s_json[n]._s_n_for isnt "_s"
        load_obj = to_load[s_json[n]._s_n_for]
        k = 0
        while k < s_json[n].json.length
          if s_json[n].json[k]._n not in load_obj
            s_json[n].json.splice(k, 1)
          else
            @get_seed(s_json[n].json[k].path, s_json[n]._s_n_for)
          k++
        s_json[n]._usr = "root"
        s_json[n]._dt = new Date()
        DATA.insert(s_json[n])
      n++
    DATA.find(_s_n: "_s", _s_n_for: {$ne: "_s"}).forEach (s_doc) ->
      keys = DATA.find(key_n: {$in: s_doc._s_keys})
      DATA.find(_s_n: s_doc._s_n_for).forEach (doc) ->
        console.log doc




  key_check: (key, value, schema) ->
    if key
      switch key.key_ty
        when "_st"
          if typeof value is "string" and String(value) isnt ""
            return String(value)
        when "_num"
          if typeof value is "number" and Number(value) isnt NaN
            return Number(value)
        when "r_st"
          if key.key_s is schema
            return String(value)
          else
            obj = {}
            obj[key.key_key] = value
            obj._s_n = key.key_s
            if DATA.find(obj).count() is 1
              return String(value)
            else
              console.log "cannot find value
                #{value} for key
                #{key.key_n} for schema
                #{schema} in database"
              return String(value)
        when "r_gr_st"
          return value
        when "_bl"
          if typeof value is "boolean"
            return value
        when "currency"
          if Number(value) isnt NaN
            return Number(value)
        when "phone"
          phone = phone_format.format_number(value)
          if phone
            return phone
        when "email"
          if email_format.reg.test(value)
            return value
        when "geo_json"
          return value
        when "_dt"
          if value instanceof Date
            return value
    false

json_control.js = ->
  return new JS()
