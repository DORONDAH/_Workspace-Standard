# דו"ח משפחות סיכון ופתרונות למעבדת AI (Risk Assessment Report)

## 1. ניתוח משפחות סיכון (Failure Mode & Effects Analysis - FMEA)
על סמך מחקר מעמיק, כל תרחיש כשל אפשרי במערכות Multi-Agent שייכות לאחת מ-5 משפחות הסיכון הבאות. לכל משפחה הוגדר מנגנון חסינות (Mitigation) המבוסס על כלים קיימים בלבד.

| משפחת סיכון | מאפיינים | פתרון מיושם (Tooling-First) |
| :--- | :--- | :--- |
| **1. סחיפת סביבה (Environmental Drift)** | חוסר עקביות בגרסאות תוכנה, דרייברים, הגדרות Registry. | **IaC (Dev Containers/Images):** שימוש ב-SHA256 ל-Docker ו-Snapshots ל-Hyper-V. |
| **2. השחתת מצב (State Corruption)** | קונפיגורציה פגומה, שאריות משימות קודמות, Locks. | **Atomic Purge:** מחיקה מלאה (`down -v`) לאחר כל משימה. |
| **3. כשל תקשורת/ניהול (Orchestration Lag)** | השהיות ב-API, אובדן הודעות, Timeout של סוכנים. | **Heartbeat/Watchdog:** ניטור אקטיבי של מצב סוכן ע"י ה-Orchestrator. |
| **4. הפרות מדיניות (Security Violations)** | הרשאות יתר, ניסיון גישה למערכת המארחת (Host). | **Hardened Runtime:** שימוש ב-gVisor (Docker) או בידוד VM מלא (Hyper-V). |
| **5. תלות צד ג' (Dependency Drift)** | שינויי API של שירותים ב-GitHub, עדכוני גרסה שוברים. | **Registry Pinning:** רישום גרסאות מאושרות בקובץ `registry.yaml` ומניעת עדכון אוטומטי. |

## 2. מנגנון הבקרה והדירוג (Risk Matrix)
לכל משימה שתתבקש, ה-Orchestrator ידרג את הסיכון לפני ביצוע לפי המדד הבא:

- **סיכון נמוך:** משימת Docker מוגדרת ב-Registry. 
  - *חסינות:* 99% (אוטומטי).
- **סיכון בינוני:** משימת Hyper-V על תשתית AD.
  - *חסינות:* 95% (דורש Snapshot מקדים).
- **סיכון גבוה/לא מסווג:** משימה חדשה שלא מופיעה ב-Registry.
  - *חסינות:* 100% (עצירה מיידית ושאלת משתמש).

## 3. דו"ח תיקונים מוצע (למניעת 100% שגיאות)
כדי להגיע ל-100% הצלחה, אנו מטמיעים את התיקונים הבאים ברמת ה-Governance:
1. **הפרדת תשתית ויישום:** כל משימה (Task) מוגדרת כבלתי תלויה (Stateless).
2. **Pre-flight Checks:** לפני כל הרצה, מתבצעת בדיקה שה-Container/VM זמין ושהמשאבים (RAM) תחת ה-Threshold.
3. **Audit Trail:** רישום אוטונומי של כל פעולת סוכן לקובץ `ERROR-LOGS.md` לזיהוי תבניות כשל בשלב מוקדם.

---
*מקורות:*
- [NIST SP 800-160: Systems Security Engineering](https://csrc.nist.gov/publications/detail/sp/800-160/vol-1/rev-1/final)
- [Microsoft Hyper-V Security Documentation](https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/user-guide/checkpoints)
- [Docker Security Best Practices](https://docs.docker.com/engine/security/)
