const Config = require('config');
const mongoose = require('mongoose');
const Weight = require('../models/weight');
const Schema = mongoose.Schema;

module.exports = class Repository {
    constructor() {
        this.connection = null;
    }
    static async connect() {
        this.connection = await mongoose.connect(this.getUrl(), { useNewUrlParser: true });
    }
    static async loadCollections() {
        const weightSchema = new Schema(Weight, { id: false });
        weightSchema.set('toObject', {
            transform: function (doc, ret) {
                ret.id = ret._id.toString();
                delete ret._id;
                delete ret.__v;
            }
        });
        module.exports.Weigth = this.connection.model('Weight', weightSchema);
    }
    static getUrl() {
        let connectionUrl = Config.get('repository.url');
        return connectionUrl;
    }
    static async initRepository() {
        try {
            await this.connect();
            await this.loadCollections();
        } catch (err) {
            console.log(`Error trying to connect to database: ${err}`);
        }
    }
}