const WeightRepository = require('../repositories/weightRepository');

module.exports = class WeightService {
    constructor() {
        this.weightRepository = new WeightRepository();
    }
    async findAll(limit, offset) {
        return await this.weightRepository.findAll(limit, offset);
    }
    async save(data) {
        return await this.weightRepository.save(data);
    }
    async findById(id) {
        return await this.weightRepository.findById(id);
    }
}