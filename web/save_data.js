function saveData(key, data) {
    return localforage.setItem(key, data).then(() => {
      // Optional: Perform additional logic after successful save
      console.log('Data saved successfully for key:', key);
    }).catch(error => {
      // Handle any errors thrown while saving
      console.error('Error saving data:', error);
    });
  }