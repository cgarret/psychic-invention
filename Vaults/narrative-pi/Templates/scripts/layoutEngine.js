function resolveDay(input) {
    if (input === undefined || input === null) {
        return new Date().getDay();
    }

    if (input instanceof Date) {
        return input.getDay();
    }

    if (typeof input === "number" && Number.isInteger(input) && input >= 0 && input <= 6) {
        return input;
    }

    if (typeof input === "string") {
        const parsedDate = new Date(input);
        if (!Number.isNaN(parsedDate.getTime())) {
            return parsedDate.getDay();
        }

        const normalizedDay = input.trim().toLowerCase();
        const dayLookup = {
            sunday: 0,
            monday: 1,
            tuesday: 2,
            wednesday: 3,
            thursday: 4,
            friday: 5,
            saturday: 6,
        };

        if (normalizedDay in dayLookup) {
            return dayLookup[normalizedDay];
        }
    }

    throw new TypeError("getDayLayout expects a Date, day index, date string, or day name.");
}

function getDayLayout(input) {
    const day = resolveDay(input);
    const isWeekend = day === 6 || day === 0;

    if (isWeekend) {
        return `## Weekend Rest & Recharge
- [ ] Read a book or relax
- [ ] Household chores & prep
- [ ] Passion project time`;
    } else {
        return `## Workday Productivity
- [ ] Review daily schedule & calendar
- [ ] Clear inbox to zero
- [ ] Focus Block 1 (Deep Work)
- [ ] Focus Block 2 (Admin tasks)`;
    }
}

module.exports = getDayLayout;
