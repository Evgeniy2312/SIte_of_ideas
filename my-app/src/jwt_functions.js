
export function setToken(token) {
    localStorage.setItem("token", token);
    localStorage.setItem("lastLoginTime", new Date(Date.now()).getTime());
}
export function getToken() {
    let now = new Date(Date.now()).getTime();
    let sixtyMinutes = 1000 * 60 * 60;
    let timeSinceLastLogin = now - localStorage.getItem("lastLoginTime");
    if (timeSinceLastLogin < sixtyMinutes) {
        return localStorage.getItem("token");
    } else {
        localStorage.removeItem("token");
        localStorage.removeItem("currentUser");
        localStorage.removeItem("lastLoginTime");
    }
}