async function fetchExternalData() {
    try {
        // Example: Fetching a random educational activity. 
        // Swap this with Spotify/Todoist URLs and headers as needed.
        const response = await fetch("https://apphost.io");
        if (!response.ok) return "Could not fetch API data.";
        
        const data = await response.json();
        return `* [ ] **Daily Challenge:** ${data.activity} (${data.type})`;
    } catch (error) {
        return `API Error: ${error.message}`;
    }
}
module.exports = fetchExternalData;
