function getTimetableStringFromLocalStorage() {
  return localforage.getItem("timetable").then(timetableString => {
    // Resolve the promise with the retrieved timetable string
    if (timetableString) {
      return timetableString;
    } else {
      console.warn("Timetable data not found in localStorage");
      // Instead of returning an empty string, you can return a promise
      // that immediately rejects with an error message
      return Promise.reject(new Error("Timetable data not found"));
      // Alternatively, you can return a specific default value, 
      // but this might not be suitable in all cases
      // return "";
    }
  });
}
