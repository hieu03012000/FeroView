import axios from 'axios';

const baseUrl = 'http://localhost:12346/api/v1';

export default {
    model: axios.create({
        baseURL: baseUrl + '/models',
        timeout: 5000
    }),
    staff: axios.create({
        baseURL: baseUrl + '/staffs',
        timeout: 5000
    }),
    collection: axios.create({
        baseURL: baseUrl + '/collection-images',
        timeout: 5000
    }),
    image: axios.create({
        baseURL: baseUrl + '/images',
        timeout: 5000
    }),
}