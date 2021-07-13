import api from "./api";

export default class StaffService {
  get(email, password) {
    return api.staff.post(`/profile`, { email, password });
  }
}