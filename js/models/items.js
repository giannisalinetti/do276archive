var Sequelize = require("sequelize");

var Item = undefined;

module.exports.connect = function(params, callback) {
    var sequlz = new Sequelize(
        params.dbname, params.username, params.password,
        params.params);
    Item = sequlz.define('Item', {
        id: { type: Sequelize.BIGINT,
            primaryKey: true, unique: true, allowNull: false,
            autoIncrement: true },
        description: { type: Sequelize.STRING,
            allowNull: true },
        done: { type: Sequelize.BOOLEAN,
            allowNull: true }
    }, {
        timestamps: false,
        freezeTableName: true
    });
    // drop and create tables, better done globally
    /*
    Item.sync({ force: true }).then(function() {
        callback();
    }).error(function(err) {
        callback(err);
    });
    */
}

exports.disconnect = function(callback) {
    //XXX shouln'd to something to close or release the db connection?
    callback();
}

exports.create = function(description, done, callback) {
    Item.create({
        //id: id,
        description: description,
        done: done
    }).then(function(item) {
        callback(null, item);
    }).error(function(err) {
        callback(err);
    });
}

exports.update = function(key, description, done, callback) {
    Item.find({ where:{ id: key } }).then(function(item) {
        if (!item) {
            callback(new Error("Nothing found for key " + key));
        }
        else {
            item.updateAttributes({
                description: description,
                done: done
            }).then(function() {
                callback(null, item);
            }).error(function(err) {
                callback(err);
            });
        }
    }).error(function(err) {
        callback(err);
    });
}


exports.read = function(key, callback) {
    Item.find({ where:{ id: key } }).then(function(item) {
        if (!item) {
            callback(new Error("Nothing found for key " + key));
        }
        else {
            //XXX why recreating the item object?
            callback(null, {
                id: item.id,
                description: item.description,
                done: item.done
            });
        }
    }).error(function(err) {
        callback(err);
    });
}

exports.destroy = function(key, callback) {
    Item.find({ where:{ id: key } }).then(function(item) {
        if (!item) {
            callback(new Error("Nothing found for " + key));
        }
        else {
            item.destroy().then(function() {
                callback(null, item);
            }).error(function(err) {
                callback(err);
            });
        }
    }).error(function(err) {
        callback(err);
    });
}

exports.listAll = function(callback) {
    Item.findAll().then(function(items) {
        var theitems = [];
        items.forEach(function(item) {
            //XXX why recreating the item objects for theitems?
            theitems.push({
                id: item.id, description: item.description, done: item.done });
        });
        callback(null, theitems);
    }).error(function(err) {
        callback(err);
    });
}

