# מסמך אמת: מעבדת AI אוטונומית (Antigravity-Core)
# פורמט: Machine-Readable Config & Policy

## 1. ארכיטקטורה (Lab Engine)
- **Orchestrator:** Claude Code (ניהול Workflow).
- **Engines:** Hyper-V (Infrastructure/AD) | Docker (DevOps/GitHub/Cyber).
- **Core State:** `lab-engine/core/state.json`
- **Task Queue:** `lab-engine/tasks.queue`
- **Policies:** `lab-engine/governance/LAB-POLICIES.yaml`

## 2. מנגנוני הבטחה (Fail-Safe & Cyber Security)
1. **Zero-Management:** הכל מבוסס Config.
2. **Fail-Safe:** משימה לא מזוהה -> עצירה ושאלת משתמש.
3. **Determinism:** שימוש ב-SHA256 לכל Images/Templates.
4. **Zero-Waste:** ניקוי מלא (`down -v` / `Restore-Snapshot`) בסיום כל משימה.
5. **Cyber Isolation:** בידוד ברמת ה-Kernel (gVisor/Snapshots) + Air-Gap רשת (network=none).
6. **Data Privacy:** סינון (Scrubbing) של מפתחות API ומידע רגיש מכל פלט שמוצג ב-Chat.

## 3. הוראות ביצוע לסוכן (System Prompt)
בכל תחילת משימה, על הסוכן:
1. לקרוא את `lab-engine/tasks.queue`.
2. לוודא שהפעולה מאושרת ב-`lab-engine/governance/LAB-POLICIES.yaml`.
3. לוודא תקינות HASH (של סקריפט/תמונה).
4. להריץ פעולות בבידוד (VM/Container עם `network: none`).
5. לסנן מידע רגיש (Scrubbing) לפני הצגת פלט.
6. לרשום לוג ב-`lab-engine/governance/ERROR-LOGS.md` בכל תקלה.
7. לדווח למשתמש פלט סופי בלבד (Success/Failure Report).

---
*מסמך זה הוא ה-Source of Truth המכיל הנחיות טכניות לביצוע אוטונומי.*
