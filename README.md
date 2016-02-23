# cfmlBase62
Component to serialize / deserialize integers to and from base62

See [http://ryanguill.com/cfml/2016/02/22/base62-library.html](http://ryanguill.com/cfml/2016/02/22/base62-library.html).

Basic usage:

```
base62 = new Base62();
base62.fromBase10(123); //b9
base62.toBase10("b9"); //123
```

You can pass the integers in as strings as well, which you must do for large numbers on lucee in some cases - you should be fine if you are populating the data from a query.

You can use a custom alphabet - use `base62.getShuffledAlphabet()` to generate one.  You probably want to hard code it in your app's configuration because you never want it to change again.  Set it like this:

```
//just an example
base62.setAlphabet("b8cnqIw9WFPhp6jG5BN3KklfViZxHvomtLgsQEuUeX4Md027RSYJAyTDrzOaC1");
```

## tests

Download and provide a mapping to testbox in `/tests/Application.cfc` (or just stick testbox in the webroot), then run the webroot index.cfm  There is also a `docker-config.yml` file so you can also just clone the repo, download testbox and `docker-config up -d` and you should be good to go to run the tests on Lucee 4.5.

## support

I plan to support Lucee 4.5+ and Adobe Coldfusion 10+ with this library. Issues and Pull Requests welcome!
