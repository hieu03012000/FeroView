import api from "./api";

export default class ModelService {

  constructor() {
    var authToken = localStorage.getItem('authToken');
    this.auth = `Bearer ${authToken}`;
  }

  get() {
    return api.model.get();
  }

  getById(id) {
    return api.model.get('/' + id, { headers: { Authorization: this.auth } });
  }

  updateStatus(id, status) {
    return api.model.put(`/${id}/status/${status}`);
  }

  getTasks(id) {
    return api.model.get(`/${id}/tasks`, { headers: { Authorization: this.auth } });
  }

}