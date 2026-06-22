async function fetchTodoistTasks() {
    const API_TOKEN = "YOUR_TODOIST_API_TOKEN"; 
    const CACHE_PATH = "System/Cache/todoist_cache.json";
    
    // Helper function to safely read the local cache file
    async function readCache() {
        try {
            const file = app.vault.getAbstractFileByPath(CACHE_PATH);
            if (!file) return null;
            const content = await app.vault.read(file);
            return JSON.parse(content);
        } catch (e) {
            return null;
        }
    }

    // Helper function to safely write/update the local cache file
    async function writeCache(data) {
        try {
            let file = app.vault.getAbstractFileByPath(CACHE_PATH);
            const content = JSON.stringify(data, null, 2);
            if (file) {
                await app.vault.modify(file, content);
            } else {
                await app.vault.create(CACHE_PATH, content);
            }
        } catch (e) {
            // Silently fail if cache cannot write
        }
    }

    // --- STRATEGY: IF OFFLINE, LOAD CACHE ---
    if (!navigator.onLine) {
        const cached = await readCache();
        if (cached && cached.tasks) {
            let output = `> [!INFO] **Offline Mode:** Showing cached tasks from ${cached.timestamp}\n\n`;
            return output + cached.tasks.map(t => `- [ ] **${t}** *(Cached)*`).join("\n");
        }
        return "### 🔴 System Offline\n*No local cache available. Connect to internet.*";
    }

    // --- STRATEGY: IF ONLINE, FETCH & UPDATE CACHE ---
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
        if (!response.ok) throw new Error(`HTTP ${response.status}`);

        const tasks = await response.json();
        
        if (tasks.length === 0) {
            await writeCache({ timestamp: new Date().toLocaleString(), tasks: [] });
            return "* 🎉 No tasks due today!";
        }

        // Extract task names to save space
        const taskContents = tasks.map(task => task.content);
        
        // Update the cache background file
        await writeCache({
            timestamp: new Date().toLocaleString(),
            tasks: taskContents
        });

        return tasks.map(task => `- [ ] **${task.content}**`).join("\n");

    } catch (error) {
        clearTimeout(timeoutId);
        
        // Network timeout / Server crashed -> Fallback to cache
        const cached = await readCache();
        if (cached && cached.tasks) {
            let output = `> [!WARNING] **Connection Timeout:** Failed to fetch live data. Loaded cache from ${cached.timestamp}\n\n`;
            return output + cached.tasks.map(t => `- [ ] **${t}** *(Cached)*`).join("\n");
        }
        return `### ⚠️ API Unavailable\n*Error: ${error.message}*`;
    }
}
module.exports = fetchTodoistTasks;
