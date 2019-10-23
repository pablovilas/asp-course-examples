const Repository = require('./repository');

module.exports = class WeightRepository {
    constructor() {
        this.weightRepository = Repository.Weigth;
    }
    async findAll(limit, offset) {
        var query = this.weightRepository.find();
        if (limit) {
            query.limit(limit);
        }
        if (offset) {
            query.skip(offset);
        }
        let users = await query;
        return users.map((user) => user.toObject());
    }
    async save(data) {
        let user = await this.weightRepository.create(data);
        return user.toObject();
    }
    async findById(id) {
        try {
            let user = await this.weightRepository.findOne({ _id: id });
            return user ? user.toObject() : null;
        } catch (err) {
            return null;
        }
    }
}