import api from "./api";

export default class ImageService {
  get(collectionId) {
    return api.image.get(`/${collectionId}`);
  }
}