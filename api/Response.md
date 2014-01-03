## Response

The `Response` object is the second argument passed into the routing callback, attempting to mimic functionality of [Express's Response](http://expressjs.com/api.html#response).

### res.status(value)

Sets the status code of the request to `value`.

```
  ghosttrain.get('/', function (req, res) {
    res.status(404);
    res.send();
  });

  ghosttrain.request('get', '/', function (err, res, body) {
    console.log(res.statusCode); // 404
  });
```

### res.send([body|status), [body])

Sends the response back to the requester. Based on [Express's res.send()](http://expressjs.com/api.html#res.send). Can pass in a `status` with a string or object as the `body`, or one or the other.

When `body` is a `String`, `Content-Type` defaults to `text/html`. When an `Array` or `Object`, `Content-Type` defaults to `application/json`.

When sending only a status code, the `body` is set to a default HTTP response, such as `OK` for 200, or `Not Found` for 404.

```
  ghosttrain.get('/users', function (req, res) {
    res.send(200, 'This has been a success!');
  });

  ghosttrain.request('get', '/users');
```

### res.json([body|status], [body])

Sends a JSON response. Shortcut for `res.send()` and explicitly casts to JSON.

```
  ghosttrain.get('/users', function (req, res) {
    res.json({ name: 'justin timberlake' });
  });

  ghosttrain.request('get', '/users', function (err, res, body) {
    console.log(res.headers['Content-Type']); // 'application/json'
    console.log(body.name); // 'justin timberlake'
    console.log(res.statusCode); // 200
  });
```

### res.set(field, [value])

Sets `field` header to `value`, or accepts an object and applies those key value pairs to the Response object's headers.

```
  ghosttrain.get('/', function (req, res) {
    res.set('Content-Type', 'application/json');
    res.set({ 'X-My-Header': 'high five' });
    console.log(res.headers['Content-Type']); // 'application/json'
    console.log(res.headers['X-My-Header']); // 'high five'
  });

  ghosttrain.request('get', '/');
```

### res.header(field, [value])

Alias for [res.set()](#res.set).

### res.get(field)

Returns header value for `field`.

### res.contentType(type)

Sets the header for `Content-Type` to `type`.

```
  ghosttrain.get('/', function (req, res) {
    res.contentType('text/html');
  });
```

### res.type(type)

Alias for [res.contentType()](#res.contentType)


### res.links(links)

TODO
