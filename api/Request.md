## Request

The `Request` object is the first argument passed into a routes callback and used to get further information regarding how the mock request was sent.

### req.params

This property is an object containing the values for the parameters defined in a route. Based on [Express's req.params](http://expressjs.com/api.html#req.params) property.

```
  ghosttrain.get('/users/:id', function (req, res) {
    console.log(req.params.id); // 12345
  });

  ghosttrain.request('get', '/users/12345');
```

For routes that are regular expressions, `req.params` is an array containing each of the capture groups in order.

```
  ghosttrain.get(/\/users\/(.*)/, function (req, res) {
    console.log(req.params[0]); // 12345
  });

  ghosttrain.request('get', '/users/12345');
```

### req.query

This property is an object containing the parsed query-string. Based on [Express's req.query](http://expressjs.com/api.html#req.query) property.

```
  ghosttrain.get('/search', function (req, res) {
    console.log(req.query.q); // 'rainbows'
  });

  ghosttrain.request('get', '/search?q=rainbows');
```

### req.body

This property is an object containing the `body` property that was sent in a request. Based on [Express's req.body](http://expressjs.com/api.html#req.body) property.

```
  ghosttrain.post('/users/new', function (req, res) {
    console.log(req.body.name); // 'anders'
  });

  ghosttrain.request('post', '/users/new', {
    body: { name: 'anders' }
  });
```

### req.get(name)

Returns the header value for `name`. 

```
  ghosttrain.get('/', function (req, res) {
    console.log(req.get('Content-Type')); // 'application/json'
  });

  ghosttrain.request('get', '/', {
    'Content-Type': 'application/json'
  });
```

### req.header()

Alias for [req.get](#req-get).

### req.xhr

Returns a boolean indiciating whether or not the request has `'X-Requested-With'` header set to `'XMLHttpRequest'`.

### req.method

This property is the name of the HTTP method used to make the request.

```
  ghosttrain.get('/users', function (req, res) {
    console.log(req.method); // 'GET'
  });

  ghosttrain.request('get', '/users');
```

### req.url

This is the url used to make the request.

### req.path

This is the path used in the route.

### req.protocol

This is the protocol used in the request.

```
  ghosttrain.get('http://website.com/users', function (req, res) {
    console.log(req.protocol); // 'http'
  });

  ghosttrain.request('get', 'http://website.com/users');
```

### req.secure

Returns a boolean indicating whether or not `req.protocol === 'https'`.

### req.param()

A function that's a shorthand for checking a property from `req.params`, then `req.body`, and falling back to `req.query`.

```
  ghosttrain.get('/users/:id/show', function (req, res) {
    console.log(req.param('id')); // '12345'
    console.log(req.param('q')); // 'rainbows'
  });

  ghosttrain.request('get', '/users/12345/show?q=rainbows');
```

### req.is

Evaluates a string MIME type to determine if `Content-Type` matches.

```
  ghosttrain.get('/users', function (req, res) {
    console.log(req.is('html')); // true
    console.log(req.is('text/*')); // true
    console.log(req.is('text/html')); // true
  });

  ghosttrain.request('get', '/users', {
    headers: { 'Content-Type': 'text/html' }
  });
```

### res.range()

TODO
