import api from "./api";

export default class ImageService {

  constructor() {
    var authToken = localStorage.getItem('authToken');
    this.auth = `Bearer ${authToken}`;
  }

  get(collectionId) {
    return api.image.get(`/${collectionId}`, { headers: { Authorization: this.auth } });
  }
}