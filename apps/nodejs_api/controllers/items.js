
var model = undefined;

exports.context = function(server, path, itemsModel) {
    if (!server)
        done('has to provide a restify server object');
        
    var context = "/items";
    if (path)
        context = path + context;
        
    server.get(context + '/', this.list);
    server.get(context + '/:id', this.read);
    server.post(context + '/', this.save);
    server.del(context + '/:id', this.destroy);
    
    model = itemsModel;
};

exports.list = function(req, res, next) {
    model.listAll(function(err, items) {
        if (err) {
            next(err);
        }
        else {
            if (items) {
                //XXX no pagination yet
                var page = { 
                  "currentPage" : 1,
                  "list" : items,
                  "pageSize" : 10,
                  "sortDirections" : "asc",
                  "sortFields" : "id",
                  "totalResults" : items.length
                };
                res.json(page);
                next();
            }
            else {
                next(new Error("Can't retrieve items"));
            }
        }
    })
};

exports.read = function(req, res, next) {
    var key = req.params.id;
    model.read(key, function(err, item) {
        if (err) {
            next(err);
        }
        else {
            if (item) {
                res.json(item);
                next();
            }
            else {
                next(new Error("Can't retrieve items"));
            }
        }
    })
};


exports.save = function(req, res, next) {
    if (req.params.id) {
        model.update(req.params.id, req.params.description, req.params.done, function(err, item) {
            if (err) {
                next(err);
            }
            else {
                res.json(item);
                next();
            }
        });
    }
    else {
        model.create(req.params.description, req.params.done, function(err, item) {
            if (err) {
                next(err);
            }
            else {
                res.json(item);
                next();
            }
        });
    }
};


exports.destroy = function(req, res, next) {
    if (req.params.id) {
        model.destroy(req.params.id, function(err, item) {
            if (err) {
                next(err);
            }
            else {
                //XXX jee_api does NOT return item on delete
                res.json(item);
            }
        });
    }
}
