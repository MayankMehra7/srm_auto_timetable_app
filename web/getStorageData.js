function getTimetableStringFromLocalStorage() {
    const timetableString = localStorage.getItem("timetable");
    if (timetableString) {
      return timetableString;
    } else {
      console.warn("Timetable data not found in localStorage");
      return ""; // Or return a default value if preferred
    }
  }
  