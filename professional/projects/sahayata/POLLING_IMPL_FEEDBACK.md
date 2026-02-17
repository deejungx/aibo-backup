# Agent-API Polling Implementation - Feedback & Improvements

**Date:** Feb 17, 2026  
**Context:** Feedback on implement-polling PR (Feb 12)  
**Constraint:** Must keep 50ms polling (users need prompt replies, can't use exponential backoff)

---

## Current Implementation Status

The PR successfully moved from synchronous blocking to async background processing with polling. Good foundation.

**What works:**
- Non-blocking returns (202 Accepted + task_id)
- Fast polling (50ms) enables quick user feedback
- Observable status via `/crew-task/{task_id}`
- Resilient to task failures

**Critical constraints:**
- User replies must be prompt (no exponential backoff)
- Task sends reply to user + saves to session history
- Cannot sacrifice UX for load optimization

---

## Recommended Improvements (Ranked by Impact)

### 1. **Retry Logic with Immediate Retries** (HIGH PRIORITY)
- **Problem:** If `process_agent_response()` fails, response is lost silently
- **Solution:** Retry immediately (no backoff) on failure
- **Implementation:**
  ```python
  @retry(max_retries=3, wait_fixed=0)  # Retry IMMEDIATELY
  def process_agent_response(assistant_message, user_id, agent_id):
      # If send fails, retry instantly without delay
  ```

### 2. **Task Result TTL / Cleanup** (HIGH PRIORITY)
- **Problem:** Completed tasks accumulate in Redis forever → memory bloat
- **Solution:** Auto-expire results after 1 hour
- **Implementation:**
  ```python
  celery_app.conf.update(result_expires=3600)  # Auto-cleanup after 1h
  ```

### 3. **Circuit Breaker for Telerivet** (MEDIUM PRIORITY)
- **Problem:** If Telerivet API is down, keeps retrying → cascading failures
- **Solution:** Fail fast, then back off (circuit breaker pattern)
- **Implementation:** Use `pybreaker` library to detect API outages and fail quickly
- **Benefit:** Prevents retry storm, allows graceful degradation

### 4. **Better Error Handling & User Feedback** (MEDIUM PRIORITY)
- **Problem:** Silent failures or timeouts leave users hanging
- **Solution:** Return error status + message to user
- **Implementation:**
  ```python
  try:
      assistant_message = await wait_for_result(task_id, timeout=30)
  except TimeoutError:
      send_error_to_user(user_id, "Agent took too long, please try again")
  except Exception as e:
      send_error_to_user(user_id, f"Error: {e}")
  ```

### 5. **Max Poll Iterations Safety** (LOW PRIORITY)
- **Problem:** Task could theoretically poll infinitely
- **Solution:** Cap iterations (600 * 50ms = 30s max)
- **Implementation:**
  ```python
  max_polls = 600  # 30 seconds max
  if polls >= max_polls:
      raise TimeoutError("Task exceeded max polls")
  ```

### 6. **Logging & Metrics** (LOW PRIORITY)
- **Problem:** No observability into polling behavior
- **Solution:** Track: avg task time, timeout rate, failure rate by agent
- **Implementation:** Log start/end times, emit metrics to monitoring system

---

## Long-Term Consideration

**Increase timeout to 60s** (from 30s) to give agents more breathing room without hurting UX:
- 50ms polling is fast enough for user perception
- 60s timeout gives better reliability under load

---

## What NOT to Do

❌ Exponential backoff — Kills user-facing latency  
❌ Longer polling intervals — Slows down user feedback  
❌ Remove polling for webhooks only — Less reliable for MVP

---

## Implementation Priority

**Phase 1 (This sprint):**
1. Retry logic (immediate)
2. Task TTL cleanup
3. Error handling for users

**Phase 2 (Next sprint):**
4. Circuit breaker for Telerivet
5. Metrics/logging

**Phase 3 (Later):**
6. Max poll iterations
7. Increase timeout to 60s after load testing

---

## Notes

- Looza (engineer) should review retry logic implementation
- Test under load (1000+ concurrent tasks) before increasing timeout
- Monitor Telerivet outages to justify circuit breaker
