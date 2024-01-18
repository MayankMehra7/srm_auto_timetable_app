function saveData(key, data) {
    localStorage.setItem(key, data);
    console.log(localStorage.getItem(key));
}