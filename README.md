### Crisco (Work in Progress)

A slick, opinionated application framework that makes using middleware
and handling permissioning a bit more palatable.

Built using express.js.

```javascript

var crisco = require('crisco');
crisco.configure({ /* Some configuration */});
crisco.listen(port);

```

Crisco allows you to organize application code in a way that stays
sane as the codebase and complexity grows.  It's a set of lightweight
abstractions over express.js that handle common tasks like authentication
and resource permissioning.


## Resource Controllers
```javascript
var utils = require('utils');
var CriscoBase = require('crisco').BaseResource();

function SomeResourceContoller() {}

utils.inherit(SomeResourceController, CriscoBase);

ResourceController.authenticate('all', {except: "someRoute"});
ResourceController.verifyPermissions('all');

//Add specific routes
ResourceController.app.get('/parents/:parent_id/children/:children_id',
    function(CriscoModels, Aux, default) {
      CriscoModels.populate.on('error', function(err){
        //Crisco has default error handlers, but go ahead
        //and override those.
        Aux.error("CriscoModels couldn't populate ", err.message);
      })
      CriscoModels.populate(function(models){
        //On success run this function

        //Crisco bakes in flexible server logging that
        //that integrate with production-ready loggers like
        //Winston
        Aux.log("I just populated the models");
      });
    }
);

//Or defer to the default RESTful model store.
ResourceController.app.get('/parents/:parent_id/children',
    function(CriscoModels, Aux, default) {
      default(function(){
        //optional post success callback
      });
    }
);

```

or much more elegantly in coffeescript

```coffeescript
BaseResource = require("crisco").BaseResource();

class SomeResource extends BaseResource
  
  @authenticate 'all', {except: "someRoute"}
  @verifyPermissions 'all'

  @app.get '/parents/:parent_id/children', (CriscoModels, Aux, default) ->
    default () ->
      #optional post success callback

```

## Action Controllers
```coffeescript
BaseAction = require("crisco").BaseAction();

class SomeAction extends BaseAction
  
  @authenticate 'all'

  @app.get '', (CriscoObject, Aux, default) ->
    default () =>
  
```

