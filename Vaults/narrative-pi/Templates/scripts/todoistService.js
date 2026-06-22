async function fetchTodoistTasks() {
    const API_TOKEN = "YOUR_TODOIST_API_TOKEN"; 
    
    // Fallback 1: Immediate offline check
    if (!navigator.onLine) {
        return "### 🔴 System Offline\n* [ ] *Review local daily notes panel for urgent priorities.*";
    }

    // Set up a 3-second timeout controller so the script doesn't hang
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), 3000);

    try {
        const response = await fetch("https://todoist.com", {
            method: "GET",
            headers: {
                "Authorization": `Bearer ${API_TOKEN}`,
                "Content-Type": "application/json"
            },
            signal: controller.signal
        });

        clearTimeout(timeoutId);

        if (!response.ok) throw new Error(`HTTP Error Status: ${response.status}`);

        const tasks = await response.json();
        if (tasks.length === 0) return "* 🎉 No tasks due today!";

        return tasks.map(task => `- [ ] **${task.content}**`).join("\n");

    } catch (error) {
        clearTimeout(timeoutId);
        
        // Fallback 2: Handle timeouts or server errors gracefully
        if (error.name === 'AbortError') {
            return "### ⏳ Connection Timeout\n* [ ] *API took too long to respond. Check tasks manually on your phone.*";
        }
        return `### ⚠️ API Unavailable\n* *Error: ${error.message}*\n- [ ] Focus on backlog items inside your local vault.`;
    }
}
module.exports = fetchTodoistTasks;
