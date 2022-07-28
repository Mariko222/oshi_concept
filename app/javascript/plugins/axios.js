import axios from 'axios'

const production = "https://oshi-concept.herokuapp.com";
const development = "http://127.0.0.1:3000";
const url = process.env.NODE_ENV === "production" ? production : development;

const axiosInstance = axios.create({ baseURL: `${url}/api/` });

axiosInstance.defaults.xsrfCookieName = "CSRF-TOKEN";
axiosInstance.defaults.xsrfHeaderName = "X-CSRF-Token";
axiosInstance.defaults.withCredentials = true;


if (localStorage.auth_token) {
  axiosInstance.defaults.headers.common['Authorization'] = `Bearer ${localStorage.auth_token}`
}

export default axiosInstance
