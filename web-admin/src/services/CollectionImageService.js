import api from "./api";

export default class CollectionImageService {

  constructor() {
    var authToken = localStorage.getItem('authToken');
    this.auth = `Bearer ${authToken}`;
  }

  get(modelId) {
    return api.collection.get(`/${modelId}`, { headers: { Authorization: this.auth } });
  }

}