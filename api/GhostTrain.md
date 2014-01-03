## GhostTrain

### new GhostTrain()

Instantiates a new GhostTrain instance.

### ghosttrain.request(method, path, [options], callback)

Makes a request to the GhostTrain instance's router. Takes an HTTP `method` string, string `path`, optional `options` object, and a `callback` that will be called with an `err`, `res` and `body` upon response from the router.

Options:

* `delay`- Number of ms to wait before executing routing (default: `1`)
* `body`- Object representing POST body data (default: `{}`)
* `headers`- Object of pairings of header values (default: `{}`)
* `contentType`- Sets headers for `Content-Type`

```
 ghosttrain.request('GET', '/users/:id', function (err, res, body) {
    console.log(res.statusCode);
    console.log(body);
 });
```

### ghosttrain.VERB(route, callback)

Declares a URL `route` with associated handler `callback`, where **VERB** is an HTTP verb (like `get` or `post`). Based on [Express's app.VERB](http://expressjs.com/api.html#app.VERB). The route handler receives a [Request](#request) and a [Response](#response) object.

```
  ghosttrain.get('/users/:id', function (req, res) {
    console.log(req.params.id); // 10
    res.send('OK');
  });

  ghosttrain.request('get', '/users/10', function (err, res, body) {
    console.log(res.statusCode); // 200
    console.log(body); // 'OK'
  });
```

### ghosttrain.set(name, value)

Sets a setting for the GhostTrain instance. Based on [Express's app.set](http://expressjs.com/api.html#app.set).

Options:

* `case sensitive routing`
* `strict routing`
* `json replacer`
* `json spaces`

```
  ghosttrain.set('strict routing', true);
```

### ghosttrain.get(name)

Returns a setting for the GhostTrain instance. Based on [Express's app.get](http://expressjs.com/api.html#app.get).

```
  ghosttrain.get('strict routing'); // false
```

### ghosttrain.enable(name)

Sets a setting for the GhostTrain instance to `true`. Based on [Express's app.enable](http://expressjs.com/api.html#app.enable)

```
  ghosttrain.enable('case sensitive routing');
  ghosttrain.get('case sensitive routing'); // true
```

### ghosttrain.disable(name)

Sets a setting for the GhostTrain instance to `false`. Based on [Express's app.disable](http://expressjs.com/api.html#app.disable)

```
  ghosttrain.disable('case sensitive routing');
  ghosttrain.get('case sensitive routing'); // false
```
