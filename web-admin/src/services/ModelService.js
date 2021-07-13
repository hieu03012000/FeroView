import api from "./api";

export default class ModelService {
  get() {
    return api.model.get();
  }

  getById(id) {
    return api.model.get('/' + id);
  }

  updateStatus(id, status) {
    return api.model.put(`/${id}/status/${status}`);
  }
  
  getTasks(id) {
    return api.model.get(`/${id}/tasks`);
  }

}