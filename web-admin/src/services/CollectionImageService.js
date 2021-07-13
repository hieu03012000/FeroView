import api from "./api";

export default class CollectionImageService {

  get(modelId) {
    return api.collection.get(`/${modelId}`);
  }

}